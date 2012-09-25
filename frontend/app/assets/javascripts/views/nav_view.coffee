class Psio.NavView extends Psio.BaseView
  template: 'navigation'
  tagName: 'header'
  
  render: ->
    @renderTemplate(mode: @options.mode)
