$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'brewhouse/version'

Gem::Specification.new do |s|
  s.name             = 'brewhouse'
  s.version          = Brewhouse::VERSION
  s.summary          = 'A Ruby wrapper for the BreweryDB API'
  s.description      = <<EOF
A feature-rich Ruby wrapper for the BreweryDB API. Use sensical Objects, not giant hashes.
EOF

  s.files            = Dir['lib/**/*']

  s.has_rdoc         = false

  s.author           = 'David Celis'
  s.email            = 'david@davidcelis.com'
  s.homepage         = 'https://github.com/davidcelis/brewhouse'
end
