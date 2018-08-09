class Configuration
  attr_accessor :mailer_sender

  def initialize(opts={})
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
