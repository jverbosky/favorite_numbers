# Using sessions to hold onto data without having to pass it back into the front end

require 'sinatra'
require 'sinatra/reloader' if development?  # automatically reload app.rb on save via sinatra-contrib gem

enable :sessions

get "/" do
  erb :get_name
end

post '/post_name' do
  session[:backend_name] = params[:user_name]
  erb :get_age, :locals => {:name => session[:backend_name]}  # name is passed to /get_location
end

post '/post_age' do
  session[:backend_age] = params[:user_age]
  erb :get_numbers, :locals => {:name => session[:backend_name], :age => session[:backend_age]}
end

post '/post_numbers' do
  one = params[:num_1]
  two = params[:num_2]
  three = params[:num_3]
  sum = one.to_i + two.to_i + three.to_i
  compare = (sum < session[:backend_age].to_i) ? "less" : "greater"
  "#{session[:backend_name]}, your age is #{session[:backend_age]}.<br>
   Your favorite numbers are #{one}, #{two} and #{three}.<br>
   The sum of your favorite numbers is #{sum}, which is #{compare} than your age."
end