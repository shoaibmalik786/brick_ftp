require 'brickftp/request'
require 'json'

module Brickftp
  # perform Behavior's action
  class Behavior
    def self.create(options = {})
      Brickftp::Request.new('behaviors').post(options)
    end

    def self.show(id)
      Brickftp::Request.new('behaviors').show(id)
    end

    def self.update(id, options = {})
      Brickftp::Request.new('behaviors').update_behavior(id, options)
    end

    def self.delete(id)
      Brickftp::Request.new('behaviors').delete(id)
    end

    def self.list
      Brickftp::Request.new('behaviors').list
    end

    def self.list_folder(path)
      Brickftp::Request.new('behaviors').list_folder(path)
    end
  end
end
