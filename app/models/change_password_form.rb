class ChangePasswordForm
  include ActiveModel::Model
  attr_accessor :old_password, :password, :password_confirmation
  validates :old_password, presence: true
  validates :password, presence: true, confirmation: true
  validates :password_confirmation, presence: true
  validate :correct_old_password

  def initialize(user)
    @user = user
  end

  def perform(params = {})
    self.old_password = params[:old_password]
    self.password = params[:password]
    self.password_confirmation = params[:password_confirmation]

    if valid?
      @user.password = password
      @user.password_changed_at = Time.zone.now
      @user.save!
      true
    else
      false
    end
  end

  def persisted?
    false
  end

  private

  def correct_old_password
    return if old_password.nil?

    unless @user.authenticated? old_password
      errors[:old_password] << I18n.t('errors.old_password_incorrect')
    end
  end
end
