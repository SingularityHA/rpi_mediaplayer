#!/usr/bin/env bash
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

# If you want to switch omxplayer to something else, or add parameters, use these
PLAYER="omxplayer"

#Skip intro
PLAYER_OPTIONS="-l 30"

# Where is the playlist
PLAYLIST_FILE="playlist.txt"

# Process playlist contents
while [ true ]; do
        # Sleep a bit so it's possible to kill this
        sleep 1

        # Do nothing if the playlist doesn't exist
        if [ ! -f "${PLAYLIST_FILE}" ]; then
                echo "Playlist file ${PLAYLIST_FILE} not found"
                continue
        fi

        # Get the top of the playlist
        file=$(cat "${PLAYLIST_FILE}" | head -n1)

        # And strip it off the playlist file
        cat "${PLAYLIST_FILE}" | tail -n+2 > "${PLAYLIST_FILE}.new"
        mv "${PLAYLIST_FILE}.new" "${PLAYLIST_FILE}"

        # Skip if this is empty
        if [ -z "${file}" ]; then
                echo "Playlist empty or bumped into an empty entry for some reason"
                continue
        fi

        # Check that the file exists
        if [ ! -f "${file}" ]; then
                echo "Playlist entry ${file} not found"
                continue
        fi

        echo
        echo "Playing ${file} ..."
        echo

        "${PLAYER}" ${PLAYER_OPTIONS} "${file}"

	 if [ -e "/media/ninjablock/die" ]
                then
                break;
	fi
        echo
        echo "Playback complete, continuing to next item on playlist."
        echo
done
