class Psio.Command
  @create: (name) ->
    JSON.stringify(type: 'command', data: { name: name })

Psio.GetAllProcessesCommand = Psio.Command.create('process.getall')
Psio.GetAllCPUsCommand      = Psio.Command.create('cpu.getall')
