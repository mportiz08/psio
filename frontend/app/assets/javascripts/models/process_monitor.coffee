class Psio.ProcessMonitor
  constructor: (@ws, @cmd=Psio.GetAllProcessesCommand) ->
  
  refresh: (ws) ->
    console.debug 'refreshing'
    ws.send(@cmd)
  
  start: ->
    @refresh(@ws)
    window.setInterval =>
      @refresh(@ws)
    , 1000
