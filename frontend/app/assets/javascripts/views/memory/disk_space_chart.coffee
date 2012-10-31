class Psio.DiskSpaceChart extends Psio.BaseView
  template:  'disk-space-chart'
  className: 'row memory'
  
  render: ->
    @renderTemplate()
    @renderChart()
    @
  
  renderChart: ->
    w = 500
    h = 500
    r = 250
    
    chart = @$el.find('#disk-space-chart')
    
    return @ unless (chart? && @model.has('total'))
    
    color = d3.scale.category20c()

    total = @model.get('total')
    # format values for pie chart
    data = _.map @model.attributes, (v, k) ->
      label: k
      value: (v / total) * 100
    # filter out used and free portions
    data = _.select data, (item) ->
      _.contains ['used', 'free'], item.label
    
    chart.html('')
    vis = d3.select(chart.get(0))
            .append("svg:svg")
            .data([data])
            .attr("width", w)
            .attr("height", h)
            .append("svg:g")
            .attr("transform", "translate(" + r + "," + r + ")")
            
    arc = d3.svg.arc().outerRadius(r)

    pie = d3.layout.pie().value (d) -> 
      d.value

    arcs = vis.selectAll("g.slice")
              .data(pie)
              .enter()
              .append("svg:g")
              .attr("class", "slice")

    arcs.append("svg:path")
        .attr("fill", (d, i) ->
          color(i)
        )
        .attr("d", arc)

    arcs.append("svg:text")
        .attr("transform", (d) ->
          d.innerRadius = 0
          d.outerRadius = r
          "translate(" + arc.centroid(d) + ")"
        )
        .attr("text-anchor", "middle")
        .text((d, i) ->
          data[i].label)
    
    @
