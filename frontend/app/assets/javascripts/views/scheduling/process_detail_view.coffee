class Psio.ProcessDetailView extends Psio.BaseView
  template: 'proc-detail'
  className: 'row'
  
  events:
    'click #kill-btn': 'killProcess'
  
  init: ->
    @model.on 'change', @render, @
  
  render: ->
    @renderTemplate(process: @model.toJSON())
    @
  
  killProcess: ->
    return unless @options.ws and @model.has('pid')
    
    cmd = Psio.KillProcessCommand(@model.get('pid'))
    @options.ws.send(cmd)
    @options.ws.close() # TODO: possible race condition?
    
    Psio.router.navigate 'scheduling', trigger: true, replace: true
