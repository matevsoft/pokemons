# frozen_string_literal: true

require 'httparty'

module AppServices
  # This class will consume the API data
  class PokemonApiService
    def initialize(atr, resource)
      @atr = atr
      @resource = resource
      @endpoint = "#{@atr}/#{@resource}"
    end

    def call
      HTTParty.get("https://pokeapi.co/api/v2/#{@endpoint}")
    rescue HTTParty::Error => e
      OpenStruct.new({ success?: false, error: e })
    end
  end
end
