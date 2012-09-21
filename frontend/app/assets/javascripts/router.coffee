class Psio.Router extends Backbone.Router
  routes:
    '': 'index'
  
  index: ->
    ws = new WebSocket("ws://localhost:8888")
    ws.onmessage = (event) ->
      console.debug JSON.parse(event.data)
    ws.onopen = ->
      getAllProcessesCmd =
        type: 'command'
        data:
          name: 'process.getall'
      ws.send(JSON.stringify(getAllProcessesCmd))
