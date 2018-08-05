require 'brickftp/request'
require 'json'

module Brickftp
  # perform Group's action
  class Group
    def self.list
      Brickftp::Request.new('groups').list
    end

    def self.show(id)
      Brickftp::Request.new('groups').show(id)
    end

    def self.create(options = {})
      Brickftp::Request.new('groups').post(options)
    end

    def self.update(id, options = {})
      Brickftp::Request.new('groups').put(id, options)
    end    

    def self.delete(id)
      Brickftp::Request.new('groups').delete(id)    
    end

    def self.create_user(group_id, options = {})
      Brickftp::Request.new('groups').create_user_in_group(group_id, options)
    end

    def self.memberships(group_id, user_id, options = {})
      Brickftp::Request.new('groups').add_member_to_group(group_id, user_id, options)
    end

    def self.update_memberships(group_id, user_id, options = {})
      Brickftp::Request.new('groups').update_member_to_group(group_id, user_id, options)
    end

    def self.delete_memberships(group_id, user_id)
      Brickftp::Request.new('groups').delete_member_to_group(group_id, user_id)
    end        
  end
end
