# frozen_string_literal: true

require 'rails_helper'
require 'httparty'
require 'byebug'

RSpec.describe AppServices::PokemonApiService, type: :model do
  describe '#call' do
    let(:atr) { 'pokemon' }
    let(:resource) { '' }

    it 'fetches the records from Pokemon api' do
      @result = AppServices::PokemonApiService.new(atr, resource).call

      expect(@result.parsed_response['results'].count).to be > 0
    end
  end
end
