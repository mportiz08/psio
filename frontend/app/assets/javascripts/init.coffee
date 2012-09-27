$ ->
  Psio.router = new Psio.Router()
  Backbone.history.start(pushState: true)
  
  appView = new Psio.AppView()
  Psio.appView = appView
