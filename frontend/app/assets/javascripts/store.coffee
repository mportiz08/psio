class Psio.Store
  constructor: (@key, val) ->
    @store = window.localStorage
    @set(val) if val?
  
  encode: (obj) ->
    JSON.stringify(obj)
  
  decode: (str) ->
    JSON.parse(str)
  
  set: (val) ->
    @store.setItem(@key, @encode(val))
  
  get: ->
    @decode(@store.getItem(@key))
  
  push: (val) ->
    arr = @get()
    arr = [] unless arr?
    arr.push(val)
    @set(arr)
  
  reset: ->
    @store.removeItem(@key)
