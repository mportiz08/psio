class Psio.MemoryViewDisk extends Psio.BaseView
  template:  'memory'
  className: 'row memory'
  
  init: ->
    @disksInfoView = new Psio.MemInfoView(collection: @collection, template: 'memory-info-disk')
    @memChartView = new Psio.DiskSpaceChart(model: @model)
    
    @model.on 'change', @renderChart, @
    @collection.on 'reset', @renderInfo, @
  
  render: ->
    @renderTemplate()
    @
  
  renderChart: ->
    @memChartView.render()
    chartSection = @$el.find('#mem-chart')
    chartSection.html(@memChartView.el)
    @
  
  renderInfo: ->
    @disksInfoView.render()
    infoSection = @$el.find('#mem-info')
    infoSection.html(@disksInfoView.el)
    @
    