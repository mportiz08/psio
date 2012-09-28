$ ->
  Psio.appView = new Psio.AppView()
  Psio.router  = new Psio.Router()
  
  Backbone.history.start(pushState: true)
