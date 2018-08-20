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
require 'brickftp/api/base'
require 'brickftp/api_definition'
require 'brickftp/upload'
require 'brickftp/session'
require 'brickftp/request'
require 'brickftp/http_client'
require 'brickftp/utils/chunk_io'
require 'logger'

# Gem configuration module
module Brickftp
  # Exception class
  class BrickftpException < StandardError; end

  # Constants
  USER_AGENT = 'Brickftp/' + VERSION

  # Gem configuration
  class Configuration
    attr_accessor :api_key, :subdomain, :logger, :log_level, :log_formatter

    def initialize
      self.api_key = nil
      self.subdomain = nil
      self.logger = Logger.new(STDOUT)
      self.log_level = Logger::WARN
      self.log_formatter = Logger::Formatter.new
      logger.level = log_level
    end

    def log_level=(level)
      @log_level = level
      logger.level = @log_level
    end

    # Set log formatter to logger object.
    # @param formatter [Logger::Formatter]
    def log_formatter=(formatter)
      @log_formatter = formatter
      logger.formatter = @log_formatter
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

  def self.logger
    configuration.logger
  end
end
