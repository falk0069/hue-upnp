#!/bin/bash

#examples:
#./hue-upnp-helper.sh "Wemo Light" on true
#./hue-upnp-helper.sh "hue light 2" xy [0.4544,0.511]
#./hue-upnp-helper.sh "My toaster" ct 396
#./hue-upnp-helper.sh "PC WOL" bri 254

echo "$0 called with '$1' '$2' '$3'"

DEVICE1="Eclairage salon"
DEVICE2="Eclairage salle"
DEVICE3="Volet salon"
DEVICE4="Volet salle"

#HUE LIGHT 1 (DEVICE1)
if [ "$1" == "$DEVICE1" ]; then

  echo "Running directive for $DEVICE1"

  #ON/OFF Directive
  if [ "$2" == "on" ]; then
    if [ "$3" == "true" ]; then
      echo 1 on true
      #INSERTING DOMOTICZ SWITCH ON SCENE COMMAND
      ./domoticz_control.sh SCENE 5 On
    elif [ "$3" == "false" ]; then
      echo 1 on false
      #INSERTING DOMOTICZ SWITCH OFF SCENE COMMAND
      ./domoticz_control.sh SCENE 7 On
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
      echo 1 on true
      #INSERTING DOMOTICZ SWITCH ON SCENE COMMAND
      ./domoticz_control.sh SCENE 6 On
    elif [ "$3" == "false" ]; then
      echo 1 on false
      #INSERTING DOMOTICZ SWITCH OFF SCENE COMMAND
      ./domoticz_control.sh SCENE 7 On
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

#HUE LIGHT 3 (DEVICE3)
elif [ "$1" == "$DEVICE3" ]; then

  echo "Running directive for $DEVICE3"

  #ON/OFF Directive
  if [ "$2" == "on" ]; then
    if [ "$3" == "true" ]; then
      echo 1 on true
      #INSERTING DOMOTICZ TOGGLE COMMAND
      ./domoticz_control.sh SWITCH 10 Toggle
    elif [ "$3" == "false" ]; then
      echo 1 on false
      #INSERTING DOMOTICZ STOP COMMAND
      ./domoticz_control.sh SWITCH 10 Stop
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

#HUE LIGHT 4 (DEVICE4)
elif [ "$1" == "$DEVICE4" ]; then

  echo "Running directive for $DEVICE4"

  #ON/OFF Directive
  if [ "$2" == "on" ]; then
    if [ "$3" == "true" ]; then
      echo 1 on true
      #INSERTING DOMOTICZ TOGGLE COMMAND
      ./domoticz_control.sh SWITCH 9 Toggle
    elif [ "$3" == "false" ]; then
      echo 1 on false
      #INSERTING DOMOTICZ STOP COMMAND
      ./domoticz_control.sh SWITCH 9 Stop
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

else
  echo "Error: Unknown Device '$1' command=$2 $3"
  exit 1
fi
