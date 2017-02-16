require 'sinatra'
require 'sinatra/reloader' if development?  # automatically reload app.rb on save via sinatra-contrib gem

get "/" do
  erb :get_name
end

post '/post_name' do
  backend_name = params[:user_name]
  erb :get_age, :locals => {:name => backend_name}  # name is passed to /get_location
end

post '/post_age' do
  backend_age = params[:user_age]
  backend_name = params[:user_name]
  erb :get_numbers, :locals => {:name => backend_name, :age => backend_age}
end

post '/post_numbers' do
  backend_name = params[:user_name]
  backend_age = params[:user_age]
  one = params[:num_1]
  two = params[:num_2]
  three = params[:num_3]
  sum = one.to_i + two.to_i + three.to_i
  compare = (sum < backend_age.to_i) ? "less" : "greater"
  "#{backend_name}, your age is #{backend_age}.<br>
   Your favorite numbers are #{one}, #{two} and #{three}.<br>
   The sum of your favorite numbers is #{sum}, which is #{compare} than your age."
end