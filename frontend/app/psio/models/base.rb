require 'json'
require 'adapter/redis'
require 'toystore'

class String
  def to_slug
    self.downcase
        .gsub(/\s+/, '-')     # replace spaces with -
        .gsub(/[^\w\-]+/, '') # remove all non-word chars
        .gsub(/\-\-+/, '-')   # replace multiple - with single -
        .gsub(/^-+/, '')      # trim - from start of text
        .gsub(/-+$/, '')      # trim - from end of text
  end
end

module Psio
  module Sluggable
    module ClassMethods
      def sluggable(field)
        before_save { |record| update_slug(field) }
      end
    end
    
    def self.included(base)
      base.extend ClassMethods
    end
    
    def update_slug(field)
      self.slug = self.attributes[field.to_s].to_s.to_slug
    end
  end
  
  class SlugKeyFactory < Toy::Identity::AbstractKeyFactory
    def initialize(key_field)
      @key_field = key_field
    end
    
    def key_type; String; end
    
    def next_key(obj)
      obj.slug = obj.send(@key_field).to_slug
    end
  end
  
  class Base
    include Sluggable
    include Toy::Store
    
    attr_accessor :slug
    
    adapter :redis, Redis.new
    
    # def serializable_hash(opts=nil)
    #   self.attributes
    # end
  end
end
