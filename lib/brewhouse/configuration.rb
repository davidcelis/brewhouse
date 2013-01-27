module Brewhouse
  class Configuration
    # Your BreweryDB API Key. If set, `Brewhouse::Client` will be initialized
    # using this key. You may still pass one in manually to override this
    # configuration setting.
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
