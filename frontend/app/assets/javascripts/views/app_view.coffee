class Psio.AppView extends Backbone.View
  initialize: ->
    @navView      = new Psio.NavView(mode: Psio.SCHEDULING_MODE)
    @contentView  = new Psio.ContentView()
    @hostinfoView = new Psio.HostInfoView(model: new Psio.Host())
    @render()
  
  render: ->
    $('body').append(@navView.el)
    $('body').append(@contentView.el)
    $('body').append(@hostinfoView.el)
    @
