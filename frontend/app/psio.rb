require 'sinatra/base'
require 'sinatra/config_file'
require 'json'

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
    register Sinatra::ConfigFile
    
    enable :logging
    
    config_file File.join(File.dirname(__FILE__), '..', 'config.yml')
    
    set :public_folder, File.join(File.dirname(__FILE__), '..', 'public')
    
    # TODO: Look into patching Sinatra::ConfigFile.
    # I shouldn't need to use #respond_to? here...
    unless settings.respond_to?(:host)
      set :host, 'localhost'
    end
    
    get EverythingExceptPattern.new(/\/images\/.*/), :provides => 'html' do
      @settings = {
        :host => settings.host
      }.to_json
      erb :index
    end
  end
end
