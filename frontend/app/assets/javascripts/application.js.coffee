#= require      ./vendor/jquery-1.8.1.min.js
#= require      ./vendor/underscore-min.js
#= require      ./vendor/backbone-min.js
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

Psio.mode       = Psio.SCHEDULING_MODE
