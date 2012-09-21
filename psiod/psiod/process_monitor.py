import psutil

class ProcessMonitor:  
  def all_processes(self):
    procs = []
    
    # TODO: use procs_status
    procs_status = {}
    
    for p in psutil.process_iter():
      try:
        p.dict = p.as_dict(['username', 'get_nice', 'get_memory_info',
          'get_memory_percent', 'get_cpu_percent',
          'get_cpu_times', 'name', 'status'])
        try:
          procs_status[str(p.dict['status'])] += 1
        except KeyError:
          procs_status[str(p.dict['status'])] = 1
      except psutil.NoSuchProcess:
        pass
      else:
        # json.dump can't encode constants
        p.dict['status'] = str(p.dict['status'])
        
        procs.append(p.dict)
    
    return procs