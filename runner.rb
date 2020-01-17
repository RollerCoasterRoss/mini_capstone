# require 'http'
# require 'tty-table'

# response = HTTP.get("http://localhost:3000/api/all_products")
# all_cars = response.parse["message"]
# puts all_cars

# puts
# puts
# puts "=" * 25
# puts
# puts

# one_car_response = HTTP.get("http://localhost:3000/api/retrieve_car_1")
# one_car = one_car_response.parse["message"]
# p one_car

# puts
# puts
# puts "*" * 25
# puts
# puts

# table = TTY::Table.new ['id','name','price','image_url','description'], [[one_car["id"]], [one_car["name"]], [one_car["price"]], [one_car["image_url"]], [one_car["description"]]]
# table.render(:ascii)