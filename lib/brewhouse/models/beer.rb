module Brewhouse
  class Beer
    attr_accessor :id, :abv, :name, :glassware, :style, :labels, :style_id,
                  :glassware_id, :organic, :status, :breweries, :brewery_ids

    attr_reader :created_at, :updated_at

    alias :organic? :organic

    def initialize(attributes)
      @abv = attributes.delete('abv').to_f
      @organic = attributes.delete('organic') == 'Y' ? true : false
      @created_at = Time.parse(attributes.delete('created_at'))
      @updated_at = Time.parse(attributes.delete('updated_at'))
      attributes.each { |k, v| instance_variable_set(:"@#{k}", v) }
    end

    class << self
      def find(*ids)
        ids = ids.first.is_a?(Array) ? ids[0] : ids

        result = Criteria.new.find(*ids)
        result.size > 1 ? result : result.first
      end

      def where(conditions)
        Criteria.new(conditions)
      end
    end

    class Criteria
      include Enumerable

      def initialize(conditions = {})
        @client = Brewhouse::Client.new
        @conditions = { :with_breweries => 'Y' }.merge(conditions)
      end

      def find(*ids)
        ids = ids.first.is_a?(Array) ? ids[0] : ids
        where(:ids => ids.join(',')).to_a
      end

      def where(conditions)
        Criteria.new(@conditions.merge(conditions))
      end

      def each(&block)
        beers = query!
        beers.each(&block)
      end

      private

      def query!
        response = @client.get('/beers', @conditions)
        response.body['data'].map { |data| Beer.new(data) }
      end
    end
  end
end
