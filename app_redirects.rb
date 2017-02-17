require 'sinatra'
require 'sinatra/reloader' if development?  # automatically reload app.rb on save via sinatra-contrib gem

get "/" do
  erb :get_name
end

post '/post_name' do
  backend_name = params[:user_name]
  redirect "/age?name=" + backend_name
end

get '/age' do
  backend_name = params[:name]  # John
  erb :get_age_redirects, :locals => {:name => backend_name}  # name is passed to /get_location
end

post '/post_age' do
  user_hash = params[:user]
  redirect "/numbers?user=" + user_hash.to_s  # convert hash to string for use in URL
  # "#{user_hash}"  # {"user_age"=>"41", "user_name"=>"John"}
  # "#{user_hash["user_name"]}, your age is #{user_hash["user_age"]}."  # John, your age is 41.
end

get '/numbers' do
  user_hash = eval(params[:user])  # use eval to convert string to hash
  backend_name = user_hash["user_name"]  # get user_name from hash
  backend_age = user_hash["user_age"]  # get user_age from hash
  # "#{backend_name}, #{backend_age}"  # John, 41
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