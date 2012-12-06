class Psio.ProcessList extends Backbone.Collection
  model: Psio.Process
  
  initialize: (models, options) ->
    if options?
      @setupMetrics(options.appName) if options.appName?
  
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
  
  setupMetrics: (app) ->
    @appName = app
    @metrics = new Psio.Store("#{@appName}.cpu.usage", [])
  
  updateMetrics: ->
    @updateCPUMetrics()
  
  updateCPUMetrics: ->
    @metrics.push @currentCPUUsage()
  
  currentCPUUsage: ->
    cpuUsage = @totalCPUUsage()
    
    usage =
      time:  new Date().getTime()
      usage: cpuUsage
  
  graphPlots: ->
    plots = [{ x: 0, y: 0 }]
    
    metrics = @metrics.get()
    if metrics.length > 0
      plots = ({ x: i, y: metric.usage } for metric, i in metrics)
    
    plots
  
  toString: ->
    str = "process list"
    
    if @appName?
      str = @appName
    
    str
