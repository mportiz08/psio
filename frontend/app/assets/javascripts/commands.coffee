class Psio.Command
  constructor: (@name, @args=undefined) ->
  
  create: ->
    Psio.Command.create(@name, @args)
  
  @create: (name, args=undefined) ->
    data = { name: name }
    _.defaults(data, args) if args?
    JSON.stringify(type: 'command', data: data)

Psio.GetHostInfoCommand      = Psio.Command.create('host.getstats')
Psio.GetAllProcessesCommand  = Psio.Command.create('process.getall')
Psio.GetAllCPUsCommand       = Psio.Command.create('cpu.getall')
Psio.GetAllMemoryCommand     = Psio.Command.create('memory.getall')
Psio.GetAllDisksCommand      = Psio.Command.create('disk.getall')
Psio.GetRootDiskStatsCommand = Psio.Command.create('disk.root.getstats')
Psio.GetNetworkStatsCommand  = Psio.Command.create('network.getstats')

Psio.GetProcessCommand = (pid) ->
  (new Psio.Command('process.get', { pid: pid })).create()
