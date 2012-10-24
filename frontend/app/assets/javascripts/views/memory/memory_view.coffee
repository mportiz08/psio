class Psio.MemoryView extends Psio.BaseView
  template:  'memory'
  className: 'row memory'
  
  init: ->
    @memInfoView  = new Psio.MemInfoView(model: @model)
    @memChartView = new Psio.VirtualMemChart(model: @model)
    
    @model.on 'change', @renderSubViews, @
  
  render: ->
    @renderTemplate()
    @
  
  renderSubViews: ->
    @memInfoView.render()
    @memChartView.render()
    
    infoSection = @$el.find('#mem-info')
    infoSection.html(@memInfoView.el)
    
    chartSection = @$el.find('#mem-chart')
    chartSection.html(@memChartView.el)
    @
    