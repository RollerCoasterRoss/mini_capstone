class Api::ProductsController < ApplicationController
  before_action :authenticate_admin, only: [:create, :update, :destroy]

  def index
    @products = Product.all

    name_search = params[:search]
    discount_option = params[:discount]
    sort_attribute = params[:sort]
    sort_order = params[:sort_order]
    category_choice = params[:category]

    if category_choice
      category = Category.find_by(name: category_choice)
      @products = category.products
    end

    if name_search 
      @products = @products.where("name iLIKE ?", "%#{ name_search }%")
    end

    if discount_option == "true"
      @products = @products.where("price < ?", 200000)
    end

    if sort_attribute && sort_order
      @products = @products.order(sort_attribute => sort_order)
    elsif sort_attribute
      @products = @products.order(sort_attribute) 
    else
      @products = @products.order(:id)
    end

    render "index.json.jb"
  end

  def create
    @product = Product.new(
                            name: params[:name], 
                            price: params[:price],
                            description: params[:description],
                            supplier_id: params[:supplier_id]
                          )
    if @product.save
      render "show.json.jb"
    else
      render json: {errors: @product.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def show
    @product = Product.find(params[:id])
    render "show.json.jb"
  end

  def update
    @product = Product.find(params[:id])

    @product.name = params[:name] || @product.name
    @product.price = params[:price] || @product.price
    @product.description = params[:description] || @product.description
    @product.supplier_id = params[:supplier_id] || @product.supplier_id

    @product.save

    if @product.save
      render "show.json.jb"
    else
      render json: {errors: @product.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def destroy
    product = Product.find(params[:id])
    product.destroy

    render json: {message: "Product has been deleted!"}
  end
end
