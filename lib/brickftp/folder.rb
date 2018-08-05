require 'brickftp/request'
require 'json'

module Brickftp
  #delete recursively files within a folder
  class DeleteRecrFolderRequest
    def initialize(entity_name = nil)
      @headers = { 'User-Agent' => Brickftp::USER_AGENT }
      @headers['Content-Type']  = 'application/json'
      @entity_name = entity_name
      @api_url = "https://#{Brickftp.configuration.subdomain}.brickftp.com/api/rest/v1/"
      auth = 'Basic ' + Base64.strict_encode64("#{Brickftp.configuration.api_key}:x").chomp
      @headers['Authorization'] = auth
      @headers['Depth'] = "infinity" # to delete recursively folder contents 
    end

    def delete(id)
      request :delete, "#{@api_url}#{@entity_name}/#{id}"
    end

    def request(method, url, data = {})
      result = nil
      RestClient::Request.execute(method: method, url: url,
                                  payload: data.to_json,
                                  timeout: 60, headers: @headers) do |response|
        result = JSON.parse(response.body)
        if !result.class.to_s.eql?('Array') && result['error']
          raise Brickftp::BrickftpException, result['error']
        end
      end
      result
    end        
  end


  # perform File and Folder's action
  class Folder
    def self.list(path)
      Brickftp::Request.new('folders').list_folder_contents(path)
    end

    def self.create(path_and_folder_name)
      Brickftp::Request.new('folders').create_folder(path_and_folder_name)
    end

    def self.count_contents(path_and_folder_name)
      Brickftp::Request.new('folders').count_folder_contents(path_and_folder_name)
    end

    def self.count_nrs_contents(path_and_folder_name)
      Brickftp::Request.new('folders').count_nrs_folder_contents(path_and_folder_name)
    end

    def self.size(path_and_folder_name)
      Brickftp::Request.new('folders').folder_size(path_and_folder_name)
    end

    def self.download_file(path_and_filename)
      Brickftp::Request.new('files').download_file(path_and_filename)
    end

    def self.move_or_rename(path_and_filename, options = {})
      Brickftp::Request.new('files').move_or_rename_file_folder(path_and_filename, options)
    end  

    def self.copy(path_and_filename, options = {})
      Brickftp::Request.new('files').copy(path_and_filename, options)
    end

    def self.delete(path_and_filename)
      Brickftp::Request.new('files').delete(path_and_filename)
    end 

    def self.depth_delete(path_and_filename)
      Brickftp::DeleteRecrFolderRequest.new('files').delete(path_and_filename)
    end                               
  end
end
