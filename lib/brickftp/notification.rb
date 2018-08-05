require 'brickftp/request'
require 'json'

module Brickftp
  # perform Notification's Api
  class Notification
    def self.list
      Brickftp::Request.new('notifications').list
    end

    def self.create(options = {})
      Brickftp::Request.new('notifications').post(options)
    end

    def self.delete(id)
      Brickftp::Request.new('notifications').delete(id)    
    end
  end
end
