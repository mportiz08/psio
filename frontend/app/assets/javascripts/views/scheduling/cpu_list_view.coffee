class Psio.CPUListView extends Psio.BaseView
  template:  'cpu-list'
  className: 'row'
  
  init: ->
    @collection.on 'reset', @render, @
  
  render: ->
    @renderTemplate(cpus: @collection.toJSON())
