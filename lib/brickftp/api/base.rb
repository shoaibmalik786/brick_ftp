module Brickftp
  module API
    class Base
      def self.inherited(subclass)
        subclass.include APIDefinition
      end
    end
  end
end
