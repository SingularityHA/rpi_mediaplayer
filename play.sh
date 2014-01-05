#!/bin/sh
# Singularity
# Copyright (C) 2014 Internet by Design Ltd
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# make sure we don't have any processes left over
killall -9 omxplayer
killall -9 omxplayer.bin

# get rid of the cursor so we don't see it when videos are running
setterm -cursor off

# set here the path to the directory containing your videos
VIDEOPATH="/media/media/$1"

# you can normally leave this alone
SERVICE="omxplayer"

# fire up xterm to keep the screen black
DISPLAY=:0 xterm -fullscreen -fg black -bg black -e "echo ==== MEDIA ====; while [ 1 ]; do sleep 6000000; done;" &

# now for our infinite loop!
while true; do
	# is omxplayer still running?
        if ps ax | grep -v grep | grep $SERVICE > /dev/null
        then
        	sleep 5;
	else
		# find all files in the video path
		find $VIDEOPATH -type f | shuf > playlist.txt
		/home/pi/Desktop/playlists/list.sh $1
		if [ -e "/media/ninjablock/die" ]
		then
			break;
		fi
	fi
	if [ -e "/media/ninjablock/die" ]
		then
		break;
	fi
done
rm /media/ninjablock/die
