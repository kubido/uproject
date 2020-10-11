require 'sinatra'
require 'dotenv/load'
require 'haml'
require "sinatra/activerecord"
require './app/helpers/uproject'

enable :sessions

  %w(models controllers helpers).map { |p| Dir.glob("#{Dir.pwd}/app/#{p}/*.rb") { |m| require "#{m.chomp}" }}
  configure :development, :test do
    set :database, {adapter: "sqlite3", database: "sqlite3:///uproject.db"}
  end

  configure :production do
    # Database connection
    db = URI.parse(ENV['DATABASE_URL'])

    ActiveRecord::Base.establish_connection(
      :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
      :host     => db.host,
      :username => db.user,
      :password => db.password,
      :database => db.path[1..-1],
      :encoding => 'utf8'
    )
  end

  configure do
    set :method_override, true 
    set :views, settings.root + '/app/views'
    set :public_folder, settings.root + "/app/assets"    
    
    set :super_admin_uid, ENV['UPROJECT_ADMIN'].split(",") rescue nil
    set :admin_uids, ENV['UPROJECT_MANAGER'].split(",") rescue nil
    set :facebook_app_id, ENV['UPROJECT_FB_APP_ID'].split(",") rescue nil

    use Rack::Session::Pool, :key => 'rack.session'
  end

