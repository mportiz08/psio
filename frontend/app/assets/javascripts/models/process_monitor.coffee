class Psio.ProcessMonitor
  constructor: (@ws) ->
  
  refresh: (ws) ->
    console.debug 'refreshing'
    ws.send(Psio.GetAllProcessesCommand)
  
  start: ->
    @refresh(@ws)
    window.setInterval =>
      @refresh(@ws)
    , 1000
