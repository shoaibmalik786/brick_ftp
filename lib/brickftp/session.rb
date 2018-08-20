require 'brickftp/request'
require 'json'

module Brickftp
  class AuthenticationRequest
    def initialize(entity_name = nil)
      @headers = { 'User-Agent' => Brickftp::USER_AGENT }
      @headers['Content-Type']  = 'application/json'
      @entity_name = entity_name
      @api_url = "https://#{Brickftp.configuration.subdomain}.brickftp.com/api/rest/v1/"
      auth = 'Basic ' + Base64.strict_encode64("#{Brickftp.configuration.api_key}:x").chomp
      #@headers['Authorization'] = auth
    end

    def post(data = {})
      request :post, "#{@api_url}#{@entity_name}", data
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

  class Session
    def self.login(options = {})
      Brickftp::AuthenticationRequest.new('sessions').post(options)
    end    
  end
end
