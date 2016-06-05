require 'sinatra'
require 'sinatra/sequel'
require 'sequel'

configure do
  Sequel::Model.plugin :json_serializer
  DB = Sequel.connect(ENV['DATABASE_URL'])
  require './config/migrations'
  require './config/data'
end

use Rack::Auth::Basic do |username, password|
  username == ENV['AUTH_USER'] && password == ENV['AUTH_PASSWORD']
end


configure :development do
  require 'logger'
  DB.logger = Logger.new($stdout)
end
