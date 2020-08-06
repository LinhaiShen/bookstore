class AddGroupToDusers < ActiveRecord::Migration[6.0]
  def change
    add_column :dusers, :group, :string
  end
end
