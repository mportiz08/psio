class Psio.NetworkInterface extends Backbone.Model
  defaults:
    name: 'system'
  
  initialize: ->
    @metrics = new Psio.Store("networkinterface-#{@get('name')}.io", [])
    @on 'change', @updateMetrics, @
  
  updateMetrics: ->
    @updateIO() if @has('bytes_sent') and @has('bytes_received')
  
  updateIO: ->
    @metrics.push @currentIO()
  
  currentIO: ->
    data =
      bytes_sent:     @get('bytes_sent')
      bytes_received: @get('bytes_received')
    
    if @hasChanged('bytes_sent') and @previous('bytes_sent')?
      data.bytes_sent_diff = @get('bytes_sent') - @previous('bytes_sent')
    
    if @hasChanged('bytes_received') and @previous('bytes_received')?
      data.bytes_received_diff = @get('bytes_received') - @previous('bytes_received')
    
    data
  
  graphPlots: ->
    plots = [{ x: 0, y: 0 }, { x: 0, y: 0 }]
    
    metrics = _.filter @metrics.get(), (metric) ->
      metric.bytes_sent_diff? and metric.bytes_received_diff?
    
    if metrics.length > 0
      plots[0] = ({ x: i, y: metric.bytes_sent_diff } for metric, i in metrics)
      plots[1] = ({ x: i, y: metric.bytes_received_diff } for metric, i in metrics)
    
    plots
