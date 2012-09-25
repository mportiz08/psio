class Psio.BaseView extends Backbone.View
  initialize: ->
    @render()
  
  renderTemplate: (data) ->
    @$el.html(JST["templates/#{@template}"](data))
    @
