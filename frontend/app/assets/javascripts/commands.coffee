class Psio.Command
  @create: (name) ->
    JSON.stringify(type: 'command', data: { name: name })

Psio.GetAllProcessesCommand = Psio.Command.create('process.getall')
