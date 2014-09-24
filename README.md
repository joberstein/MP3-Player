MP3-Player
==========

An MP3 player program that can play songs provided it is given an XML file of songs.  This particular one happens to play some of my favorite music from different anime.
<br>
<br>
Project Information
--------------------------------------------------------------------------------
  - Version 1.0 on March 28th, 2014
  - Created by Jesse Oberstein
  - Resources:
  	* All images taken from GoogleImages.
	* Audio files taken from www.gendou.com for personal use
	* Minim library included in Processing download. Link to Minim’s website: http://code.compartmental.net/tools/minim/
  - Individual Project


General Usage Notes
--------------------------------------------------------------------------------
To run this program, you must have at least Processing 2 installed. Download Processing the most recent version from: http://processing.org/


Instructions and Features
--------------------------------------------------------------------------------
Run the program in Processing, and the MP3 player will pop up.  From this point, the user can do any of the following to start off:
	* Sort the songs by a different order (the default order is by song title)
	* Click on the play button to play a song.
	* Click on the next button to play the next song.
	* Click on a song's button to play that song.
	* Click on page forward/page back to navigate pages.

Once one of those options have been completed, the user can continue to choose another option from the list, or perform one of the following newly available options if a song is currently playing:
	* Click on the pause button to pause the song currently playing.
	* Click on the back button to restart the current song.

At this point, the user can do any combination of the options listed in order to create a satisfying musical experience.

Users can sort songs according to song title, album, artist, or length, track how long a song is via the red ticker in each song’s extended information, or control songs with restart, skip, and pause. A user can also click on a song to show/hide extended information about a song, and can include any number of songs since there is a page feature, with a limit of 10 songs per page.

This project explored Minim, an audio library for Processing, as well as extracting information from a custom XML document, and working with dynamic navigation.


Known Bugs
--------------------------------------------------------------------------------
A small bug dealing with highlighting the current song occurs when the last song of a page ends. If the user is not on the same page as the song when it ends, the song of the new page does not highlight right away.  Clicking on the page the song is playing on will fix the issue. 


Contact Information
--------------------------------------------------------------------------------

E-mail: oberstein.j@husky.neu.edu<br>
Website: www.jesseoberstein.com
