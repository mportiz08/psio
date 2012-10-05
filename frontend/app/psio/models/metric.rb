require 'psio/models/base'

module Psio
  class Metric < Base
    attribute :time,  Time
    attribute :value, Float
    
    validates :time, :value, :presence => true
  end
end
