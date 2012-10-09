class Psio.CPU extends Backbone.Model
  initialize: ->
    @on 'change', @updatePersistentData
  
  currentUsage: ->
    time:  new Date().getTime()
    usage: @get('usage')
  
  updatePersistentData: ->
    @updateUsage() if @has('num') and @has('usage')
  
  updateUsage: ->
    current = @currentUsage()
    console.log 'yo', current
    path = "cpu#{@get('num')}.usage"
    rawData = localStorage[path]
    data = []
    data = JSON.parse(rawData) if rawData?
    data.push current
    localStorage[path] = JSON.stringify(data)
  
  usagePlots: ->
    path = "cpu#{@get('num')}.usage"
    rawData = localStorage[path]
    if rawData?
      data = JSON.parse(rawData)
      { x: item.time, y: item.usage } for item in data
    else
      [{ x: 0, y: 0 }]
