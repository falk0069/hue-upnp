#!/bin/sh
#
# Domoticz Control Script
#
# By Pierre Caron
#
# Change following values to match your setup
IP='192.168.1.30'	# This is the IP address of your Domoticz server
PORT=8080		# Default port for Domoticz is 8080. If you changed port number in Domoticz parameters, you must change this value accordingly.
MAXVALUE=100		# You can change this value to use Max command to set the light to the level you want.
#
# Usage: This script must be called by the script hue-upnp-helper.sh with 3 valid parameters as follow : ./domoticz_control.sh TYPE IDX COMMAND
# TYPE : specifies the type of device. Possible values : SWITCH (for devices such as lights or blinds) or SCENE (for scenes or groups)
# IDX : specifies the Idx of the device, scene or group.
# COMMAND : specifies the command which will be sent. Possible values : On / Off/ Toggle / Stop (for blinds only) / Max (To set lights brightness to 100%). Commands are case sensitive !!! Also, please note scenes will accept On command only.
# Note : You can call this script several times for the same keypress in script hue-upnp-helper.sh in order to send several commands to several devices/scenes.
# 
# It is possible to do much more with Domoticz JSON URL. Feel free to adapt this script to your needs.
# For more info about what you can do with Domoticz's JSON URL, visit this page : https://www.domoticz.com/wiki/Domoticz_API/JSON_URL%27s
#
# Values from script call parameters.
TYPE=$1
IDX=$2
COMMAND=$3

if [ "$COMMAND" = "" ]
then
	echo "Error 1: Some parameters are missing!"
	echo "Usage: ./domoticz_control.sh DEVICE_TYPE DEVICE_IDX On|Off|Toggle|Stop|Max"
else
	if [ "$IDX" = "" ]
	then
		echo "Error 1: Some parameters are missing!"
		echo "Usage: ./domoticz_control.sh DEVICE_TYPE DEVICE_IDX On|Off|Toggle|Stop|Max"
	else
		if [ "$TYPE" = "" ]
		then
			echo "Error 2: Some parameters are missing!"
			echo "Usage: ./domoticz_control.sh DEVICE_TYPE DEVICE_IDX On|Off|Toggle|Stop|Max"
		else
			echo "IP address : $IP"
			echo "Port : $PORT"
			echo "Device type : $TYPE"
			echo "Device Idx : $IDX"
			echo "Command : $COMMAND"
			if [ "$TYPE" = "SWITCH" ]
			then
				if [ "$COMMAND" = "On" ] || [ "$COMMAND" = "Off" ] || [ "$COMMAND" = "Toggle" ] || [ "$COMMAND" = "Stop" ]
				then
					echo "Sending command to Domoticz"
					curl 'http://'$IP':'$PORT'/json.htm?type=command&param=switchlight&idx='$IDX'&switchcmd='$COMMAND
				elif [ "$COMMAND" = "Max" ]
				then
					echo "Sending command to Domoticz"
					curl 'http://'$IP':'$PORT'/json.htm?type=command&param=switchlight&idx='$IDX'&switchcmd=Set%20Level&level='$MAXVALUE
				else
					echo "Error 3: Command not recognized!"
					echo "Only [On|Off|Toggle|Stop|Max] commands are accepted and are case sensitive"
				fi
			elif [ "$TYPE" = "SCENE" ]
			then
				if [ "$COMMAND" = "On" ] || [ "$COMMAND" = "Off" ] || [ "$COMMAND" = "Toggle" ]
				then
					echo "Sending command to Domoticz"
					curl 'http://'$IP':'$PORT'/json.htm?type=command&param=switchscene&idx='$IDX'&switchcmd='$COMMAND
				else
					echo "Error 3: Command not recognized!"
					echo "Only [On|Off|Toggle] commands are accepted and are case sensitive"
				fi
			else
				echo "Error 4: Device type not recognized!"
				echo "Only SWITCH or SCENE are accepted and are case sensitive"
			fi
		fi
	fi
fi