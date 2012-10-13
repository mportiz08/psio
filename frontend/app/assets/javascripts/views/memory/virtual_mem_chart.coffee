class Psio.VirtualMemChart extends Psio.BaseView
  template:  'virtual-mem-chart'
  className: 'row memory'
  
  init: ->
    @model.on 'change', @renderInfo, @
    @model.on 'change', @renderChart, @
  
  render: ->
    @renderTemplate()
    @
  
  renderInfo: ->
    @renderVirtualInfo()
    @renderSwapInfo()
  
  renderInfo: ->
    element  = $('#virtual-mem-info')
    template = 'virtual-mem-info'
    data     = @model.attributes
    @renderTemplateForElement(element, template, data)
  
  renderChart: ->
    w = 500
    h = 500
    r = 250
    
    chart = $('#virtual-mem-chart')
    color = d3.scale.category20c()

    total = @model.attributes.total
    # format values for pie chart
    data = _.map @model.attributes, (v, k) ->
      label: k
      value: (v / total) * 100
    # filter out free, wired, active, and inactive portions
    data = _.select data, (item) ->
      _.contains ['free', 'wired', 'active', 'inactive'], item.label
    
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
