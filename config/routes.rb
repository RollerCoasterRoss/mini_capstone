Rails.application.routes.draw do
  namespace :api do
    get '/all_products' => 'products#display_all_products'
  end
end
