require 'sinatra'

configure do
  set :environment, :production
  set :port, 80
end

get '/' do
  "<h1>Hola, amigo!</h1>"
end
