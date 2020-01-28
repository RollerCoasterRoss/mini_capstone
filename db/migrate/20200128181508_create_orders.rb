class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :product_id
      t.integer :quanity
      t.decimal :subtotal, precision: 13, scale: 2
      t.decimal :tax, precision: 13, scale: 2
      t.decimal :total, precision: 13, scale: 2

      t.timestamps
    end
  end
end
