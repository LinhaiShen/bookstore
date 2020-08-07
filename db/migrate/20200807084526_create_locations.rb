class CreateLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :locations do |t|
      t.integer :ops
      t.integer :type
      t.integer :container
      t.string :building
      t.string :room
      t.string :aisle
      t.string :face
      t.integer :column
      t.integer :layer
      t.integer :containercapa
      t.integer :weightcapa
      t.integer :heightcapa
      t.integer :volumecapa

      t.timestamps
    end
  end
end
