class RenameQuanityOnCartedProducts < ActiveRecord::Migration[6.0]
  def change
    rename_column :carted_products, :quanity, :quantity
  end
end
