class Psio.CPUDetailView extends Psio.BaseView
  template:  'cpu-detail'
  className: 'row'
  
  init: ->
    @model.on 'change', @render, @
  
  render: ->
    console.debug "rendering cpu", @model
    @renderTemplate(cpu: @model.toJSON())
