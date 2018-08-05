require 'brickftp/request'
require 'json'

module Brickftp
  # perform Notification's Api
  class Bundle
    def self.list
      Brickftp::Request.new('bundles').list
    end

    def self.create(options = {})
      Brickftp::Request.new('bundles').post(options)
    end

    def self.show(id)
      Brickftp::Request.new('bundles').show(id)    
    end    

    def self.delete(id)
      Brickftp::Request.new('bundles').delete(id)    
    end

    def self.contents(path = nil, options = {})
      Brickftp::Request.new('bundles').list_contents(path, options)    
    end

    def self.download(options = {})
      Brickftp::Request.new('bundles').download(options)    
    end   

    def self.download_zip(options = {})
      Brickftp::Request.new('bundles').download_zip(options)    
    end       
  end
end
