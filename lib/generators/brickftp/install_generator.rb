require 'securerandom'

module Brickftp
  module Generators
    # Generate a file brickftp.rb  and copy from brickftp_initializer
    class InstallGenerator < Rails::Generators::Base
      # source_root File.expand_path('../../templates', __FILE__)
      source_root File.expand_path('../templates', __dir__)
      desc 'Creates Brickftp initializer for the application'

      def copy_initializer
        template 'brickftp_initializer.rb", "config/initializers/brickftp.rb'

        puts 'Installation complete! Truly Amazing!'
      end
    end
  end
end
