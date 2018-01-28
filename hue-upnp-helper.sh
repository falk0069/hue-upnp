#!/bin/bash

#examples:
#./hue-upnp-helper.sh "Wemo Light" on true
#./hue-upnp-helper.sh "hue light 2" xy [0.4544,0.511]
#./hue-upnp-helper.sh "My toaster" ct 396
#./hue-upnp-helper.sh "PC WOL" bri 254

echo "$0 called with '$1' '$2' '$3'"

DEVICE1="PC WOL"
DEVICE2="Wemo Outlet"
DEVICE3="Wemo Light"


#HUE LIGHT 1 (DEVICE1)
if [ "$1" == "$DEVICE1" ]; then

  echo "Running directive for $DEVICE1"

  #ON/OFF Directive
  if [ "$2" == "on" ]; then
    if [ "$3" == "true" ]; then
      echo $DEVICE1 on true
      #INSERTING WAKEONLAN
      if [[ -n $WOLMAC ]]; then
        wakeonlan $WOLMAC
      else
        echo ERROR: Set \$WOLMAC to start your device via wakeonlan.
      fi
    elif [ "$3" == "false" ]; then
      echo $DEVICE1 on false
      if [[ -n $WOLUSER && -n $WOLHOST ]]; then
        ssh ${WOLUSER}@${WOLHOST} shutdown -h now & 
      else
        echo ERROR: Set \$WOLUSER and \$WOLHOST to shutdown your device via ssh.
      fi
    fi

  #BRIGHTNESS
  elif [ "$2" == "bri" ]; then
    echo 1 bri $3

  #CT
  elif [ "$2" == "ct" ]; then
    echo 1 ct $3

  #XY
  elif [ "$2" == "xy" ]; then
    echo 1 xy $3
  fi

#HUE LIGHT 2 (DEVICE2)
elif [ "$1" == "$DEVICE2" ]; then

  echo "Running directive for $DEVICE2"

  #ON/OFF Directive
  if [ "$2" == "on" ]; then
    if [ "$3" == "true" ]; then
      echo 2 on true
      #INSERTING WEMO-ON COMMAND
      ./wemo_control.sh 192.168.1.110 ON
    elif [ "$3" == "false" ]; then
      echo 2 on false
      #INSERTING WEMO-OFF COMMAND
      ./wemo_control.sh 192.168.1.110 OFF
    fi

  #BRIGHTNESS
  elif [ "$2" == "bri" ]; then
    echo 2 bri $3

  #CT
  elif [ "$2" == "ct" ]; then
    echo 2 ct $3

  #XY
  elif [ "$2" == "xy" ]; then
    echo 2 xy $3
  fi

#HUE LIGHT 3 (DEVICE3)
elif [ "$1" == "$DEVICE3" ]; then

  echo "Running directive for $DEVICE3"

  #ON/OFF Directive
  if [ "$2" == "on" ]; then
    if [ "$3" == "true" ]; then
      echo 3 on true
      ./wemo_control.sh 192.168.1.111 ON
    elif [ "$3" == "false" ]; then
      echo 3 on false
      ./wemo_control.sh 192.168.1.111 OFF
    fi

  #BRIGHTNESS
  elif [ "$2" == "bri" ]; then
    echo 3 bri $3

  #CT
  elif [ "$2" == "ct" ]; then
    echo 3 ct $3

  #XY
  elif [ "$2" == "xy" ]; then
    echo 3 xy $3
  fi
else
  echo "Error: Unknown Device '$1' command=$2 $3"
  exit 1
fi
