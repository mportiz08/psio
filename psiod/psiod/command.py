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

class GetAllDisks(MonitorCommand):
  def execute(self):
    return self.monitor.all_disks()

class GetRootDiskStats(MonitorCommand):
  def execute(self):
    return self.monitor.root_disk_stats()

class GetNetworkStats(MonitorCommand):
  def execute(self):
    return self.monitor.network_stats()
