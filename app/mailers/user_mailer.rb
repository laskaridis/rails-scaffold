class UserMailer < ApplicationMailer

  def change_password(user)
    @user = user
    mail(
      from: ::Configuration.configuration.mailer_sender,
      to: @user.email,
      subject: t('mailer.change_password.subject')
    )
  end

  def confirm_email(user)
    @user = user
    mail(
      from: ::Configuration.configuration.mailer_sender,
      to: @user.email,
      subject: t('mailer.verify_email.subject')
    )
  end
end
