require 'sinatra'
require 'json'

class AirBnB < Sinatra::Base
  set :public_folder, proc { File.join(root)}
  get '/' do
    headers("Access-Control-Allow-Origin" => "*")
    erb :index
  end
end
