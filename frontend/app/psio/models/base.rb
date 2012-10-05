require 'adapter/redis'
require 'toystore'

module Psio
  class Base
    include Toy::Store
    adapter :redis, Redis.new
  end
end
