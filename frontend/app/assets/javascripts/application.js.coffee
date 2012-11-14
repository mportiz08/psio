#= require      ./vendor/jquery-1.8.1.min.js
#= require      ./vendor/underscore-min.js
#= require      ./vendor/backbone-min.js
#= require      ./vendor/backbone.queryparams.js
#= require      ./vendor/bootstrap.min.js
#= require      ./vendor/d3-v2.min.js
#= require      ./vendor/rickshaw-1.1.2.min.js
#= require      handlebars
#= require_self
#= require      ./commands.coffee
#= require      ./store.coffee
#= require_tree ./models
#= require_tree ./collections
#= require      ./helpers/global.coffee
#= require_tree ./helpers
#= require_tree ./templates
#= require      ./views/base_view.coffee
#= require_tree ./views
#= require      ./router.coffee
#= require      ./init.coffee

window.Psio = {}

Psio.SCHEDULING_MODE = 'scheduling'
Psio.MEMORY_MODE     = 'memory'
Psio.NETWORK_MODE    = 'network'

Psio.setMode = (mode) ->
  Psio.appView.navView.trigger('setmode', mode: mode)
  Psio.setBackground(mode)

Psio.setBackground = (mode) ->
  Psio.bgView = new Psio.BgView(template: "bg-#{mode}")
  $('body').append(Psio.bgView.el)

Psio.setSchedulingMode = ->
  Psio.setMode(Psio.SCHEDULING_MODE)

Psio.setMemoryMode = ->
  Psio.setMode(Psio.MEMORY_MODE)

Psio.setNetworkMode = ->
  Psio.setMode(Psio.NETWORK_MODE)
