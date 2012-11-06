class Psio.Host extends Backbone.Model
  initialize: ->
    @fetchHostInfo()
  
  hostname: ->
    if @has('hostname')
      @get('hostname')
    else
      'unknown'
  
  fetchHostInfo: ->
    ws = new WebSocket("ws://#{Psio.settings.host}:8888")
    
    ws.onmessage = (event) =>
      resp = JSON.parse(event.data)
      info = resp.data
      @set(info)
    
    ws.onopen = ->
      psm = new Psio.ProcessMonitor(ws, Psio.GetHostInfoCommand)
      psm.start(0)
