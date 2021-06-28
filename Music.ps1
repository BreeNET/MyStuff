while($true){


	[xml]$doc = (New-Object System.Net.WebClient).DownloadString("http://ws.audioscrobbler.com/2.0/?method=user.getrecenttracks&user=lidsy0&api_key=[REDACTED]&nowplaying=true&limit=1") | out-file \srv\WebServer\lidsy\music.xml -Encoding unknown
	[xml]$xml = Get-Content '\srv\WebServer\lidsy\music.xml'

	$SongName = $xml.SelectNodes('//lfm/recenttracks/track/name') | select `#text
	$FirstSongName = $SongName[0].'#text'

	$ArtistName = $xml.selectNodes('//lfm/recenttracks/track/artist') | select `#text
	$FirstArtistName = $ArtistName[0].'#text'

	$LastSongName = $xml.SelectNodes('//lfm/recenttracks/track/name') | select `#text
	$LastSongName = $SongName[1].'#text'

	$LastArtistName = $xml.selectNodes('//lfm/recenttracks/track/artist') | select `#text
	$LastArtistName = $ArtistName[1].'#text'

	$endResultFirst = "$FirstSongName by $FirstArtistName" | Out-File \srv\WebServer\lidsy\CurrentSong.txt -Encoding utf8
	$endResultLast = "$LastSongName by $LastArtistName" | Out-File \srv\WebServer\lidsy\PreviousSong.txt -Encoding utf8
}