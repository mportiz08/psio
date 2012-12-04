class Psio.ProcessList extends Backbone.Collection
  model: Psio.Process
  
  comparator: (proc) ->
    # sort descending by cpu usage by default
    0.0 - proc.get('cpu_percent')
  
  totalCPUUsage: ->
    total = @reduce (total, proc) ->
      total + proc.get('cpu_percent')
    , 0
    Math.round(total * 10) / 10 # rounded to 1 decimal place
  
  totalMemoryUsage: ->
    total = @reduce (total, proc) ->
      total + proc.get('memory_rss')
    , 0
    Math.round(total * 100) / 100 # rounded to 2 decimal places
