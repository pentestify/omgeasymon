require 'sinatra'
require "#{File.dirname(__FILE__)}/team"
 
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
  @team1 = Team.new
  @team2 = Team.new
  @team3 = Team.new
  @team4 = Team.new
  @team5 = Team.new
  @team6 = Team.new
  @team7 = Team.new
  @team8 = Team.new
  erb :show
end

get '/debug' do
  erb :debug
end
