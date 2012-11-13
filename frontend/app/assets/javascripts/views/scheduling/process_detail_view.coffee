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
    return unless @options.ws
    
    # TODO
