class Psio.AppDetailView extends Psio.BaseView
  template:  'app-detail'
  className: 'row'
  
  init: ->
    @collection.on 'reset', @render, @
  
  render: ->
    pids = @collection.map (p) ->
      Handlebars.helpers.linkToProcess(p.get('pid')).string
    @renderTemplate
      application: @options.application
      pids:        new Handlebars.SafeString(pids.join(', '))
      totalCPU:    @collection.totalCPUUsage()
      totalMemory: @collection.totalMemoryUsage()
      processes:   @collection.toJSON()
    @
