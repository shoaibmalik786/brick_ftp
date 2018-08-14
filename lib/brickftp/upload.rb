require 'json'

module Brickftp
  class Upload < Brickftp::API::Base
    endpoint :post, :create, '/api/rest/v1/files/%{path}'

    def self.create(path:, source:, chunk_size: nil)
      api_client = Brickftp::HTTPClient.new
      chunk_io = Brickftp::Utils::ChunkIO.new(source, chunk_size: chunk_size)

      ref = nil
      params_for_request_upload_url = { action: 'put' }
      upload_info = {}

      chunk_io.each.with_index(1) do |chunk, part|
        params_for_request_upload_url.update(part: part, ref: ref) if part > 1
        upload_info = api_client.post("/api/rest/v1/files/#{path}", params: params_for_request_upload_url)
        ref = upload_info['ref']
        upload_uri = URI.parse(upload_info['upload_uri'])
        upload_client = Brickftp::HTTPClient.new(upload_uri.host)
        upload_client.put(upload_info['upload_uri'], params: chunk)
      end

      uploaded_info = api_client.post("/api/rest/v1/files/#{path}", params: { action: 'end', ref: ref })
      upload_info.merge(uploaded_info)
    end
  end
end