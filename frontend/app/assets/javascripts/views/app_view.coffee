class Psio.AppView extends Backbone.View
  initialize: ->
    @navView     = new Psio.NavView(mode: Psio.mode)
    @bgView      = new Psio.BgView()
    @contentView = new Psio.ContentView()
    @render()
  
  render: ->
    $('body').append(@navView.el)
    $('body').append(@bgView.el)
    $('body').append(@contentView.el)
    @
