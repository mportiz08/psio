import command
import json
import logging
from tornado import websocket

COMMANDS = {
  'host.getstats':       command.GetHostInfo,
  'process.getall':      command.GetAllProcesses,
  'process.get':         command.GetProcess,
  'process.kill':        command.KillProcess,
  'cpu.getall':          command.GetAllCPUs,
  'memory.getall':       command.GetAllMemory,
  'disk.getall':         command.GetAllDisks,
  'disk.root.getstats':  command.GetRootDiskStats,
  'network.getstats':    command.GetNetworkStats
}

class WebSocketServer(websocket.WebSocketHandler):
  def open(self):
    logging.debug('socket opened')
  
  def on_message(self, raw_msg):
    logging.debug('msg: ' + raw_msg)
    
    msg = json.loads(raw_msg)
    if msg['type'] == 'command':
      cmd_name = msg['data'].pop('name')
      cmd_args = msg['data']
      self.process_command(cmd_name, cmd_args)
  
  def on_close(self):
    logging.debug('socket closed')
  
  def process_command(self, cmd_name, cmd_args):
    cmd  = COMMANDS[cmd_name](cmd_args)
    data = cmd.execute()
    
    if data is not None:
      resp = dict(type='response', data=data)
      self.write_message(json.dumps(resp))
