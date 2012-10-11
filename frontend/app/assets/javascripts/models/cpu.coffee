class Psio.CPU extends Backbone.Model
  initialize: ->
    @resetUsage()
    @on 'change', @updatePersistentData
  
  currentUsage: ->
    time:  new Date().getTime()
    usage: @get('usage')
  
  updatePersistentData: ->
    @updateUsage() if @has('num') and @has('usage')
  
  updateUsage: ->
    current = @currentUsage()
    path = "cpu#{@get('num')}.usage"
    rawData = localStorage[path]
    data = []
    data = JSON.parse(rawData) if rawData?
    data.push current
    localStorage[path] = JSON.stringify(data)
  
  resetUsage: ->
    path = "cpu#{@get('num')}.usage"
    localStorage.removeItem(path)
  
  usagePlots: ->
    path = "cpu#{@get('num')}.usage"
    rawData = localStorage[path]
    if rawData?
      data = JSON.parse(rawData)
      { x: idx, y: item.usage } for item, idx in data
    else
      [{ x: 0, y: 0 }]
