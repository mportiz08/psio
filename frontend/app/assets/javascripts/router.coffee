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
    @setBgView()
    
    ws = new WebSocket("ws://localhost:8888")
    ws.onmessage = (event) ->
      resp = JSON.parse(event.data)
      data = resp.data
      
      procs        = (new Psio.Process(proc) for proc in data)
      process_list = new Psio.ProcessList(procs)
      console.debug process_list
      
      contentView = Psio.appView.contentView
      schedView   = new Psio.SchedulingNavView()
      procsView   = new Psio.ProcessListView(collection: process_list)
      
      contentView.$el.find('.container').first().append(schedView.el)
      contentView.$el.find('.container').first().append(procsView.el)
    ws.onopen = ->
      getAllProcessesCmd =
        type: 'command'
        data:
          name: 'process.getall'
      ws.send(JSON.stringify(getAllProcessesCmd))
  
  memory: ->
    console.debug 'memory route'
    Psio.mode = Psio.MEMORY_MODE
    @setBgView()
    
  network: ->
    console.debug 'network route'
    Psio.mode = Psio.NETWORK_MODE
    @setBgView()
  
  setBgView: (type) ->
    Psio.bgView = new Psio.BgView(template: "bg-#{Psio.mode}")
    $('body').append(Psio.bgView.el)
