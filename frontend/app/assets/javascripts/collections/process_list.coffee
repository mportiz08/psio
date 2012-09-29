class Psio.ProcessList extends Backbone.Collection
  model: Psio.Process
  
  comparator: (proc) ->
    # sort descending by cpu usage by default
    0.0 - proc.get('cpu_percent')
