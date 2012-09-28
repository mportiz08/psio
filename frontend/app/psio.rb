require 'sinatra/base'

module Psio
  class EverythingExceptPattern
    Match = Struct.new(:captures)
    
    def initialize(except)
      @except   = except
      @captures = Match.new([])
    end
    
    def match(str)
      @captures unless @except === str
    end
  end
  
  class App < Sinatra::Base
    enable :logging
    
    set :public_folder, File.join(File.dirname(__FILE__), '..', 'public')
    
    get EverythingExceptPattern.new(/\/images\/.*/), :provides => 'html' do
      erb :index
    end
  end
end
