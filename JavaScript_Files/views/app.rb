require 'sinatra'
require 'json'
require_relative '../../lib/AirBnB'

class AirBnB_js < Sinatra::Base
  set :public_folder, proc { File.join(root)}
  get '/' do
    headers("Access-Control-Allow-Origin" => "*")
    erb :"index.html"
  end

  get '/make_listing' do
    headers("Access-Control-Allow-Origin" => "*")
    erb :make_listing
  end

  post '/make_listing' do
    space_name = params[:space_name]
    desc = params[:description]
    ppn = params[:ppn]
    dates_ava = params[:dates_available]
    availability = params[:availability]
    location = params[:location]
    AirBnB.create(spacename: space_name,
      description: desc,
      price_per_night: ppn,
      dates_available: dates_ava,
      availability: availability,
      location: location)
    redirect "/"
  end

  post '/' do
    headers("Access-Control-Allow-Origin" => "*")
    AirBnB.update(params[:spaceid].to_i)
    redirect '/'
  end

  run! if app_file == $0
end
