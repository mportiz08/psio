class Psio.NetworkStatsGraph extends Psio.BaseView
  className: 'row'
  template:  'network-stats-graph'
  yBuffer:   50

  render: ->
    @renderTemplate()
    @
  
  renderGraph: ->
    return unless @model?
    
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
      
    @graph = new Rickshaw.Graph
      element:  graphEl
      renderer: 'line'
      width:    960
      height:   500
      min:      -1  # real min is 0, using -1 for display purposes
      max:      103 # real max is 100, using 103 for display purposes
      interpolation: 'linear'
      series:   [
        {
          name:  'upload speed (bytes per second)'
          color: palette.color()
          data:  [{x: 0, y: 0}]
        },
        {
          name:  'download speed (bytes per second)'
          color: palette.color()
          data:  [{x: 0, y: 0}]
        }
      ]
    
    @legend = new Rickshaw.Graph.Legend
      graph: @graph,
      element: graphEl
    
    @axisX = new Rickshaw.Graph.Axis.Time
      graph: @graph
    @axisY = new Rickshaw.Graph.Axis.Y
      graph: @graph
  
  updateGraph: ->
    plots = @model.graphPlots()
    
    getVals = (plot) ->
      plot.y
    
    # update the maximum value for the graph based on new data
    @graph.max = _.max(_.map(_.flatten(plots), getVals)) + @options.yBuffer
    
    @graph.series[0].data = plots[0]
    @graph.series[1].data = plots[1]
