# frozen_string_literal: true

# Pokemons actions
class PokemonsController < ApplicationController
  # The index must return only the id, name and types attributes
  def index
    fill_pokemons if Pokemon.all.count.zero?

    @pokemons = Pokemon.all
    render json: @pokemons.to_json(only: %i[id name types])
  end

  # The show must return all other attributes
  def show
    @pokemon = Pokemon.find_by_id(params[:id])
    if @pokemon
      render json: @pokemon
    else
      render json: "Doesn't exists"
    end
  end

  private

  def fill_pokemons
    @colection_response = AppServices::PokemonApiService.new('pokemon', '').call
    @colection_response.parsed_response['results'].each do |pokemon|
      @pokemon_responce = AppServices::PokemonApiService.new('pokemon', pokemon['name']).call
      @pokemon_db_rekord = Pokemon.create(
        name: @pokemon_responce['name'],
        base_experience: @pokemon_responce['base_experience'],
        height: @pokemon_responce['height'],
        order: @pokemon_responce['order'],
        weight: @pokemon_responce['weight']
      )
      @pokemon_responce['types'].each do |type|
        @type_name = type['type']['name']
        @type_db_rekord = Type.find_or_create_by(name: @type_name) if @type_name.present?
        @pokemon_db_rekord.types << @type_db_rekord
      end
    end
  end
end
