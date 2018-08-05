lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'brickftp/version'

Gem::Specification.new do |spec|
  spec.name          = 'brickftp'
  spec.version       = Brickftp::VERSION
  spec.authors       = ['Shoaib Malik']
  spec.email         = ['shoaib2109@gmail.com']

  spec.summary       = 'Ruby gem for Brickftp APIs'
  spec.description   = 'Super secure file sharing for business.'
  spec.homepage      = 'https://brickftp.com/'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'simplecov'
  spec.add_dependency 'rest-client'
end
