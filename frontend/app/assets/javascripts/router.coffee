class Psio.Router extends Backbone.Router
  routes:
    '':           'index'
    'scheduling': 'scheduling'
    'memory':     'memory'
    'network':    'network'
  
  index: ->
    @navigate 'scheduling', trigger: true, replace: true
  
  scheduling: ->
    console.debug 'scheduling route'
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
  
  memory: ->
    console.debug 'memory route'
    Psio.mode = Psio.MEMORY_MODE
    
  network: ->
    console.debug 'network route'
    Psio.mode = Psio.NETWORK_MODE
