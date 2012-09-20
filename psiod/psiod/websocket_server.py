import sys
import signal
import json
import tornado
from tornado import websocket
from .process_monitor import ProcessMonitor

class WebSocketServer(websocket.WebSocketHandler):
  def open(self):
    print 'socket opened'
    self.application.monitor.foo()
  
  def on_message(self, msg):
    print 'msg: ' + msg
    procs = self.application.monitor.all_processes()
    self.write_message(json.dumps(procs))
  
  def on_close(self):
    print 'socket closed'

def die_gracefully(signal, frame):
  print 'psiod terminated'
  sys.exit(0)

def main():
  print 'psiod started'
  signal.signal(signal.SIGINT, die_gracefully)
  app = tornado.web.Application([
    (r"/", WebSocketServer),
  ])
  app.monitor = ProcessMonitor()
  app.listen(8888)
  tornado.ioloop.IOLoop.instance().start()
