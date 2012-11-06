class Psio.Command
  @create: (name) ->
    JSON.stringify(type: 'command', data: { name: name })

Psio.GetHostInfoCommand      = Psio.Command.create('host.getstats')
Psio.GetAllProcessesCommand  = Psio.Command.create('process.getall')
Psio.GetAllCPUsCommand       = Psio.Command.create('cpu.getall')
Psio.GetAllMemoryCommand     = Psio.Command.create('memory.getall')
Psio.GetAllDisksCommand      = Psio.Command.create('disk.getall')
Psio.GetRootDiskStatsCommand = Psio.Command.create('disk.root.getstats')
Psio.GetNetworkStatsCommand  = Psio.Command.create('network.getstats')
