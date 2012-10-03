class Psio.CPUGraphView extends Psio.BaseView
  template:  'cpu-graph'
  className: 'row'
  
  init: ->
    @collection.on 'reset', @render, @
  
  render: ->
    console.debug 'rendering cpu graph', @collection
    @renderTemplate() unless @graph?
    @updateGraph()
    @
  
  updateGraph: ->
    @createGraph() unless @graph?
    @graph.render()
  
  createGraph: ->
    @graph = new Rickshaw.Graph
      element:  @$el.find('#cpu-graph').get(0)
      renderer: 'area'
      width:    960
      height:   200
      stroke:   true
      max:      100
      series:   [{
        name:  'cpu0'
        color: 'rgba(192,132,255,0.3)'
        data: [ 
          { x: 0, y: 40 } 
          { x: 1, y: 49 } 
          { x: 2, y: 38 } 
          { x: 3, y: 30 } 
          { x: 4, y: 32 }
        ]
      }, {
        name:  'cpu1'
        color: 'rgba(96,170,255,0.5)'
        data: [
          { x: 0, y: 30 } 
          { x: 1, y: 39 } 
          { x: 2, y: 28 } 
          { x: 3, y: 20 } 
          { x: 4, y: 22 } 
        ] 
      }]
    @graph.renderer.unstack = true
    
    @legend = new Rickshaw.Graph.Legend
      graph: @graph,
      element: @$el.find('#cpu-graph').get(0)
    
    @graph.render()
