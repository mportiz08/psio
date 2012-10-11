class Psio.Router extends Backbone.Router
  routes:
    '':                    'index'
    'scheduling':          'scheduling'
    'scheduling/cpu':      'cpuList'
    'scheduling/cpu/:num': 'cpuDetail'
    'memory':              'memory'
    'network':             'network'
  
  index: ->
    @navigate 'scheduling', trigger: true, replace: true
  
  scheduling: ->
    console.debug 'scheduling route'
    Psio.mode = Psio.SCHEDULING_MODE
    @setBgView()
    
    procList = new Psio.ProcessList()
    
    contentView = Psio.appView.contentView
    schedView   = new Psio.SchedulingNavView()
    procsView   = new Psio.ProcessListView(collection: procList)
    
    contentView.$el.find('.container').first().html('')
    contentView.$el.find('.container').first().append(schedView.el)
    contentView.$el.find('.container').first().append(procsView.el)
    
    ws = new WebSocket("ws://localhost:8888")
    
    ws.onmessage = (event) ->
      resp  = JSON.parse(event.data)
      procs = resp.data
      procList.reset(procs)
    
    ws.onopen = ->
      psm = new Psio.ProcessMonitor(ws)
      psm.start()
  
  cpuList: ->
    console.debug 'scheduling/cpu route'
    Psio.mode = Psio.SCHEDULING_MODE
    @setBgView()
    
    cpuList = new Psio.CPUList()
    
    contentView = Psio.appView.contentView
    schedView   = new Psio.SchedulingNavView(template: 'scheduling-nav-cpu')
    cpusView    = new Psio.CPUListView(collection: cpuList)
    
    contentView.$el.find('.container').first().html('')
    contentView.$el.find('.container').first().append(schedView.el)
    contentView.$el.find('.container').first().append(cpusView.el)
    
    ws = new WebSocket('ws://localhost:8888')
    
    ws.onmessage = (event) ->
      resp = JSON.parse(event.data)
      cpus = resp.data
      cpuList.reset(cpus)
    
    ws.onopen = ->
      psm = new Psio.ProcessMonitor(ws, Psio.GetAllCPUsCommand)
      psm.start()
  
  cpuDetail: (cpuNum) ->
    console.debug 'scheduling/cpu/:num route'
    Psio.mode = Psio.SCHEDULING_MODE
    @setBgView()
    
    cpu = new Psio.CPU(num: cpuNum)
    
    contentView = Psio.appView.contentView
    cpuView     = new Psio.CPUDetailView(model: cpu)
    cpuGraph    = new Psio.CPUGraphView(model: cpu)
    
    contentView.$el.find('.container').first().html('')
    contentView.$el.find('.container').first().append(cpuView.el)
    contentView.$el.find('.container').first().append(cpuGraph.el)
    
    ws = new WebSocket('ws://localhost:8888')
    
    ws.onmessage = (event) ->
      resp = JSON.parse(event.data)
      cpus = resp.data
      cpu.set(cpus[cpuNum])
    
    ws.onopen = ->
      psm = new Psio.ProcessMonitor(ws, Psio.GetAllCPUsCommand)
      psm.start()
  
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
