require 'brickftp/request'
require 'json'

module Brickftp
  # perform users's action
  class User
    def self.create(options = {})
      Brickftp::Request.new('users').post(options)
    end

    def self.count
      Brickftp::Request.new('users').count
    end

    def self.search(keyword = nil, field = 'username')
      Brickftp::Request.new('users').search(field, keyword)
    end

    def self.show(id)
      Brickftp::Request.new('users').show(id)
    end

    def self.update(id, options = {})
      Brickftp::Request.new('users').put(id, options)
    end

    def self.delete(id)
      Brickftp::Request.new('users').delete(id)
    end

    def self.unlock(id)
      Brickftp::Request.new('users').unlock(id)
    end

    def self.list(page = 1, per_page = 1000)
      Brickftp::Request.new('users').list(page, per_page)
    end
  end
end
