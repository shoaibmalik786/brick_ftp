require 'brickftp/request'
require 'json'

module Brickftp
  # perform Permission's Api
  class Permission
    def self.list
      Brickftp::Request.new('permissions').list
    end

    def self.create(options = {})
      Brickftp::Request.new('permissions').post(options)
    end

    def self.delete(id)
      Brickftp::Request.new('permissions').delete(id)    
    end
  end
end
