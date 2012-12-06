class Psio.CPUGraphView extends Psio.BaseView
  template:  'cpu-graph'
  className: 'row'
  
  init: ->
    @model.on 'change', @renderGraph, @ if @model?
    #@collection.on 'reset', @renderGraph, @ if @collection?
  
  render: ->
    @renderTemplate()
    @createGraph()
    @
  
  renderGraph: ->
    @updateGraph()
    
    @axisX.render()
    @axisY.render()
    @graph.render()
  
  createGraph: ->
    @graph = new Rickshaw.Graph
      element:  @$el.find('#cpu-graph').get(0)
      renderer: 'line'
      width:    960
      height:   500
      min:      -1  # real min is 0, using -1 for display purposes
      max:      103 # real max is 100, using 103 for display purposes
      interpolation: 'linear'
      series:   [{
        name:  'usage %'
        color: '#30c020'
        data:  [{ x: 0, y: 0 }]
      }]
    
    @legend = new Rickshaw.Graph.Legend
      graph: @graph,
      element: @$el.find('#cpu-graph').get(0)
    
    @axisX = new Rickshaw.Graph.Axis.Time
      graph: @graph
    @axisY = new Rickshaw.Graph.Axis.Y
      graph: @graph
  
  updateGraph: ->
    @graph.series[0].data = @model.graphPlots() if @model?
    @graph.series[0].data = @collection.graphPlots() if @collection?
