# frozen_string_literal: true

require 'httparty'

module AppServices
  # This class will consume the API data
  class PokemonApiService
    def initialize(url)
      @endpoint = url
    end

    def call
      HTTParty.get("https://pokeapi.co/api/v2/pokemon/#{@endpoint}")
    rescue HTTParty::Error => e
      OpenStruct.new({ success?: false, error: e })
    end
  end
end
