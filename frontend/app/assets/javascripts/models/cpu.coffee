class Psio.CPU extends Backbone.Model
  initialize: ->
    @metrics = new Psio.Store("cpu#{@get('num')}.usage", [])
    @on 'change', @updateMetrics
  
  currentUsage: ->
    time:  new Date().getTime()
    usage: @get('usage')
  
  updateMetrics: ->
    @updateUsage() if @has('num') and @has('usage')
  
  updateUsage: ->
    @metrics.push @currentUsage()
  
  usagePlots: ->
    plots = [{ x: 0, y: 0 }]
    
    metrics = @metrics.get()
    if metrics.length > 0
      plots = ({ x: i, y: metric.usage } for metric, i in metrics)
    
    plots
