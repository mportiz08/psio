class Psio.HostInfoView extends Backbone.View
  id: 'hostinfo'
  
  initialize: ->
    @render()
  
  render: ->
    @$el.html('host: marcus.local') # temp
    @
