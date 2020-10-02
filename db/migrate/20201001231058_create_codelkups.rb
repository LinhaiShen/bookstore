class CreateCodelkups < ActiveRecord::Migration[6.0]
  def change
    create_table :codelkups do |t|
      t.string :code
      t.string :name
      t.string :value
      t.string :note

      t.timestamps
    end
  end
end
