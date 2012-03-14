require 'sinatra'
require "#{File.dirname(__FILE__)}/backend"
 
before do
  ## Basic blacklisting of metacharacters
  redirect to "/exception" if request.path_info =~ /\;|\|/
end
 
get '/' do
 erb :index
end

get '/exception' do
  "sorry, that's not allowed, request contains bad data"
end

get '/show' do
  @team1 = Watcher.new.find_team_by_name "team1"
  erb :show
end

get '/debug' do
  erb :debug
end
