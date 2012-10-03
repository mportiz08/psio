class Psio.CPUListView extends Psio.BaseView
  template:  'cpu-list'
  className: 'row'
  
  init: ->
    @collection.on 'reset', @render, @
  
  render: ->
    console.debug "rendering cpu list", @collection
    @renderTemplate(cpus: @collection.toJSON())
