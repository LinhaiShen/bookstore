class ChangeLocationTypeColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :locations, :type, :loctype
  end
end
