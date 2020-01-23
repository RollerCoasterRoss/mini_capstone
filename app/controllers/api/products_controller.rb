class Api::ProductsController < ApplicationController  
  def index
    @products = Product.all

    name_search = params[:search]
    discount_option = params[:discount]
    sort_attribute = params[:sort]
    sort_order = params[:sort_order]

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
                            image_url: params[:image_url],
                            description: params[:description]
                            # stock_status: params[:stock_status]
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
    @product.image_url = params[:image_url] || @product.image_url
    @product.description = params[:description] || @product.description
    # @product.stock_status = params[:stock_status] || @product.stock_status

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
