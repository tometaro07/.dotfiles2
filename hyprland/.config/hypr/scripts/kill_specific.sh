if [ ! -z "$(hyprctl activewindow|grep tags.*waybarapp)" ]
then
   hyprctl dispatch killactive
fi
