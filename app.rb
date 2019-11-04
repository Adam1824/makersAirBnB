require 'sinatra'
require 'json'

class AirBnB < Sinatra::Base
  set :public_folder, proc { File.join(root)}
  get '/' do
    send_file "index.html"
  end

end
