class DeleteAccountForm
  include ActiveModel::Model

  attr_accessor :email

  validates :email, presence: true
  validate :email_matches_account

  def initialize(user)
    @user = user
  end

  def perform(params = {})
    self.email = params[:email]
    return @user.destroy if valid?
  end

  def persisted?
    false
  end

  private

  def email_matches_account
    if email.present? && @user.email != email
      errors[:email] << I18n.t("errors.delete_account")
    end
  end
end

