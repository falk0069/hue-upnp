# Description
This is a simple customizable Philips hue emulator that works with a Harmony remote (and now the Amazon Echo -thanks to jimboca). The main purpose is to allow the Harmony/Echo to run *anything* and not just hue light bulbs.

# Why
I don't own a Philips hue but I wanted an emulator so I could test it against my Harmony remote which supports them.  I found a number of emulators but none of them worked with the Harmony remote.  Sagen's python code was easiest to modify and do what I needed.  I've never coded in python before so this was a good experience.

# How to use it for wake-on-lan
* Adjust IP-Address in `hueUpnp_config.py` or set environment variable `$IP`
* Adjust MAC-Address in `hue-upnp-helper.sh` or set environment variable `$WOLMAC`
* Run it with `python hueUpnp.py`

# How to use it with docker
`docker run -d --network="host" -v /root/.ssh:/root/.ssh:ro -v /etc/localtime:/etc/localtime:ro -e "IP=192.168.1.123" -e "WOLMAC=00:11:22:33:44:55" -e "WOLUSER=root" -e "WOLHOST=wokenhostname-or-ip" starze/hue-upnp`

## docker-compose file example
```
version: '2'

services:
  hue-upnp:
    image: starze/hue-upnp
    restart: unless-stopped
    container_name: hue-upnp
    network_mode: host
    volumes:
      - /etc/localtime:/etc/localtime:ro
      - /root/.ssh:/root/.ssh:ro
    environment:
      - DEBUG=False
      - IP=192.168.1.123
      - WOLMAC=00:11:22:33:44:55
      - WOLUSER=root
      - WOLHOST=wokenhostname-or-ip
```

## A few words on shutdown
To shutdown the device that has been woken up by wakeonlan we use the following ssh command: `ssh ${WOLUSER}@${WOLHOST} shutdown -h now`. To be able to send this ssh command without a password request we suggest using Key-Authentication (see <https://help.ubuntu.com/community/SSH/OpenSSH/Keys>). After you configured ssh on your host you can mount the config files as volume with `-v /root/.ssh:/root/.ssh:ro`. Now hue-upnp can establish a ssh connection to your woken device and shut it down when you turn off the `PC WOL` light.

## Environment variables

### DEBUG
Set `True` or `False` to control the amount of log messages (Default when omitted: `False`)

**Excample:**

`DEBUG=True`

### IP
Set it to the IP where hueUpnp.py is running (it has to be reachable by your Harmony device so don't use your internal docker IP but that of your docker host).

**Excample:**

`IP=192.168.1.201`

### WOLMAC 
Set the MAC address of the device you want to wake up

**Excample:**

`WOLMAC=00:11:22:33:44:55`

### WOLUSER
Set the ssh username.

**Excample:**

`WOLUSER=root`

### WOLHOST
Set the ssh IP or hostname

**Excamples:**

```
WOLHOST=192.168.1.200
WOLHOST=nameofmydevice
```

# Some pitfalls to mention:
1. The UDP response needs to be bound to port 1900 (like the request) and sent to the same port that the client used (for Harmony)

2. Harmony sends three ST requests at a time:
``` 
ST: ssdp:all 
ST: urn:schemas-upnp-org:device:basic:1
ST: urn:schemas-udap:service:smartText:1
```

3. The Harmony remote will only progress if you reply back with the same ST.  All other examples online use this ST instead:
``` 
ST: upnp:rootdevice 
```

4. I got hung up on the smartText one for a while.  It turns out this has something to do with LG TVs.  I have no idea why it is using it.

5. The HTTP PORT used can be anything and the Harmony remote will use it.  However, if you use the standard Phillip Hue Android (and iOS?), you need to use port 80.

6. I added in a EXTERNALPROG call, so anyone can toss in their own commands.  I use this so I can remotely call WakeOnLan using my remote.  I also use it to call a Wemo On-Off script.  For whatever reason Logitech doesn't support Wemos (yet).


# History
***
Aug 2015:
Logitech firmware broke things for me.  I noticed that FIN packets were getting sent during the "GET /api/lights" calls before it got the results.  I removed some of the 1 seconds sleeps that I don't think are needed and I also updated it so additional 'request.recv' aren't done unless a content-length > 0 is found.  Things appear to be back in business now.  

***
Nov 2015:
Now supports the Amazon Echo as well (Thanks Jimboca)

***
Dec 2015:
Pulled in jimboca code which includes a nice json parser.  Also, moved everything configurable to a config file: hueUpnp_config.py.  Another note is the hue-upnp-helper.sh now expects the device name instead of the device number as the first parameter.

