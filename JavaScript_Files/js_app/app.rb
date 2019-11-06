require 'sinatra'
require 'json'
require 'sinatra/flash'
require_relative '../../ruby_files/lib/AirBnB'

class AirBnB_js < Sinatra::Base
  set :public_folder, proc { File.join(root)}
  register Sinatra::Flash
  enable :sessions
  get '/' do
    @users = session[:username]
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

  get '/sign_up' do
    headers("Access-Control-Allow-Origin" => "*")
    erb :"sign_up.html"
  end

  post '/sign_up' do
    full_name = params[:full_name]
    username = params[:username]
    password = params[:password]
    Hosts.sign_up(name: full_name, username: username, password: password)
    redirect "/"
  end

  get '/sign_in' do
    headers("Access-Control-Allow-Origin" => "*")
    erb :"sign_in.html"
  end

  post '/sign_in' do
    username = params[:username]
    password = params[:password]
    # user = User.create(email: params['email'], password: params['password'])
    username = Hosts.sign_in(username: username, password: password)
    p username
    session[:username] = username
    redirect "/"
  end

  post '/sign_out' do

  end

  run! if app_file == $0
end
