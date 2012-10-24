class Psio.BaseView extends Backbone.View
  initialize: ->
    @init() if @init?
    
    @template = @options.template if @options.template?
    @render()
  
  renderTemplate: (data) ->
    @$el.html(JST["templates/#{@template}"](data))
    @
  
  renderTemplateForElement: (el, template, data) ->
    el.html(JST["templates/#{template}"](data))
