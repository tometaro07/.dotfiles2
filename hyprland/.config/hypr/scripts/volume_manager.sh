#!/bin/bash

# Get Volume
get_volume() {
	volume="$(pactl get-sink-volume @DEFAULT_SINK@ | grep '^Volume:' | cut -d / -f 2 | tr -d ' ' | sed 's/%//')" 
	echo "$volume"
}

# Get icons
get_icon() {
	current=$(get_volume)
	if [[ "$current" -eq "0" ]]; then
		echo ""
	elif [[ ("$current" -ge "0") && ("$current" -le "30") ]]; then
		echo ""
	elif [[ ("$current" -ge "30") && ("$current" -le "60") ]]; then
		echo ""
	elif [[ ("$current" -ge "60")]]; then
		echo ""
	fi
}

# Notify
notify_user() {
	notify-send -e -h int:value:"$(get_volume)" -h string:x-canonical-private-synchronous:volume_notif -u low "$(get_icon) Volume : $(get_volume) %"
}

# Increase Volume
inc_volume() {
	wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+ & wpctl set-mute @DEFAULT_AUDIO_SINK@ 0 # && notify_user
}

# Decrease Volume
dec_volume() {
	 wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%- & wpctl set-mute @DEFAULT_AUDIO_SINK@ 0 # && notify_user
}

# Toggle Mute
toggle_mute() {
	mute="$(pactl get-sink-mute @DEFAULT_SINK@ | grep '^Mute:' | cut -d / -f 2 | tr -d ' ' | sed -e 's/Mute://')"
	if [ "$mute" == "no" ]; then
		wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle # && notify-send -h string:x-canonical-private-synchronous:volume_notif -u low " Volume Switched OFF"
	elif [ "$mute" == "yes" ]; then
		wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle # && notify-send -h string:x-canonical-private-synchronous:volume_notif -u low "$(get_icon) Volume Switched ON"
	fi
}

# Toggle Mic
toggle_mic() {
	if [ "$(pamixer --default-source --get-mute)" == "false" ]; then
		pamixer --default-source -m # && notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -i "" "Microphone Switched OFF"
	elif [ "$(pamixer --default-source --get-mute)" == "true" ]; then
		pamixer -u --default-source u # && notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -i "" "Microphone Switched ON"
	fi
}
# Get icons
get_mic_icon() {
	current=$(pamixer --default-source --get-volume)
	if [[ "$current" -eq "0" ]]; then
		echo ""
	elif [[ ("$current" -ge "0")]]; then
		echo ""
	fi
}
# Notify
notify_mic_user() {
	notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -i "$(get_mic_icon)" "Mic-Level : $(pamixer --default-source --get-volume) %"
}

# Increase MIC Volume
inc_mic_volume() {
	pamixer --default-source -i 5 # && notify_mic_user
}

# Decrease MIC Volume
dec_mic_volume() {
	pamixer --default-source -d 5 # && notify_mic_user
}

# Execute accordingly
if [[ "$1" == "--get" ]]; then
	get_volume
elif [[ "$1" == "--inc" ]]; then
	inc_volume
elif [[ "$1" == "--dec" ]]; then
	dec_volume
elif [[ "$1" == "--toggle" ]]; then
	toggle_mute
elif [[ "$1" == "--toggle-mic" ]]; then
	toggle_mic
elif [[ "$1" == "--get-icon" ]]; then
	get_icon
elif [[ "$1" == "--get-mic-icon" ]]; then
	get_mic_icon
elif [[ "$1" == "--mic-inc" ]]; then
	inc_mic_volume
elif [[ "$1" == "--mic-dec" ]]; then
	dec_mic_volume
else
	get_volume
fi
