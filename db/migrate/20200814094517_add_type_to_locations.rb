class AddTypeToLocations < ActiveRecord::Migration[6.0]
  def change
    add_column :locations, :type, :string
  end
end
