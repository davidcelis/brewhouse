module Brewhouse
  module API
    class Remapper
      class << self
        def prettify(thing)
          case thing
          when Array
            thing.map { |t| prettify(t) }
          when Hash
            Hash[thing.map { |k, v| [(MAPPING[k.to_s] || k.to_s), prettify(v)] }]
          else
            thing
          end
        end

        def uglify(thing)
          case thing
          when Array
            thing.map { |t| uglify(t) }
          when Hash
            Hash[thing.map { |k, v| [(INVERTED[k.to_s] || k.to_s), uglify(v)] }]
          else
            thing
          end
        end
      end

      MAPPING = {
        'abvMin'              => 'min_abv',
        'abvMax'              => 'max_abv',
        'available'           => 'availability',
        'availableId'         => 'availability_id',
        'beerVariation'       => 'beer_variation',
        'beerVariationId'     => 'beer_variation_id',
        'categoryId'          => 'category_id',
        'countryIsoCode'      => 'country_iso_code',
        'currentPage'         => 'current_page',
        'displayName'         => 'display_name',
        'foodPairings'        => 'pairings',
        'glass'               => 'glassware',
        'glasswareId'         => 'glassware_id',
        'hoursOfOperation'    => 'hours',
        'ibuMin'              => 'min_ibu',
        'ibuMax'              => 'max_ibu',
        'inPlanning'          => 'in_planning',
        'isClosed'            => 'closed',
        'isOrganic'           => 'organic',
        'isPrimary'           => 'primary',
        'isoCode'             => 'iso_code',
        'isoThree'            => 'iso_three',
        'locationType'        => 'location_type',
        'locationTypeDisplay' => 'location_type_display',
        'numberCode'          => 'number_code',
        'numberOfPages'       => 'pages',
        'openToPublic'        => 'open_to_public',
        'originalGravity'     => 'original_gravity',
        'ogMin'               => 'min_original_gravity',
        'ogMax'               => 'max_original_gravity',
        'fgMin'               => 'min_final_gravity',
        'fgMax'               => 'max_final_gravity',
        'postalCode'          => 'postal_code',
        'servingTemperature'  => 'serving_temperature',
        'srmMin'              => 'min_srm',
        'srmMax'              => 'max_srm',
        'srmId'               => 'srm_id',
        'statusDisplay'       => 'status_display',
        'streetAddress'       => 'street',
        'extendedAddress'     => 'street2',
        'styleId'             => 'style_id',
        'totalResults'        => 'total_results',
        'urlTitle'            => 'url_title',
        'withBreweries'       => 'with_breweries',
        'withIngredients'     => 'with_ingredients',
        'withSocialAccounts'  => 'with_social_accounts',
        'yearOpened'          => 'year_opened',

        'createDate'          => 'created_at',
        'updateDate'          => 'updated_at'
      }

      INVERTED = MAPPING.invert
    end
  end
end
