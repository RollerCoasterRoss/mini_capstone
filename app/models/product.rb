class Product < ApplicationRecord 
  belongs_to :supplier
  has_many :images

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :name, length: {maximum: 255}

  validates :price, presence: true
  validates :price, numericality: {greater_than: 0}
  validates :price, numericality: {less_than: 1000000000}

  validates :description, length: {in: 10..500}

  def is_discounted?
    price < 200000
  end

  def tax
    price * 0.09
  end

  def total
    tax + price
  end
end
