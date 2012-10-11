class Psio.CPUDetailView extends Psio.BaseView
  template:  'cpu-detail'
  className: 'row'
  
  init: ->
    @model.on 'change', @render, @
  
  render: ->
    @renderTemplate(cpu: @model.toJSON())
