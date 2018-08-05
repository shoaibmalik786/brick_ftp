require 'brickftp/request'
require 'json'

module Brickftp
  # perform User's PublicApiKey's action
  class PublicKey
    def self.list(id)
      Brickftp::Request.new('users').list_public_keys(id)
    end

    def self.show(id)
      Brickftp::Request.new('public_keys').show(id)
    end

    def self.create(id, options = {})
      Brickftp::Request.new('users').post_public_api_key(id, options)
    end

    def self.delete(id)
      Brickftp::Request.new('public_keys').delete(id)    
    end
  end
end
