# psio

a web based process monitor

[screenshots](http://imgur.com/a/Tadmm)

## Install

You need python and ruby (with bundler) installed on your system first.

    git clone https://github.com/mportiz08/psio
    cd psio
    rake build

You should be good to go now.

## Usage

### Local

Run the `psio` script, which will start `psiod` on the current machine and set up a server for the frontend at `http://localhost:3000'.

    ./bin/psio

### Remote

The `psiod` command should be run on the machine you want to monitor.

Then, you need to configure the IP address of the remote machine for the frontend server on your local machine:

    cd psio/frontend
    cp config.yml.example config.yml

Edit the following line in `config.yml` to point to the remote machine:

    host: 10.0.1.6

The frontend server can be run separately with:

    rake server
