class Psio.ProcessListView extends Psio.BaseView
  template:  'proc-list'
  tagName:   'table'
  className: 'proc-list table table-condensed table-bordered'
  
  render: ->
    @renderTemplate(processes: @collection.toJSON())
