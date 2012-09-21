# psio

`psio` will be a tool accessible through a web browser that allows users to monitor various metrics regarding the performance of their machines. The basic functionality of `psio` is heavily inspired by the built-in OSX application [Activity Monitor](http://en.wikipedia.org/wiki/Activity_Monitor), but this tool will attempt to build this out even further by providing users with historical data that will be able to show how a machine has been performing on a more long-term basis. Through the use of a web-based UI, `psio` will be able to take advantage of powerful javascript graphing libraries to present this historical data in a pleasing and informative way.

## Technology

`psio` will be heavily utilizing a python library called [psutil](http://code.google.com/p/psutil/), which will allow for the actual metrics to be collected on systems in a way that works across multiple platforms.

This project will be a good opportunity to experiment with a new web technology known as [Websockets](http://en.wikipedia.org/wiki/WebSocket). Websockets allow for two way communication between client and server applications. Since this tool will require two major components to be in constant communication with each other (the process monitor and the web frontend), websockets could potentially be a great fit for making this work.

## UI Components

### Process Metrics

This component of the application will be the most familiar to users of Activity Monitor. The main view will list all of the processes currently being scheduled on a user's machine. It will show them in a sortable table format that displays the PID, name, user, CPU usage, and memory usage of each process.

Clicking on an individual process will bring up a more detailed view that presents aggregate metrics for the application that is being run.

For example, a user could click on the process for `Google Chrome` and then be able to see a graph that charts Chrome's memory or cpu usage over time. This is the kind of functionality that isn't possible with Activity Monitor right now and would be really useful to have.

### Memory Metrics

This UI component will provide user-friendly access to statistics about memory usage on a machine. It will be able to show how the system's RAM is being utilized and also the usage for any hard disks through the use of tables and graphs.

### Network Metrics

Another hope for this project is that it will be able to have a unified UI that will be able to show network metrics as well as process and memory metrics. Instead of having to manually run `ps` or `netstat` from the terminal, users will easily be able to see similar information that these programs provide from their web browser.

The data shown in this view list all of the sockets being used on a machine in a similar manner to `netstat`. It will also have a graph that charts the activity across network adapters on the system.
