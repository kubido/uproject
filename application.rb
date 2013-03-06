require 'sinatra'
require 'haml'
require "sinatra/activerecord"
require './app/helpers/uproject'
require 'sqlite3' if Sinatra::Base.development?
enable :sessions

set :database, "sqlite3:///uproject.db"

class Application
  
  %w(models controllers helpers).map { |p| Dir.glob("#{Dir.pwd}/app/#{p}/*.rb") { |m| require "#{m.chomp}" }}
  configure do
    set :method_override, true 
    set :views, settings.root + '/app/views'
    set :public_folder, settings.root + "/app/assets"    
  end

end