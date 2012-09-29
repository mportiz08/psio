class Psio.ProcessListView extends Psio.BaseView
  template:  'proc-list'
  className: 'row'
  
  init: ->
    @collection.on 'reset', @render, @
  
  render: ->
    console.debug "rendering process list", @collection
    @renderTemplate(processes: @collection.toJSON())
