import sys
import signal
import tornado
from tornado import websocket

class WebSocketServer(websocket.WebSocketHandler):
  def open(self):
    print 'socket opened'
  
  def on_message(self, msg):
    print msg
  
  def on_close(self):
    print 'socket closed'

def die_gracefully(signal, frame):
  print "psiod terminated"
  sys.exit(0)

def main():
  print "psiod started"
  signal.signal(signal.SIGINT, die_gracefully)
  app = tornado.web.Application([
    (r"/", WebSocketServer),
  ])
  app.listen(8888)
  tornado.ioloop.IOLoop.instance().start()
