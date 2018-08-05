require 'brickftp/request'
require 'json'

module Brickftp
  # perform User's ApiKey's action
  class ApiKey
    def self.list(id)
      Brickftp::Request.new('users').list_api_keys(id)
    end

    def self.show(id)
      Brickftp::Request.new('api_keys').show(id)
    end

    def self.create(id, options = {})
      Brickftp::Request.new('users').post_api_key(id, options)
    end

    def self.delete(id)
      Brickftp::Request.new('api_keys').delete(id)    
    end
  end
end
