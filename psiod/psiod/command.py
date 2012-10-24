from process_monitor import ProcessMonitor

class MonitorCommand:
  def __init__(self):
    self.monitor = ProcessMonitor()
  
  def execute(self):
    raise Exception('Should be implemented in a subclass.')

class GetAllProcesses(MonitorCommand):
  def execute(self):
    return self.monitor.all_processes()

class GetAllCPUs(MonitorCommand):
  def execute(self):
    return self.monitor.all_cpus()

class GetAllMemory(MonitorCommand):
  def execute(self):
    return self.monitor.all_memory()
