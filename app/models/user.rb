class User < ApplicationRecord
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :confirmable,
         :lockable

  belongs_to :country, optional: true
  belongs_to :currency, optional: true
  belongs_to :language, optional: true
  has_one :organization, inverse_of: :user

  validates :gender, inclusion: { in: %w(Male Female) }, allow_blank: true
  validates :email, presence: true, email: { strict_mode: true }, uniqueness: { case_sensitive: true }
  validates :password, presence: true, on: :create
end
