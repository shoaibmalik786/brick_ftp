require 'brick_ftp/request'
require 'json'

module BrickFtp
  # perform users's action
  class User
    def self.create(options = {})
      BrickFtp::Request.new('users').post(options)
    end

    def self.count
      BrickFtp::Request.new('users').count
    end

    def self.search(keyword = nil, field = 'username')
      BrickFtp::Request.new('users').search(field, keyword)
    end

    def self.show(id)
      BrickFtp::Request.new('users').show(id)
    end

    def self.update(id, options = {})
      BrickFtp::Request.new('users').put(id, options)
    end

    def self.delete(id)
      BrickFtp::Request.new('users').delete(id)
    end

    def self.unlock(id)
      BrickFtp::Request.new('users').unlock(id)
    end

    def self.list
      BrickFtp::Request.new('users').list
    end
  end
end
