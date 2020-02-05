class Api::OrdersController < ApplicationController
  before_action :authenticate_user, only: [:index,:create]

  def index
    @orders = current_user.orders
    render "index.json.jb"
  end

  def create
    @order = Order.new(user_id: current_user.id)
    @order.calculate_totals
    @order.save
    render "show.json.jb"
  end

  def show
    @order = Order.find(params[:id])
    render "show.json.jb"
  end
end
