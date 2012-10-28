class Psio.NetworkInterface extends Backbone.Model
  defaults:
    name: 'system'
  
  initialize: ->
    @metrics = new Psio.Store("networkinterface-#{@get('name')}.io", [])
  
  updateMetrics: ->
    @updateIO() if @has('bytes_sent') and @has('bytes_received')
  
  updateIO: ->
    console.log 'updating'
    @metrics.push @currentIO()
  
  currentIO: ->
    bytes_sent:     @get('bytes_sent')
    bytes_received: @get('bytes_received')
