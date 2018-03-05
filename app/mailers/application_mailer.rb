class ApplicationMailer < ActionMailer::Base
  default from: ::Configuration.configuration.mailer_sender
  layout 'mailer'
end
