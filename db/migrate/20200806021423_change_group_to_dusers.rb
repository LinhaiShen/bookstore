class ChangeGroupToDusers < ActiveRecord::Migration[6.0]
  def change
    change_column :dusers, :group, :string
  end
end
