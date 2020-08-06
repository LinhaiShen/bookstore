class ChangeGroupToDusers < ActiveRecord::Migration[6.0]
  def change
    change_column :dusers, :group, :integer
  end
end
