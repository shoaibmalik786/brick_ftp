require 'brick_ftp/version'
require 'brick_ftp/user'

# Gem configuration module
module BrickFtp
  # Exception class
  class BrickFtpException < StandardError; end

  # Constants
  USER_AGENT = 'BrickFtp/' + VERSION

  # Gem configuration
  class Configuration
    attr_accessor :api_key, :subdomain

    def initialize
      self.api_key = nil
      self.subdomain = nil
    end
  end

  # class << self
  #   attr_accessor :configuration
  # end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration) if block_given?
  end
end
