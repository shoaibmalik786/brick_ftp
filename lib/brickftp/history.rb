require 'brickftp/request'
require 'json'

module Brickftp
  # perform Notification's Api
  class History
    def self.site_history(page = 1, per_page = 1000, start_at = nil)
      Brickftp::Request.new('history').site_history(page, per_page, start_at)
    end

    def self.login_history(page = 1, per_page = 1000, start_at = nil)
      Brickftp::Request.new('history').login_history(page, per_page, start_at)
    end

    def self.user_history(user_id, page = 1, per_page = 1000, start_at = nil)
      Brickftp::Request.new('history').user_history(user_id, page, per_page, start_at)
    end

    def self.folder_history(path, page = 1, per_page = 1000, start_at = nil)
      Brickftp::Request.new('history').folder_history(path, page, per_page, start_at)
    end

    def self.file_history(path, page = 1, per_page = 1000, start_at = nil)
      Brickftp::Request.new('history').file_history(path, page, per_page, start_at)
    end                
  end
end
