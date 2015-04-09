class Token

  def self.new
    SecureRandom.hex(20)
  end
end
