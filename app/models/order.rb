class Order < ApplicationRecord
  belongs_to :product
  belongs_to :user

  def subtotal
    self.product.price
  end

  def tax
    self.product.price * 0.09
  end

  def total
    tax + self.product.price
  end
end
