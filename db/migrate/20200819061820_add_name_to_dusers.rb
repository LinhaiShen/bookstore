class AddNameToDusers < ActiveRecord::Migration[6.0]
  def change
    add_column :dusers, :name, :string
  end
end
