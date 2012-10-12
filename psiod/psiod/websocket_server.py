import command
import json
import logging
from tornado import websocket

COMMANDS = {
  'process.getall': command.GetAllProcesses,
  'cpu.getall':     command.GetAllCPUs,
  'memory.getall':  command.GetAllMemory
}

class WebSocketServer(websocket.WebSocketHandler):
  def open(self):
    logging.debug('socket opened')
  
  def on_message(self, raw_msg):
    logging.debug('msg: ' + raw_msg)
    
    msg = json.loads(raw_msg)
    if msg['type'] == 'command':
      self.process_command(msg['data']['name'])
  
  def on_close(self):
    logging.debug('socket closed')
  
  def process_command(self, cmd_name):
    cmd  = COMMANDS[cmd_name]()
    data = cmd.execute()
    
    resp = dict(type='response', data=data)
    self.write_message(json.dumps(resp))
