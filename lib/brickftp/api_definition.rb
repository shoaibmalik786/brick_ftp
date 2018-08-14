module Brickftp
  module APIDefinition
    def self.included(klass)
      klass.class_eval do
        @endpoints = {}
        class << self
          attr_reader :endpoints
        end
      end

      klass.extend ClassMethods
    end

    module ClassMethods

      def endpoint(http_method, name, path_template, *query_keys)
        endpoints[name] = {
          http_method: http_method,
          path_template: path_template,
          query_keys: query_keys,
        }
      end
    end
  end
end
