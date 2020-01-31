class Api::OrdersController < ApplicationController
  before_action :authenticate_user, only: [:index,:create]

  def index
      authenticate_user
      @orders = current_user.orders
      render "index.json.jb"
  end

  def create
    authenticate_user
    product = Product.find(params[:product_id])
    calculated_subtotal = product.price * params[:quanity].to_i
    calculated_tax = calculated_subtotal * 0.09
    calculated_total = calculated_subtotal + calculated_tax

    @order = Order.new(
                        user_id: current_user.id,
                        product_id: params[:product_id],
                        quanity: params[:quanity],
                        subtotal: calculated_subtotal,
                        tax: calculated_tax,
                        total: calculated_total
                      )
    @order.save
    render "show.json.jb"
  end

  def show
    @order = Order.find(params[:id])
    render "show.json.jb"
  end
end 
