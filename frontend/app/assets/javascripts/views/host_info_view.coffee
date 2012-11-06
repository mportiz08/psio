class Psio.HostInfoView extends Backbone.View
  id: 'hostinfo'
  
  initialize: ->
    @model.on 'change', @render, @
    @render()
  
  render: ->
    html = "host: <strong>#{@model.hostname()}</strong>"
    @$el.html(html)
    @
