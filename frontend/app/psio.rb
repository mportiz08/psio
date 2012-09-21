require 'sinatra/base'

module Psio
  class App < Sinatra::Base
    enable :logging
    
    get '/' do
      erb :index
    end
  end
end
