require 'sinatra'
require 'json'
require 'sinatra/flash'
require_relative '../../ruby_files/lib/AirBnB'

class AirBnB_js < Sinatra::Base
  set :public_folder, proc { File.join(root)}
  register Sinatra::Flash
  enable :sessions
  get '/' do
    @user = session[:username]
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
    @exists = false
    full_name = params[:full_name]
    username = params[:username]
    password = params[:password]
    host = Hosts.new(host_id: 1, name: full_name, username: username, password: password)
    if host.exists?
      @exists = true
      headers("Access-Control-Allow-Origin" => "*")
      erb :"index.html"
    else
      Hosts.sign_up(name: full_name, username: username, password: password)
      p session[:username]
      session[:username] = username
      p session[:username]
      @user = session[:username]
      p @user
      headers("Access-Control-Allow-Origin" => "*")
      erb :"index.html"
    end
  end

  get '/sign_in' do
    headers("Access-Control-Allow-Origin" => "*")
    erb :"sign_in.html"
  end

  post '/sign_in' do
    @signed_in_erb = false
    username = params[:username]
    password = params[:password]
    signed_in = Hosts.sign_in_check(username: username, password: password)
    if signed_in
      @signed_in_erb = true
      session[:username] = username
      @user = session[:username]
      headers("Access-Control-Allow-Origin" => "*")
      erb :"index.html"
    else
      @user = false
      headers("Access-Control-Allow-Origin" => "*")
      erb :"index.html"
    end
  end

  post '/sign_out' do
    session[:username] = false
    redirect '/'
  end

  run! if app_file == $0
end
