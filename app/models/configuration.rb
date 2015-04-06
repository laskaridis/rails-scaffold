
class Configuration

  attr_accessor :email_confirmation_expiration
  attr_accessor :password_change_expiration
  attr_accessor :mailer_sender

  def initialize(opts={})
    @email_confirmation_expiration = 
      opts[:email_confirmation_expiration] || 24
    @password_change_expiration = 
      opts[:password_change_expiration] || 24
    @mailer_sender =
      opts[:mailer_sender] || 'noreply@company.com'
  end

  class << self

    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield configuration
    end
  end
end
