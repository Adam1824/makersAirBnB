require 'sinatra'
require 'json'
require './lib/AirBnB'

class AirBnB_manager < Sinatra::Base
  set :public_folder, proc { File.join(root)}
  get '/' do
    headers("Access-Control-Allow-Origin" => "*")
    @accommodation = AirBnB.all
    p @accommodation
    erb :index
  end
end
