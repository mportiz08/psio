require 'psio/models/base'
require 'psio/models/metric'

module Psio
  class CpuMetric < Base
    sluggable :name
    
    key       SlugKeyFactory.new(:name)
    attribute :num, String
    list      :usage, Metric
    
    validates :name, :presence => true
  end
end
