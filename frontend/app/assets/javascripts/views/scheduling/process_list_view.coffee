class Psio.ProcessListView extends Psio.BaseView
  template:  'proc-list'
  className: 'row'
  
  init: ->
    @collection.on 'reset', @render, @
  
  render: ->
    @renderTemplate(processes: @collection.toJSON())
