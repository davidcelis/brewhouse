require 'brewhouse/configuration'
require 'brewhouse/version'

module Brewhouse
  autoload :API, 'brewhouse/api'
  autoload :Client, 'brewhouse/client'

  autoload :Beer, 'brewhouse/models/beer'
end
