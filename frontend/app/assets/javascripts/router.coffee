class Psio.Router extends Backbone.Router
  routes:
    '':           'index'
    'scheduling': 'scheduling'
  
  index: ->
    @navigate 'scheduling', trigger: true, replace: true
  
  scheduling: ->
    Psio.mode = Psio.SCHEDULING_MODE
    
    ws = new WebSocket("ws://localhost:8888")
    ws.onmessage = (event) ->
      console.debug JSON.parse(event.data)
    ws.onopen = ->
      getAllProcessesCmd =
        type: 'command'
        data:
          name: 'process.getall'
      ws.send(JSON.stringify(getAllProcessesCmd))
