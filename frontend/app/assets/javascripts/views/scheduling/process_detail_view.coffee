class Psio.ProcessDetailView extends Psio.BaseView
  template: 'proc-detail'
  className: 'row'
  
  init: ->
    @model.on 'change', @render, @
  
  render: ->
    @renderTemplate(process: @model.toJSON())
    @
