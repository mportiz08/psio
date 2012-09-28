class Psio.SchedulingNavView extends Psio.BaseView
  template:  'scheduling-nav'
  className: 'row'
  
  render: ->
    @renderTemplate()
    @addTooltips()
    @
  
  addTooltips: ->
    @$el.find('a[rel="tooltip"]').tooltip()
