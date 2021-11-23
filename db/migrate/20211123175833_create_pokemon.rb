class CreatePokemon < ActiveRecord::Migration[6.0]
  def change
    create_table :pokemons do |t|
      t.string :name
      t.integer :base_experience
      t.integer :height
      t.integer :order
      t.integer :weight
      t.text :types
    end
  end
end
