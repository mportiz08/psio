class Psio.Process extends Backbone.Model
  initialize: ->
    @metrics = new Psio.Store("process#{@get('pid')}.cpuusage")#, [])
  
  currentCPUUsage: ->
    usage: @get('cpu_percent')
  
  updateMetrics: ->
    @updateCPUUsage() if @has('pid') and @has('cpu_percent')
  
  updateCPUUsage: ->
    @metrics.push @currentCPUUsage()
  
  graphPlots: ->
    plots = [{ x: 0, y: 0 }]
    
    metrics = @metrics.get()
    if metrics.length > 0
      plots = ({ x: i, y: metric.usage } for metric, i in metrics)
    
    plots
  
  toString: ->
    "process #{@get('pid')}"
