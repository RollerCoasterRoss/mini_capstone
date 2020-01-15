class Api::ProductsController < ApplicationController
  def display_all_products
    @cars = Product.all

    render "display_all_products_view.json.jb"
  end
end
