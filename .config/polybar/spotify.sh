#!/bin/bash
if [ "$(playerctl status >>/dev/null 2>&1; echo $?)" == "1" ]
then
    echo ""
    exit 0
fi
if [ "$(playerctl status)" = "Playing" ]; then
  title=`exec playerctl metadata xesam:title`
  artist=`exec playerctl metadata xesam:artist`
  echo "$title - $artist"
elif [ "$(playerctl status)" = "Paused" ]; then
  echo ""
else
  echo ""
fi
