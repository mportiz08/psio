class Psio.GraphCollectionView extends Psio.BaseView
  className: 'row'
  
  render: ->
    @renderTemplate()
    @
  
  renderGraph: ->
    return if @collection.isEmpty()
    
    if not @graph?
      @createGraph()
    else
      @updateGraph()
      @axisX.render()
      @axisY.render()
      @graph.render()
  
  createGraph: ->
    graphEl = @$el.find(@options.graphEl).get(0)
    palette = new Rickshaw.Color.Palette()
    
    
    series = @collection.map (item) ->
      name:  item.toString()
      color: palette.color()
      data:  item.graphPlots()
      
    @graph = new Rickshaw.Graph
      element:  graphEl
      renderer: 'line'
      width:    960
      height:   500
      min:      -1  # real min is 0, using -1 for display purposes
      max:      103 # real max is 100, using 103 for display purposes
      interpolation: 'linear'
      series:   series
    
    @legend = new Rickshaw.Graph.Legend
      graph: @graph,
      element: graphEl
    
    @axisX = new Rickshaw.Graph.Axis.Time
      graph: @graph
    @axisY = new Rickshaw.Graph.Axis.Y
      graph: @graph
  
  updateGraph: ->
    @collection.each (item, i) =>
      d = item.graphPlots()
      @graph.series[i].data = d
