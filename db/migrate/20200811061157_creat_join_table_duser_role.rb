class CreatJoinTableDuserRole < ActiveRecord::Migration[6.0]
  def change
    create_join_table :dusers, :roles do |t|
      # t.index [:duser_id, :role_id]
      # t.index [:role_id, :duser_id]
    end
  end
end
