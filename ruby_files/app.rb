require 'sinatra'
require 'json'
require './ruby_files/lib/AirBnB'

class AirBnB_manager < Sinatra::Base
  set :public_folder, proc { File.join(root)}
  get '/' do
    headers("Access-Control-Allow-Origin" => "*")
    @accommodation = AirBnB.all
    erb :index
  end

  post '/' do
    AirBnB.update(params[:spaceid].to_i)
    redirect '/'
  end
end
