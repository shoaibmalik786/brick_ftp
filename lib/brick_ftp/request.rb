require 'rest_client'

module BrickFtp
  # class to interact with api call
  class Request
    def initialize(entity_name = nil)
      @headers = { 'User-Agent' => BrickFtp::USER_AGENT }
      @headers['Content-Type']  = 'application/json'
      @entity_name = entity_name
      @api_url = "https://#{BrickFtp.configuration.subdomain}.brickftp.com/api/rest/v1/"
      auth = 'Basic ' + Base64.strict_encode64("#{BrickFtp.configuration.api_key}:x").chomp
      @headers['Authorization'] = auth
    end

    def post(data = {})
      request :post, "#{@api_url}#{@entity_name}", data
    end

    def count
      request :get, "#{@api_url}#{@entity_name}?action=count"
    end

    def search(field, keyword)
      request :get, "#{@api_url}#{@entity_name}?q[#{field}]=#{keyword}"
    end

    def list
      request :get, "#{@api_url}#{@entity_name}"
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

    def request(method, url, data = {})
      result = nil
      RestClient::Request.execute(method: method, url: url,
                                  payload: data.to_json,
                                  timeout: 60, headers: @headers) do |response|
        result = JSON.parse(response.body)
        if !result.class.to_s.eql?('Array') && result['error']
          raise BrickFtp::BrickFtpException, result['error']
        end
      end
      result
    end
  end
end
