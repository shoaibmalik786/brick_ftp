require 'net/https'
require 'json'

module Brickftp
  class HTTPClient
    USER_AGENT = 'Brickftp'

    def initialize(host = nil)
      @host = host || "#{Brickftp.configuration.subdomain}.brickftp.com"
      @conn = Net::HTTP.new(@host, 443)
      @conn.use_ssl = true
    end

    def post(path, params: {}, headers: {})

      case res = request(:post, path, params: params, headers: headers)

      when Net::HTTPSuccess, Net::HTTPCreated
        res.body.nil? || res.body.empty? ? {} : JSON.parse(res.body)
      else
        # :nocov:
        if !res.class.to_s.eql?('Array') && res['error']
          raise Brickftp::BrickftpException, res['error']
        end
        # :nocov:
      end
    end

    def put(path, params: {}, headers: {})

      case res = request(:put, path, params: params, headers: headers)
      when Net::HTTPSuccess
        res.body.nil? || res.body.empty? ? {} : JSON.parse(res.body)
      else
        # :nocov:
        if !res.class.to_s.eql?('Array') && res['error']
          raise Brickftp::BrickftpException, res['error']
        end
        # :nocov:
      end
    end

    private

    def request(method, path, params: {}, headers: {})
      req = Net::HTTP.const_get(method.to_s.capitalize).new(path, headers)
      req['User-Agent'] = USER_AGENT

      if @host.include?('brickftp.com')
        req['Content-Type'] = 'application/json'
        req.basic_auth(Brickftp.configuration.api_key, 'x')
      end

      case
      when params.is_a?(Hash)
        req.body = params.to_json unless params.empty?
      when !@host.include?('brickftp.com')
        req.body_stream = params
        req['Content-Length'] = params.size
      end

      start = Time.now
      begin
        logger.debug format('Request headers: %{headers}', headers: req.each_capitalized.map { |k, v| "#{k}: #{v}" })
        logger.debug format('Request body: %{body}', body: req.body)
        @conn.request(req).tap do |res|
          logger.debug format('Response headers: %{headers}', headers: res.each_capitalized.map { |k, v| "#{k}: #{v}" })
          logger.debug format('Response body: %{body}', body: res.body)
        end
      ensure
        message = format(
          'Complete %{method} %{path} (%{time} ms)',
          method: method.upcase,
          path: path,
          time: (Time.now - start) * 1000
        )
        logger.info message
      end
    end

    def logger
      Brickftp.logger
    end
  end
end
