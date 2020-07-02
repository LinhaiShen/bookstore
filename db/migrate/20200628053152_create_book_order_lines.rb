class CreateBookOrderLines < ActiveRecord::Migration[6.0]
  def change
    create_table :book_order_lines do |t|
      t.integer :linenumber
      t.integer :status
      t.references :book, null: false, foreign_key: true
      t.integer :qty

      t.timestamps
    end
  end
end
