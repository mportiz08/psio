# psiod

`psiod` is a background process written in Python that uses websockets to receive commands and send information about the system it's running on.

It's automatically started with the `psio` command and can be run separately from the frontend by running `psiod`.

## API

To use psiod from a websocket client, connect to the websocket server at `ws://localhost:3000`.

For example, in javascript:

    var ws = new WebSocket('ws://localhost:3000');

This can be used to send commands to psiod and get information back from it.

    ws.onopen = function() {
      ws.send({type: 'command', {data: {name: 'process.getall'}}});
    };
    
    ws.onmessage = function(event) {
      var resp = JSON.parse(event.data);
      console.log(resp.data);
    };

Here's the types of commands that can be used right now:

### Listing all system processes

**request**

    {
      type: "command",
      data: {
        name: "process.getall"
      }
    }

**response**

    {
      type: "response"
      data: [
        {
          cpu_percent: 0.1,
          cpu_times: [
            86.295912448,
            82.35216896
          ],
          memory_info: [
            72105984,
            4062593024
          ],
          memory_percent: 0.4197120666503906,
          name: "Finder",
          nice: 0,
          status: "running",
          username: "marcus"
        },
        ...etc
      ]
    }
