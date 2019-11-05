require 'sinatra'
require 'json'

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

  post 'make_listing' do
    space_name = params[:space_name]
    desc = params[:description]
    ppn = params[:ppn]
    dates_ava = params[:dates_available]
    avaliablity = params[:avaliablity]
    location = params[:location]
  end

  run! if app_file == $0
end
