class Psio.MemInfoView extends Psio.BaseView
  template: 'memory-info'
  
  render: ->
    if @model?
      @renderTemplate(memory: @model.attributes)
    else if @collection?
      disks = @collection.map (disk) ->
        disk.attributes
      @renderTemplate(disks: disks)
    @