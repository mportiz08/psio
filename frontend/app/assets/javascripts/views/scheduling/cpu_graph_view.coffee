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
      renderer: 'area'
      width:    960
      height:   400
      max:      100
      stroke:   true
      series:   [{
        name:  'usage %'
        color: 'rgba(173, 216, 230, 0.8)'
        stroke: 'rgba(0, 0, 0, 0.3)'
        data:   @model.usagePlots()
      }]
    
    @legend = new Rickshaw.Graph.Legend
      graph: @graph,
      element: @$el.find('#cpu-graph').get(0)
    
    @graph.render()
