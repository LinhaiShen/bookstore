class AddCodeToLocations < ActiveRecord::Migration[6.0]
  def change
    add_column :locations, :code, :string
    add_index :locations, :code, unique: true
  end
end
