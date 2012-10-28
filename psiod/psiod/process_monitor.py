import os
import psutil

class ProcessMonitor:
  def __init__(self, limited_by_user=True):
    self.user = os.environ['USER']
    self.limited_by_user = limited_by_user
  
  def all_processes(self):
    procs = []
    for p in psutil.process_iter():
      try:
        p.dict = p.as_dict([
          'pid',
          'username',
          'get_nice',
          'get_memory_info',
          'get_memory_percent',
          'get_cpu_percent',
          'get_cpu_times',
          'get_num_threads',
          'name',
          'status'
        ])
      except psutil.NoSuchProcess:
        pass
      else:
        # json.dump can't encode constants
        p.dict['status'] = str(p.dict['status'])
        
        if self.limited_by_user:
          if self.user == p.dict['username']:
            procs.append(p.dict)
        else:
          procs.append(p.dict)
    
    return procs
  
  def all_cpus(self):
    cpus = []
    for cpu_num, percent in enumerate(psutil.cpu_percent(interval=0, percpu=True)):
      cpus.append(dict(num=cpu_num, usage=percent))
    return cpus
  
  def all_memory(self):
    virtual = psutil.virtual_memory()._asdict()
    swap    = psutil.swap_memory()._asdict()
    return dict(virtual=virtual, swap=swap)
  
  def all_disks(self):
    disks = []
    for disk in psutil.disk_partitions():
      disks.append(disk._asdict())
    return disks
  
  def network_stats(self):
    stats = psutil.network_io_counters()
    return dict(bytes_sent=stats.bytes_sent, bytes_received=stats.bytes_recv)
