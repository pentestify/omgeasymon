require 'sinatra'
require "#{File.dirname(__FILE__)}/watcher"
 
before do
  ## Basic blacklisting of metacharacters
  redirect to "/exception" if request.path_info =~ /\;|\|/
end
 
get '/' do
 redirect to "/show"
end

get '/exception' do
  "sorry, that's not allowed, request contains bad data"
end

get '/show' do
  # Get the watcher
  @watcher = Watcher.instance
  # Parse the latest scan data
  @watcher.watch
  erb :show
end

get '/debug' do
  erb :debug
end
