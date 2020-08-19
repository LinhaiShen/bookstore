class AddAssigneeToBookOrders < ActiveRecord::Migration[6.0]
  def change
    add_reference :book_orders, :assignee, foreign_key: { to_table: 'dusers' }
  end
end
