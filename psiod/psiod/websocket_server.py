import sys
import signal
import logging
import json
import tornado
from tornado import websocket
from .process_monitor import ProcessMonitor

class GetAllProcessesCommand:
  def __init__(self):
    self.monitor = ProcessMonitor()
  
  def execute(self):
    return self.monitor.all_processes()

COMMANDS = {
  'process.getall': GetAllProcessesCommand
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
    cmd = COMMANDS[cmd_name]()
    procs = cmd.execute()
    self.write_message(json.dumps(procs))

def die_gracefully(signal, frame):
  logging.info('psiod terminated')
  sys.exit(0)

def main():
  logging.basicConfig(format="%(asctime)s %(levelname)s: %(message)s",
                      datefmt='%Y-%m-%d %H:%M:%S',
                      level=logging.DEBUG)
  logging.info('psiod started')
  
  signal.signal(signal.SIGINT, die_gracefully)
  app = tornado.web.Application([
    (r"/", WebSocketServer),
  ])
  app.listen(8888)
  tornado.ioloop.IOLoop.instance().start()
