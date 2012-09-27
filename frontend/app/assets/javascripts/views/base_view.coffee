class Psio.BaseView extends Backbone.View
  initialize: ->
    @template = @options.template if @options.template?
    @render()
  
  renderTemplate: (data) ->
    @$el.html(JST["templates/#{@template}"](data))
    @
