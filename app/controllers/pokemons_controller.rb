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
    n = 1
    while n < 30
      @response = AppServices::PokemonApiService.new(n).call
      @types = []
      @response['types'].each do |ts|
        @types << ts['type']['name']
      end
      Pokemon.create(
        name: @response['name'],
        base_experience: @response['base_experience'],
        height: @response['height'],
        order: @response['order'],
        weight: @response['weight'],
        types: @types
      )
      n += 1
    end
  end
end
