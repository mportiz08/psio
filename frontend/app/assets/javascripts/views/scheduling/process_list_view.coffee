class Psio.ProcessListView extends Psio.BaseView
  template:  'proc-list'
  className: 'row'
  
  render: ->
    @renderTemplate(processes: @collection.toJSON())
