from process_monitor import ProcessMonitor

class MonitorCommand:
  def __init__(self):
    self.monitor = ProcessMonitor()
  
  def execute(self):
    raise Exception('Should be implemented in a subclass.')

class GetAllProcesses(MonitorCommand):
  def execute(self):
    return self.monitor.all_processes()
