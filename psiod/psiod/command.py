from process_monitor import ProcessMonitor

class MonitorCommand(object):
  def __init__(self, args):
    self.monitor = ProcessMonitor()
  
  def execute(self):
    raise Exception('Should be implemented in a subclass.')

class GetHostInfo(MonitorCommand):
  def execute(self):
    return self.monitor.host_info()

class GetAllProcesses(MonitorCommand):
  def execute(self):
    return self.monitor.all_processes()

class GetProcess(MonitorCommand):
  def __init__(self, args):
    super(GetProcess, self).__init__(args)
    self.pid = args['pid']
  
  def execute(self):
    return self.monitor.process(self.pid)

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
