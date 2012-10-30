class Psio.NetworkNavView extends Psio.BaseView
  template:  'network-nav'
  className: 'row'
  
  render: ->
    @renderTemplate()
    @addTooltips()
    @
  
  addTooltips: ->
    @$el.find('a[rel="tooltip"]').tooltip()
