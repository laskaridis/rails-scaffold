require 'bcrypt'

class User < ApplicationRecord
  attr_reader :password
  belongs_to :country, optional: true
  belongs_to :currency, optional: true
  belongs_to :language, optional: true
  validates :gender, inclusion: { in: %w(Male Female) }, allow_blank: true
  validates :email, presence: true, email: { strict_mode: true }, uniqueness: { case_sensitive: true }
  validates :password, presence: true, on: :create
  before_validation :normalize_email
  after_create :generate_email_confirmation_token

  public

  class << self

    def authenticate(email, password)
      if user = find_by_email(User.normalize_email(email))
        if password.present? && user.authenticated?(password)
          return user
        end
      end
    end

    def normalize_email(email)
      email.to_s.downcase.gsub(/\s+/, "")
    end
  end

  public

  def authenticated?(password)
    if encrypted_password.present?
      BCrypt::Password.new(encrypted_password) == password
    end
  end

  def password=(new_password)
    @password = new_password

    if new_password.present?
      self.encrypted_password = encrypt(new_password)
    end
  end

  def confirm_email
    unless email_confirmed?
      if email_confirmation_expired?
        return false
      else
        self.email_confirmed_at = DateTime.now
        save!
      end
    end
  end

  def email_confirmed?
    email_confirmed_at.present?
  end

  def email_confirmation_expired?
    config = Configuration.configuration
    expires_at = 
      email_confirmation_requested_at + 
      config.email_confirmation_expiration.hours

    DateTime.now > expires_at
  end

  def reset_email_confirmation_token
    unless email_confirmed?
      generate_email_confirmation_token
    end
  end

  def forgot_password
    generate_password_change_token
  end

  def change_password(new_password)
    if password_change_expired?
      generate_password_change_token
      return false
    end

    self.password = new_password
    self.password_changed_at = DateTime.now
    save
  end

  def password_change_pending?
    password_change_requested_at.present? && password_changed_at.nil?
  end

  def password_change_expired?
    unless password_change_pending?
      raise 'No password change pending'
    end

    config = Configuration.configuration
    expires_at =
      password_change_requested_at +
      config.password_change_expiration.hours

    DateTime.now > expires_at
  end

  def generate_password_change_token
    self.password_change_token = Token.new
    self.password_change_requested_at = DateTime.now
    self.password_changed_at = nil
    self.save!
    send_change_password_email
  end

  def generate_email_confirmation_token
    unless email_confirmed?
      self.email_confirmation_token = Token.new
      self.email_confirmation_requested_at = DateTime.now
      save!

      send_email_confirmation_email
    end
  end

  private

  def send_change_password_email
    UserMailer.change_password(self).
      deliver_later(queue: 'change_password_email')
  end

  def send_email_confirmation_email
    UserMailer.confirm_email(self).
      deliver_later(queue: 'confirm_email_email')
  end

  def encrypt(password)
    cost = Rails.env.test? ?
      BCrypt::Engine::MIN_COST :
      BCrypt::Engine::DEFAULT_COST

    BCrypt::Password.create(password, cost: cost)
  end

  def normalize_email
    self.email = User.normalize_email(email)
  end
end
