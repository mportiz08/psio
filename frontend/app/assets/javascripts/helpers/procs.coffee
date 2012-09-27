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

Handlebars.registerHelper 'processThreads', processThreads
Handlebars.registerHelper 'processCPU',     processCPU
Handlebars.registerHelper 'processMemory',  processMemory
