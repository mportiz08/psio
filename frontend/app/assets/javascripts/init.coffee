$ ->
  Psio.router = new Psio.Router()
  Backbone.history.start(pushState: true)
  
  # navView = new Psio.NavView(mode: Psio.mode)
  # $('body').append navView.el
  appView = new Psio.AppView()
