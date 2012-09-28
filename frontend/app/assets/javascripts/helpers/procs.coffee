processThreads = (threads) ->
  if threads?
    threads
  else
    '-'

processCPU = (percent) ->
  return '-' unless percent?
  "#{percent} %"

processMemory = (bytes) ->
  return '-' unless bytes?
  
  mb = (bytes / 1048576).toFixed(1)
  "#{mb} MB"

linkToProcess = (name) ->
  href = "/process/#{Psio.slug(name)}"
  new Handlebars.SafeString("<a href=\"#{href}\">#{name}</a>")

Handlebars.registerHelper 'processThreads', processThreads
Handlebars.registerHelper 'processCPU',     processCPU
Handlebars.registerHelper 'processMemory',  processMemory
Handlebars.registerHelper 'linkToProcess',  linkToProcess
