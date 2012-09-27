class Psio.NavView extends Psio.BaseView
  template: 'navigation'
  tagName: 'header'
  
  render: ->
    @renderTemplate
      scheduling: @options.mode is Psio.SCHEDULING_MODE
      memory:     @options.mode is Psio.MEMORY_MODE
      network:    @options.mode is Psio.NETWORK_MODE
