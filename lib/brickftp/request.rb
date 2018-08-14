require 'rest_client'

module Brickftp
  # class to interact with api call
  class Request
    def initialize(entity_name = nil)
      @headers = { 'User-Agent' => Brickftp::USER_AGENT }
      @headers['Content-Type']  = 'application/json'
      @entity_name = entity_name
      @api_url = "https://#{Brickftp.configuration.subdomain}.brickftp.com/api/rest/v1/"
      auth = 'Basic ' + Base64.strict_encode64("#{Brickftp.configuration.api_key}:x").chomp
      @headers['Authorization'] = auth
    end
    
    #User's Api Requests

    def post(data = {})
      request :post, "#{@api_url}#{@entity_name}", data
    end

    def count
      request :get, "#{@api_url}#{@entity_name}?action=count"
    end

    def search(field, keyword)
      request :get, "#{@api_url}#{@entity_name}?q[#{field}]=#{keyword}"
    end

    def list(page = nil, per_page = nil)
      request :get, "#{@api_url}#{@entity_name}?page=#{page}&per_page=#{per_page}"
    end

    def show(id)
      request :get, "#{@api_url}#{@entity_name}/#{id}"
    end

    def put(id, data = {})
      request :put, "#{@api_url}#{@entity_name}/#{id}", data
    end

    def delete(id)
      request :delete, "#{@api_url}#{@entity_name}/#{id}"
    end

    def unlock(id)
      request :post, "#{@api_url}#{@entity_name}/#{id}/unlock"
    end

    #User's Api Key's Api Requests

    def list_api_keys(id)
      request :get, "#{@api_url}#{@entity_name}/#{id}/api_keys"
    end

    def post_api_key(id, data = {})
      request :post, "#{@api_url}#{@entity_name}/#{id}/api_keys", data
    end

    #User's Public key's Api Request

    def list_public_keys(id)
      request :get, "#{@api_url}#{@entity_name}/#{id}/public_keys"
    end

    def post_public_api_key(id, data = {})
      request :post, "#{@api_url}#{@entity_name}/#{id}/public_keys", data
    end

    #Group Api Requests

    def create_user_in_group(group_id, data = {})
      request :post, "#{@api_url}#{@entity_name}/#{group_id}/users", data
    end

    def add_member_to_group(grpup_id, user_id, data = {})
      request :put, "#{@api_url}#{@entity_name}/#{grpup_id}/memberships/#{user_id}", data
    end

    def update_member_to_group(grpup_id, user_id, data = {})
      request :patch, "#{@api_url}#{@entity_name}/#{grpup_id}/memberships/#{user_id}", data
    end 

    def delete_member_to_group(group_id, user_id)
      request :delete, "#{@api_url}#{@entity_name}/#{group_id}/memberships/#{user_id}"
    end

    #History's Api Requests

    def site_history(page= nil, per_page = nil, start_at = nil)
      if start_at.present?
        request :get, "#{@api_url}#{@entity_name}?page=#{page}&per_page=#{per_page}&start_at=#{start_at}"
      else
        request :get, "#{@api_url}#{@entity_name}?page=#{page}&per_page=#{per_page}"
      end
    end

    def login_history(page= nil, per_page = nil, start_at = nil)
      if start_at.present?
        request :get, "#{@api_url}#{@entity_name}/login?page=#{page}&per_page=#{per_page}&start_at=#{start_at}"
      else
        request :get, "#{@api_url}#{@entity_name}/login?page=#{page}&per_page=#{per_page}"
      end
    end

    def user_history(user_id, page= nil, per_page = nil, start_at = nil)
      if start_at.present?
        request :get, "#{@api_url}#{@entity_name}/users/#{user_id}?page=#{page}&per_page=#{per_page}&start_at=#{start_at}"
      else
        request :get, "#{@api_url}#{@entity_name}/users/#{user_id}?page=#{page}&per_page=#{per_page}"
      end
    end 

    def folder_history(path, page= nil, per_page = nil, start_at = nil)
      if start_at.present?
        request :get, "#{@api_url}#{@entity_name}/folders/#{path}?page=#{page}&per_page=#{per_page}&start_at=#{start_at}"
      else
        request :get, "#{@api_url}#{@entity_name}/folders/#{path}?page=#{page}&per_page=#{per_page}"
      end
    end

    def file_history(path, page= nil, per_page = nil, start_at = nil)
      if start_at.present?
        request :get, "#{@api_url}#{@entity_name}/files/#{path}?page=#{page}&per_page=#{per_page}&start_at=#{start_at}"
      else
        request :get, "#{@api_url}#{@entity_name}/files/#{path}?page=#{page}&per_page=#{per_page}"
      end
    end

    #Bundle's Api Requests

    def list_contents(path = nil, data = {})
      unless path.blank?
        request :post, "#{@api_url}#{@entity_name}/contents/#{path}", data
      else
        request :post, "#{@api_url}#{@entity_name}/contents", data
      end
    end

    def download(data = {})
      request :post, "#{@api_url}#{@entity_name}/download", data
    end

    def download_zip(data = {})
      request :post, "#{@api_url}#{@entity_name}/zip", data
    end 

    #Behavior Api's requests

    def update_behavior(id, data = {})
      request :patch, "#{@api_url}#{@entity_name}/#{id}", data
    end

    def list_folder(path)
      request :get, "#{@api_url}#{@entity_name}/folders/#{path}"
    end 

    #File and Folder Api
    def create_folder(path_and_folder_name)
      request :post, "#{@api_url}#{@entity_name}/#{path_and_folder_name}"
    end

    def count_folder_contents(path_and_folder_name)
      request :get, "#{@api_url}#{@entity_name}/#{path_and_folder_name}?action=count"
    end

    def count_nrs_folder_contents(path_and_folder_name)
      request :get, "#{@api_url}#{@entity_name}/#{path_and_folder_name}?action=count_nrs"
    end 

    def folder_size(path_and_folder_name)
      request :get, "#{@api_url}#{@entity_name}/#{path_and_folder_name}?action=size"
    end

    def download_file(path_and_filename)
      request :get, "#{@api_url}#{@entity_name}/#{path_and_filename}"
    end

    def move_or_rename_file_folder(path_and_filename, data = {})
      request :post, "#{@api_url}#{@entity_name}/#{path_and_filename}", data
    end

    def copy(path_and_filename, data = {})
      request :post, "#{@api_url}#{@entity_name}/#{path_and_filename}", data
    end


    def list_folder_contents(path)
      request :get, "#{@api_url}#{@entity_name}/#{path}"
    end

    def start_new_upload(path_and_filename, data = {})
      request :post, "#{@api_url}#{@entity_name}/#{path_and_filename}", data
    end

    def uploading(upload_uri, data)
      request :post, "#{upload_uri}", data
    end

    def request_additional_url(path_and_filename, data = {})
      request :post, "#{@api_url}#{@entity_name}/#{path_and_filename}", data
    end

    def completing_an_upload(path_and_filename, data = {})
      request :post, "#{@api_url}#{@entity_name}/#{path_and_filename}", data
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
end
