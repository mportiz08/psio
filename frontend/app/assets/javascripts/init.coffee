$ ->
  Psio.settings = JSON.parse($('#settings').text())
  
  Psio.appView = new Psio.AppView()
  Psio.router  = new Psio.Router()
  
  Psio.content = Psio.appView.contentView.$el.find('.container').first()
  
  Backbone.history.start(pushState: true)
