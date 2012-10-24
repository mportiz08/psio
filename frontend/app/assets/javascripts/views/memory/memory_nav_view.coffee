class Psio.MemoryNavView extends Psio.BaseView
  template:  'memory-nav'
  className: 'row'
  
  render: ->
    @renderTemplate()
    @addTooltips()
    @
  
  addTooltips: ->
    @$el.find('a[rel="tooltip"]').tooltip()
