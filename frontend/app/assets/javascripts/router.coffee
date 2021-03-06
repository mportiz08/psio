class Psio.Router extends Backbone.Router
  routes:
    '':                    'index'
    'scheduling':          'scheduling'
    'scheduling/cpu':      'cpuList'
    'scheduling/cpu/:num': 'cpuDetail'
    'process/:pid':        'processDetail'
    'application':   'applicationDetail'
    'memory':              'memory'
    'memory/disk':         'memoryDisk'
    'network':             'network'
  
  index: ->
    @navigate 'scheduling', trigger: true, replace: true
  
  scheduling: (params) ->
    console.debug 'scheduling route', params
    Psio.setSchedulingMode()
    
    procList = new Psio.ProcessList()
    
    if params? and params.sort?
      procList.comparator = (proc) ->
        proc.get(params.sort)
    
    schedView = new Psio.SchedulingNavView()
    procsView = new Psio.ProcessListView(collection: procList)
    
    Psio.content.html('')
    Psio.content.append(schedView.el)
    Psio.content.append(procsView.el)
    
    ws = new WebSocket("ws://#{Psio.settings.host}:8888")
    
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
    
    ws = new WebSocket("ws://#{Psio.settings.host}:8888")
    
    ws.onmessage = (event) ->
      resp = JSON.parse(event.data)
      cpus = resp.data
      
      if cpuList.isEmpty()
        cpuList.reset(cpus)
      else
        cpuList.each (cpu, i) ->
          cpu.set(cpus[i])
          cpu.updateMetrics()
        cpusView.render()
        cpusView.updateProgressBars(cpuList)
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
    
    ws = new WebSocket("ws://#{Psio.settings.host}:8888")
    
    ws.onmessage = (event) ->
      resp = JSON.parse(event.data)
      cpus = resp.data
      cpu.set(cpus[cpuNum])
      cpu.updateMetrics()
    
    ws.onopen = ->
      psm = new Psio.ProcessMonitor(ws, Psio.GetAllCPUsCommand)
      psm.start()
  
  processDetail: (pid) ->
    console.debug 'process/:pid route'
    Psio.setSchedulingMode()
    
    process = new Psio.Process()
    
    procView = new Psio.ProcessDetailView(model: process)
    
    Psio.content.html('')
    Psio.content.append(procView.el)
    
    ws = new WebSocket("ws://#{Psio.settings.host}:8888")
    
    ws.onmessage = (event) ->
      resp = JSON.parse(event.data)
      proc = resp.data
      process.set(proc)
    
    ws.onopen = ->
      procView.options.ws = ws
      psm = new Psio.ProcessMonitor(ws, Psio.GetProcessCommand(pid))
      psm.start()
  
  applicationDetail: (params) ->
    console.debug 'application route', params
    Psio.setSchedulingMode()
    
    appName = Psio.urlDecode(params.name)
    
    procList = new Psio.ProcessList([], appName: appName)
    procList.comparator = (proc) ->
        proc.get('pid')
    
    appView  = new Psio.AppDetailView(collection: procList, application: appName)
    cpuGraph = new Psio.CPUGraphView(collection: procList)
    
    Psio.content.html('')
    Psio.content.append(appView.el)
    Psio.content.append(cpuGraph.el)
    
    ws = new WebSocket("ws://#{Psio.settings.host}:8888")
    
    ws.onmessage = (event) ->
      resp  = JSON.parse(event.data)
      procs = resp.data
      
      filteredProcs = _.filter procs, (p) ->
        p.name is appName
      
      procList.reset(filteredProcs)
      procList.updateMetrics()
      cpuGraph.renderGraph()
    
    ws.onopen = ->
      psm = new Psio.ProcessMonitor(ws)
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
    
    ws = new WebSocket("ws://#{Psio.settings.host}:8888")
    
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
    memView = new Psio.MemoryViewDisk(collection: disks, model: memory)
    
    Psio.content.html('')
    Psio.content.append(memNav.el)
    Psio.content.append(memView.el)
    
    disksWs = new WebSocket("ws://#{Psio.settings.host}:8888")
    spaceWs = new WebSocket("ws://#{Psio.settings.host}:8888")
    
    disksWs.onmessage = (event) ->
      resp      = JSON.parse(event.data)
      rawDisks  = resp.data
      disks.reset(rawDisks)
    
    disksWs.onopen = (event) ->
      psm = new Psio.ProcessMonitor(disksWs, Psio.GetAllDisksCommand)
      psm.start(0)
    
    spaceWs.onmessage = (event) ->
      resp = JSON.parse(event.data)
      mem  = resp.data
      memory.set(mem)
    
    spaceWs.onopen = (event) ->
      psm = new Psio.ProcessMonitor(spaceWs, Psio.GetRootDiskStatsCommand)
      psm.start(5000)
  
  network: ->
    console.debug 'network route'
    Psio.setNetworkMode()
    
    network = new Psio.NetworkInterface()
    
    nav = new Psio.NetworkNavView()
    
    graphOpts =
      model: network
      graphEl:    '#network-stats-graph'
      template:   'network-stats-graph'
    graph = new Psio.NetworkStatsGraph(graphOpts)
    
    Psio.content.html('')
    Psio.content.append(nav.el)
    Psio.content.append(graph.el)
    
    network.on 'change', graph.renderGraph, graph
    
    ws = new WebSocket("ws://#{Psio.settings.host}:8888")
    
    ws.onmessage = (event) ->
      resp  = JSON.parse(event.data)
      stats = resp.data
      network.set(stats)
      #network.updateMetrics()
    
    ws.onopen = (event) ->
      psm = new Psio.ProcessMonitor(ws, Psio.GetNetworkStatsCommand)
      psm.start(1000)
