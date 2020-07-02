class CreateBookOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :book_orders do |t|
      t.string :refnumber
      t.integer :status
      t.datetime :deliverytime
      t.string :deliveryaddress
      t.text :notes

      t.timestamps
    end
  end
end
