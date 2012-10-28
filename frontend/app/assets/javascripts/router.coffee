class Psio.Router extends Backbone.Router
  routes:
    '':                    'index'
    'scheduling':          'scheduling'
    'scheduling/cpu':      'cpuList'
    'scheduling/cpu/:num': 'cpuDetail'
    'memory':              'memory'
    'memory/disk':         'memoryDisk'
    'network':             'network'
  
  index: ->
    @navigate 'scheduling', trigger: true, replace: true
  
  scheduling: ->
    console.debug 'scheduling route'
    Psio.setSchedulingMode()
    
    procList = new Psio.ProcessList()
    
    schedView = new Psio.SchedulingNavView()
    procsView = new Psio.ProcessListView(collection: procList)
    
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
    Psio.setSchedulingMode()
    
    cpuList = new Psio.CPUList()
    
    schedView = new Psio.SchedulingNavView(template: 'scheduling-nav-cpu')
    cpusView  = new Psio.CPUListView(collection: cpuList)
    
    graphOpts =
      collection: cpuList
      graphEl:    '#cpu-list-graph'
      template:   'cpu-list-graph'
    graphs    = new Psio.GraphCollectionView(graphOpts)
    
    Psio.content.html('')
    Psio.content.append(schedView.el)
    Psio.content.append(cpusView.el)
    Psio.content.append(graphs.el)
    
    ws = new WebSocket('ws://localhost:8888')
    
    ws.onmessage = (event) ->
      resp = JSON.parse(event.data)
      cpus = resp.data
      
      if cpuList.isEmpty()
        cpuList.reset(cpus)
      else
        cpuList.each (cpu, i) ->
          cpu.set(cpus[i])
          cpu.updateMetrics()
        graphs.renderGraph()
    
    ws.onopen = ->
      psm = new Psio.ProcessMonitor(ws, Psio.GetAllCPUsCommand)
      psm.start()
  
  cpuDetail: (cpuNum) ->
    console.debug 'scheduling/cpu/:num route'
    Psio.setSchedulingMode()
    
    cpu = new Psio.CPU(num: cpuNum)
    
    cpuView  = new Psio.CPUDetailView(model: cpu)
    cpuGraph = new Psio.CPUGraphView(model: cpu)
    
    Psio.content.html('')
    Psio.content.append(cpuView.el)
    Psio.content.append(cpuGraph.el)
    
    ws = new WebSocket('ws://localhost:8888')
    
    ws.onmessage = (event) ->
      resp = JSON.parse(event.data)
      cpus = resp.data
      cpu.set(cpus[cpuNum])
      cpu.updateMetrics()
    
    ws.onopen = ->
      psm = new Psio.ProcessMonitor(ws, Psio.GetAllCPUsCommand)
      psm.start()
  
  memory: ->
    console.debug 'memory route'
    Psio.setMemoryMode()
    
    memory = new Psio.Memory()
    
    memNav  = new Psio.MemoryNavView()
    memView = new Psio.MemoryView(model: memory)
    
    Psio.content.html('')
    Psio.content.append(memNav.el)
    Psio.content.append(memView.el)
    
    ws = new WebSocket('ws://localhost:8888')
    
    ws.onmessage = (event) ->
      resp = JSON.parse(event.data)
      mem  = resp.data
      memory.set(mem)
    
    ws.onopen = ->
      psm = new Psio.ProcessMonitor(ws, Psio.GetAllMemoryCommand)
      psm.start(5000)
  
  memoryDisk: ->
    console.debug 'memory/disk route'
    Psio.setMemoryMode()
    
    disks  = new Psio.DiskList()
    memory = new Psio.Memory()
    
    memNav  = new Psio.MemoryNavView(template: 'memory-nav-disk')
    memView = new Psio.MemoryViewDisk(collection: disks)
    
    Psio.content.html('')
    Psio.content.append(memNav.el)
    Psio.content.append(memView.el)
    
    ws = new WebSocket('ws://localhost:8888')
    
    ws.onmessage = (event) ->
      resp      = JSON.parse(event.data)
      rawDisks  = resp.data
      disks.reset(rawDisks)
    
    ws.onopen = (event) ->
      psm = new Psio.ProcessMonitor(ws, Psio.GetAllDisksCommand)
      psm.start(0)
  
  network: ->
    console.debug 'network route'
    Psio.setNetworkMode()
    
    network = new Psio.NetworkInterface()
    
    Psio.content.html('')
    
    ws = new WebSocket('ws://localhost:8888')
    
    ws.onmessage = (event) ->
      resp  = JSON.parse(event.data)
      stats = resp.data
      console.log stats
      network.set(stats)
    
    ws.onopen = (event) ->
      psm = new Psio.ProcessMonitor(ws, Psio.GetNetworkStatsCommand)
      psm.start(1000)
