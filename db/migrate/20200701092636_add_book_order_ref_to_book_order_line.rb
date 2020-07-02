class AddBookOrderRefToBookOrderLine < ActiveRecord::Migration[6.0]
  def change
    add_reference :book_order_lines, :book_order, null: false, default: 1, foreign_key: true
  end
end
