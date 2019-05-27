class User < ApplicationRecord
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :confirmable,
         :lockable,
         :omniauthable,
         omniauth_providers: %i[google_oauth2]

  belongs_to :country, optional: true
  belongs_to :currency, optional: true
  belongs_to :language, optional: true
  has_many   :notifications

  validates :gender, inclusion: { in: %w(Male Female) }, allow_blank: true
  validates :email, presence: true, email: { strict_mode: true }, uniqueness: { case_sensitive: true }
  validates :password, presence: true, on: :create

  def self.find_or_create_from_omniauth(auth)
    where(email: auth.info.email).first_or_create do |user|
      user.provider = auth.provider
      user.password = Devise.friendly_token[0,20]
      user.currency = Currency.default
      user.language = Language.default
      user.skip_confirmation!
    end
  end

  def localization_settings
    LocalizationSettings.new(country: country, currency: currency, language: language)
  end
end
