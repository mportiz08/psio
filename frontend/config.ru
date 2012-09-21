$:.unshift 'app'

require 'psio'
require 'sprockets'

stylesheets_assets = Sprockets::Environment.new
stylesheets_assets.append_path 'app/assets/stylesheets'

javascripts_assets = Sprockets::Environment.new
javascripts_assets.append_path 'app/assets/javascripts'

map '/assets/stylesheets' do
  run stylesheets_assets
end

map '/assets/javascripts' do 
  run javascripts_assets
end

map '/' do
  run Psio::App
end
