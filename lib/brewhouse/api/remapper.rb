module Brewhouse
  module API
    class Remapper
      class << self
        def prettify(hash)
          Hash[hash.map { |k, v| [MAPPING[k], v] }]
        end

        def uglify(hash)
          Hash[hash.map { |k, v| [INVERTED[k], v] }]
        end
      end

      MAPPING = {
        'id'                 => 'id',
        'ids'                => 'ids',

        'abv'                => 'abv',
        'available'          => 'availability',
        'availableId'        => 'availability_id',
        'beerVariation'      => 'beer_variation',
        'beerVariationId'    => 'beer_variation_id',
        'breweries'          => 'breweries',
        'brewery'            => 'brewery',
        'description'        => 'description',
        'foodPairings'       => 'pairings',
        'glass'              => 'glassware',
        'glasswareId'        => 'glassware_id',
        'ibu'                => 'ibu',
        'isOrganic'          => 'organic',
        'label'              => 'label',
        'name'               => 'name',
        'order'              => 'order',
        'originalGravity'    => 'gravity',
        'servingTemperature' => 'serving_temperature',
        'since'              => 'since',
        'sort'               => 'sort',
        'srm'                => 'srm',
        'srmId'              => 'srm_id',
        'status'             => 'status',
        'style'              => 'style',
        'styleId'            => 'style_id',
        'withBreweries'      => 'with_breweries',
        'withIngredients'    => 'with_ingredients',
        'withSocialAccounts' => 'with_social_accounts',
        'year'               => 'year',

        'createDate'         => 'created_at',
        'updateDate'         => 'updated_at'
      }

      INVERTED = MAPPING.invert
    end
  end
end
