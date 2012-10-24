class Psio.MemInfoView extends Psio.BaseView
  template: 'memory-info'
  
  render: ->
    @renderTemplate(memory: @model.attributes)
    @