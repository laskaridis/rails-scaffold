class UserMailer < ActionMailer::Base

  def change_password(user)
    @user = user
    mail(
      from: ::Configuration.configuration.mailer_sender,
      to: @user.email,
      subject: "Change password"
    )
  end

  def confirm_email(user)
    @user = user
    mail(
      from: ::Configuration.configuration.mailer_sender,
      to: @user.email,
      subject: "Confirm email"
    )
  end
end
