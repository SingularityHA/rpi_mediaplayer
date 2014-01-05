<?
while (true) {
echo "Getting control\n";
$control = trim(file_get_contents("/media/ninjablock/control.txt"));
if ($control != "") {
	echo "Sending " . $control . "\n";
	shell_exec('screen -S player -p 0 -X stuff "' . $control . '"');
	file_put_contents("/media/ninjablock/control.txt", "");
}
else echo "No control characters\n";
echo "Getting Playlists\n";
$playlists = trim(file_get_contents("/media/ninjablock/playlist.txt"));
if ($playlists != "") {
	echo "Playing " . $playlists . "\n";
	shell_exec('screen -dmS player /home/pi/Desktop/playlists/play.sh ' . $playlists);
	file_put_contents("/media/ninjablock/playlist.txt", "");
}
else echo "No playlists\n";
if (file_exists("/media/ninjablock/die")) {
	echo "Killing omxplayer";
	shell_exec("killall -9 omxplayer.bin");
}
sleep(1);
}
