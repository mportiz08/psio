class Psio.CPUGraphView extends Psio.BaseView
  template:  'cpu-graph'
  className: 'row'
  
  init: ->
    @model.on 'change', @render, @
  
  render: ->
    console.debug 'rendering cpu graph', @model
    @renderTemplate() unless @graph?
    @updateGraph()
    @
  
  updateGraph: ->
    @createGraph() unless @graph?
    @graph.series[0].data = @model.usagePlots()
    @graph.render()
  
  createGraph: ->
    console.log @model.usagePlots()
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
        data:   @model.usagePlots()
      }]
    
    @legend = new Rickshaw.Graph.Legend
      graph: @graph,
      element: @$el.find('#cpu-graph').get(0)
    
    @axisX = new Rickshaw.Graph.Axis.Time
      graph: @graph
    @axisY = new Rickshaw.Graph.Axis.Y
      graph: @graph
    
    @axisX.render()
    @axisY.render()
    @graph.render()
