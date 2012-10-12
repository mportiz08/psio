class Psio.CPUListView extends Psio.BaseView
  template:  'cpu-list'
  className: 'row'
  
  didInitialCPURender: false
  
  init: ->
    @collection.on 'reset', @render, @
    @collection.on 'reset', @updateProgressBars, @
  
  render: ->
    if @collection.length > 0 and !@didInitialCPURender
      @renderTemplate(cpus: @collection.toJSON())
      @didInitialCPURender = true
    @
  
  updateProgressBars: (cpus) ->
    bars     = $('.cpu-progress-bars .progress .bar')
    displays = $('.cpu-progress-bars .progress-display')
    
    cpus.each (cpu, i) ->
      display = displays.get(i)
      bar     = bars.get(i)
      
      percentage = "#{cpu.get('usage')}%"
      $(display).text(percentage)
      $(bar).css(width: percentage)
