# Description
This is a simple customizable Philips hue emulator that works with a Harmony remote (and now the Amazon Echo -thanks to jimboca). The main purpose is to allow the Harmony/Echo to run *anything* and not just hue light bulbs.

# Why
I don't own a Philips hue but I wanted an emulator so I could test it against my Harmony remote which supports them.  I found a number of emulators but none of them worked with the Harmony remote.  Sagen's python code was easiest to modify and do what I needed.  I've never coded in python before so this was a good experience.

# How to use it for wake-on-lan
* Adjust IP-Address in `hueUpnp_config.py`
* Adjust MAC-Address in `hue-upnp-helper.sh`
* Run it with `python hueUpnp.py`


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

***
Feb 2024:
Added a python3 version (hueUpnp3.py).  Ran the 2to3 conversion tool and had to add .decode() or .encode() anytime the socket was read from or written to.  Everything seems to continue to be working as expected for me.  I left the orginal version python2 in case something is broken or in case someone still needs it.  I highly doubt, though, anyone really needs a python2 version anymore.


