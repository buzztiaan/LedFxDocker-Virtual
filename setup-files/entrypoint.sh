#!/bin/bash

# Start avahi-daemon for network discovery
avahi-daemon --daemonize --no-drop-root

# https://superuser.com/questions/1539634/pulseaudio-daemon-wont-start-inside-docker
# Start the pulseaudio server
rm -rf /var/run/pulse /var/lib/pulse /home/ledfx/.config/pulse
pulseaudio -D --verbose --exit-idle-time=-1 --system --disallow-exit
pactl load-module module-null-sink sink_name=DummyOutput sink_properties=device.description="Virtual_Dummy_Output"

exec ledfx "$@"