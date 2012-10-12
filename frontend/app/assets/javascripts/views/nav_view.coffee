class Psio.NavView extends Psio.BaseView
  template: 'navigation'
  tagName: 'header'
  
  init: ->
    @on 'setmode', (data) ->
      @setMode(data.mode)
    , @
  
  render: ->
    @renderTemplate()
    @
  
  setMode: (mode) ->
    @$el.find('h1').removeClass('selected')
    @$el.find("h1.#{mode}").addClass('selected')
