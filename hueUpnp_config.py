import os

# Some Global Variables
standard = {
    #Start with a '-d' to force debug mode
    'DEBUG': bool(os.environ.get("DEBUG", False)),
    #Standard Broadcast IP UPNP
    'BCAST_IP': "239.255.255.250",
    #Standard UPNP Port
    'UPNP_PORT': 1900,
    # Seconds between upnp broadcast
    'BROADCAST_INTERVAL': 200,
    # Callback http webserver IP (this machine)
    'IP': os.environ.get("IP", "192.168.1.200"),
    # HTTP-port to serve icons, xml, json (80 is most compatible but requires root)
    'HTTP_PORT': 8080,
    # shouldn't matter but feel free to adjust
    'GATEWAYIP': "192.168.1.1",
    # shouldn't matter but feel free to adjust
    'MACADDRESS': "aa:bb:cc:dd:ee:ff",
    # Set default ON state for all device to "true" or "false" when first starting
    'DEFAULT_ON_STATE': "false",
    # Set default BRIGHTNESS state for all device to a value 0-254 when first starting
    'DEFAULT_BRI_STATE': 0,
}

# Define all the devices to be controlled
# E.g. ('Hue Light 1', ('script_handler', './hue-upnp-helper.sh')),
#  Where
#  'Hue Light 1' is the name of the device you want
#  'script_handler' is the handler (only script_handler and isy_rest_handler)
#  './hue-upnp-helper.sh' is the script to run.
#
# For differences between some commands: on, bri, ct, xy see:
#  http://www.developers.meethue.com/documentation/core-concepts
#
# Addition notes on handlers:
#  isy_rest_handler: This will send commands to the ISY home automation control
#    You need to specify the address as the second parameter
#
#  script_handler: This is a basic script to kick off.  The second parameter is
#    the script to execute.  Three parameters will then be passed to it.
#    1) The name of the device
#    2) The directive: on, bri, ct, xy
#    3) The value: Examples: true/false, 0-254, [0.675,0.322]


#devices = {
#    #'Floor Lamp': ('isy_rest_handler', '2E 59 94 1'),
#    'PC WOL': ('script_handler', './hue-upnp-helper.sh'),
#    'Wemo Outlet': ('script_handler', './hue-upnp-helper.sh'),
#    'Wemo Light': ('script_handler', './hue-upnp-helper.sh'),
#}

from collections import OrderedDict
devices = OrderedDict([
    #('Floor Lamp', ('isy_rest_handler', '2E 59 94 1')),
    ('PC WOL', ('script_handler', './hue-upnp-helper.sh')),
    ('Wemo Outlet', ('script_handler', './hue-upnp-helper.sh')),
    ('Wemo Light', ('script_handler', './hue-upnp-helper.sh')),
])


# If using the ISY calls, set your info here:
isy = {
    'ip': '192.168.1.xxx',
    'username': 'your_user_name',
    'password': 'your_password',
}
