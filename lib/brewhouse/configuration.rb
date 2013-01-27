module Brewhouse
  class Configuration
    # Your BreweryDB API Key
    attr_accessor :api_key

  end

  class << self
    attr_accessor :config

    def configure
      @config ||= Configuration.new
      yield @config
    end
  end
end
