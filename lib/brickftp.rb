require 'brickftp/version'
require 'brickftp/user'
require 'brickftp/api_key'
require 'brickftp/public_key'
require 'brickftp/group'
require 'brickftp/permission'
require 'brickftp/notification'
require 'brickftp/history'
require 'brickftp/bundle'
require 'brickftp/behavior'
require 'brickftp/folder'
require 'brickftp/upload'
require 'brickftp/session'

# Gem configuration module
module Brickftp
  # Exception class
  class BrickftpException < StandardError; end

  # Constants
  USER_AGENT = 'Brickftp/' + VERSION

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
