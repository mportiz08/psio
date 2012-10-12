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
    
    schedView   = new Psio.SchedulingNavView()
    procsView   = new Psio.ProcessListView(collection: procList)
    
    Psio.content.html('')
    Psio.content.append(schedView.el)
    Psio.content.append(procsView.el)
    
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
    
    schedView   = new Psio.SchedulingNavView(template: 'scheduling-nav-cpu')
    cpusView    = new Psio.CPUListView(collection: cpuList)
    
    Psio.content.html('')
    Psio.content.append(schedView.el)
    Psio.content.append(cpusView.el)
    
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
    
    cpuView     = new Psio.CPUDetailView(model: cpu)
    cpuGraph    = new Psio.CPUGraphView(model: cpu)
    
    Psio.content.html('')
    Psio.content.append(cpuView.el)
    Psio.content.append(cpuGraph.el)
    
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
