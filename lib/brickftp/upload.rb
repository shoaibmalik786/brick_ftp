require 'brickftp/request'
require 'json'

module Brickftp
  # perform Upload's action
  class Upload
    def self.start(path_and_filename, option = {})
      Brickftp::Request.new('files').start_new_upload(path_and_filename, option)
    end

    def self.uploading(upload_uri, data)
      Brickftp::Request.new('files').uploading(upload_uri, data)
    end

    def self.request_additional(path_and_filename, option = {})
      Brickftp::Request.new('files').request_additional_url(path_and_filename, option)
    end

    def self.complete(path_and_filename, option = {})
      Brickftp::Request.new('files').completing_an_upload(path_and_filename, option)
    end            
  end
end
