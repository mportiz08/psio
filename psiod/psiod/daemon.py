import logging
import signal
import sys
import tornado
from websocket_server import WebSocketServer

def die_gracefully(signal, frame):
  logging.info('psiod terminated')
  sys.exit(0)

def setup_logging():
  logging.basicConfig(format="%(asctime)s %(levelname)s: %(message)s",
                      datefmt='%Y-%m-%d %H:%M:%S',
                      level=logging.DEBUG)
  logging.info('psiod started')

def handle_sigint():
  signal.signal(signal.SIGINT, die_gracefully)

def setup_daemon():
  app = tornado.web.Application([
    (r"/", WebSocketServer),
  ])
  app.listen(8888)
  tornado.ioloop.IOLoop.instance().start()

def main():
  setup_logging()
  handle_sigint()
  setup_daemon()
