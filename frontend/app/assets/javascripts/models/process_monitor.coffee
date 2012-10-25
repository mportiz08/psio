class Psio.ProcessMonitor
  constructor: (@ws, @cmd=Psio.GetAllProcessesCommand) ->
  
  refresh: (ws) ->
    ws.send(@cmd)
  
  start: (interval=1000) ->
    @refresh(@ws)
    
    if interval is 0
      return
    
    window.setInterval =>
      @refresh(@ws)
    , interval
