require 'securerandom'

module BrickFtp
  module Generators
    # Generate a file brick_ftp.rb  and copy from brick_ftp_initializer
    class InstallGenerator < Rails::Generators::Base
      # source_root File.expand_path('../../templates', __FILE__)
      source_root File.expand_path('../templates', __dir__)
      desc 'Creates BrickFtp initializer for the application'

      def copy_initializer
        template 'brick_ftp_initializer.rb", "config/initializers/brick_ftp.rb'

        puts 'Installation complete! Truly Amazing!'
      end
    end
  end
end
