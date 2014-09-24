/* 
Jesse Oberstein
MP3 Player
Updated: April 24th, 2014
*/

import java.util.Arrays;
import ddf.minim.*;

// The root XML, called "Library.xml", which contains all the information
// for the MP3 player.
XML library;
// An array of XML songs.
XML[] songsXML;
// An instance of the Minim library (for audio playback and manipulation).
Minim minim;
// An array of audio players.
AudioPlayer[] players;
// The coolest background image ever.
PImage background;
// An array of song objects.
Song[] songs;
// A comparator that sorts songs alphabetically by title.
SongTitleComparator titlecomp;
// A comparator that sorts songs from least to greatest by song duration.
SongLengthComparator lengthcomp;
// A comparator that sorts songs alphabetically by artist.
SongArtistComparator artistcomp;
// A comparator that sorts songs alphabetically by album.
SongAlbumComparator albumcomp;
// The index of the currently playing song.
int currentSong = 0;
// The number of songs clicked.
int songsClicked = 0;
// The index of the current page the user is on.
int currentPage = 0;
// The total number of pages the library contains. There is no more than 
// 10 songs on any page.
int pages;
// The highest possible index for a song on the current page.
int upperPageBound; 
// The lowest possible index for a song on the current page.
int lowerPageBound;
// The number of songs on all the previous pages combined.
int numSongs;
// The current time (in milliseconds) that the currently playing song is at.
float currentSongTime = 0;
// An array of buttons where each button corresponds to a particular song.
Button[] tracks;
// A button that pauses the currently playing song.
Button pause;
// A button that plays the next song according to the library's sorted order.
Button next;
// A button that restarts the currently playing song.
Button back;
// A button that plays the currently playing song.
Button play;
// A button that increments the current page index by one.
Button pageNext;
// A button that decrements the current page index by one.
Button pageBack;
// A button that sorts the song library by song title.  The default sorted order.
Button byTitle;
// A button that sorts the song library by song duration.
Button byLength;
// A button that sorts the song library by song artist.
Button byArtist;
// A button that sorts the song library by song album.
Button byAlbum;
// The Avenir-Bold-Next font, size 20.
PFont avenirb;


// Sets up the MP3 player!
void setup() {
  frameRate(30);
  size(600, 800);
  minim = new Minim(this);
  background = loadImage("bluestripes.jpg");
  library = loadXML("Library.xml");
  songsXML = library.getChildren("song");
  titlecomp = new SongTitleComparator();
  artistcomp = new SongArtistComparator();
  albumcomp = new SongAlbumComparator();
  lengthcomp = new SongLengthComparator();
  createSongs();
  sortSongs(titlecomp);
  createTrackButtons();
  avenirb = loadFont("AvenirNext-Bold-20.vlw");
  back = new Button("rewindButton.png", 290, 55, 50, 50);
  next = new Button("nextButton.png", 490, 55, 50, 50);
  byTitle = new Button("Title", 35, 55, 80, 20);
  byLength = new Button("Length", 35, 80, 80, 20);
  byArtist = new Button("Artist", 125, 55, 80, 20);
  byAlbum = new Button("Album", 125, 80, 80, 20);
  pageBack = new Button("rewindButton.png", 200, 730, 50, 50);
  pageNext = new Button("nextButton.png", 350, 730, 50, 50);
}


// Creates an array of songs from the XML song library.
// Sets the number of pages based on the number of songs.
void createSongs() {
  songs = new Song[songsXML.length];
  for (int i = 0; i < songsXML.length; i++) {
    songs[i] = new Song(songsXML[i]);
  }
  numSongs = songs.length;
  pages = (int) Math.ceil(songs.length * 10.0 / 100);
}


// Sorts an array of songs with the given comparator.
void sortSongs(Comparator comp) {
  Arrays.sort(songs, comp);
  players = new AudioPlayer[songs.length];
  for (int i = 0; i < songs.length; i++) {
    songs[i].setSongId(i + 1);
    players[i] = minim.loadFile(songs[i].getFileName());
    int stuff = (Math.round(players[i].length() * 1.0 / 1000)); //seconds value
    songs[i].setDuration(stuff);
  }
}


// Returns the number of songs on the current page.
// There is a maximum of 10 songs per page.
int songsPerPage() {  
  if (numSongs <= 10) {
    return numSongs;
  }
  else {
    numSongs = songs.length - (10 * currentPage);
    return 10;
  }
}


// Creates the button for each song.
void createTrackButtons() {
  tracks = new Button[songs.length];
  for (int i = 0; i < songs.length; i++) {
    tracks[i] = new Button(songs[i].songDisplay(), 30, (((i - currentPage * 10) + 1) * 50) + 80, 600, 40);
  }
}


// Moves all the songs after the given song index down to account
// for displaying song information about the song at the given index.
void moveRemainingSongs(int index) {
  for (int j = index + 1; j < songs.length; j++) {
    tracks[j] = new Button(songs[j].songDisplay(), 30, (((j - currentPage * 10) + 1) * 50) + 160, 600, 40);
  }
}


// Displays the button for each song on the current page.
void displayTrackButtons() {
  for (int i = 0; i < songsPerPage(); i++) {
    int index = i + currentPage * 10;
    tracks[index].displayTrackButton();
    tracks[index].displaySongInfo(songs[index]);
  }
}


// Returns the song index of the song previously played.
int prevSongIndex() {
  int curr = currentSong;
  for (int i = 0; i < songs.length; i++) {
    if (players[i].isPlaying()) {
      curr = i;
      return curr;
    }
  }
  return curr;
}


// Toggles a display of the play/pause button.
void showPlayPause() {
  if (players[currentSong].isPlaying()) {
    pause = new Button("pauseButton.png", 390, 55, 50, 50);
    play = new Button("playButton.png", 650, 55, 50, 50); //displays off-screen
  }
  else {
    play = new Button("playButton.png", 390, 55, 50, 50); 
    pause = new Button("pauseButton.png", 650, 55, 50, 50); //displays off-screen
  }
  pause.displayFunctionButton();
  play.displayFunctionButton();
}


// Highlights the currently playing song with a dark blue color.
void highlightCurrentSong() {
  if (songsClicked != 0 && isOnPage(currentSong)) {
    moveToPage();
    tint(100, 80, 70);
    image(background, 30.0, (((currentSong - (currentPage * 10)) + 1) * 50.0) + 80.0, 600.0, 40.0);
  }
}


// If the currently playing song has just finished, the next song is played.
void songIsOver() {
  if (currentSongTime >= 300.0) {
    clickNext();
    highlightCurrentSong();
  }
}


// Displays a translucent interface at the top of each page, 
// as well as the "Sort By:" and "Controls" headers.
void displayButtonMenu() {
  fill(220, 150);
  stroke(250, 250, 150);
  rect(10, 10, 620, 105, 20); 

  // Formatting for the Menu
  line(235, 10, 235, 115);
  line(240, 10, 240, 115);
  line(245, 10, 245, 115);
  line(250, 10, 250, 115);
  line(255, 10, 255, 115);
  fill(255);
  stroke(0);
  rect(75, 20, 85, 25, 10);
  rect(340, 20, 150, 25, 10);
  fill(0);
  textFont(avenirb, 18);
  text("Sort By:", 85, 25, 100, 20);
  text("Song Controls:", 350, 25, 150, 20);
}


// Highlights the ByTitle button since it is the default sorting method.
// The default sorting method is by title.
void showDefaultSorting() {
  if (byTitle.getButtonId() == 0 && byArtist.getButtonId() == 0
    && byAlbum.getButtonId() == 0 && byLength.getButtonId() == 0) {
    byTitle.setButtonId(1);
  }
}


// Updates the screen each tick to ensure that the current song is
// playing and shown correctly.
// The current song playing is highlighted.
// The current sorting method is highlighted.
// All buttons are displayed.
void draw() {
  image(background, 0, 0, 600, 800);
  displayButtonMenu();
  showDefaultSorting();
  highlightCurrentSong();
  calculateCurrentTime();
  songIsOver();
  displayTrackButtons();
  showPlayPause();
  back.displayFunctionButton();
  next.displayFunctionButton();
  pageNext.displayFunctionButton();
  pageBack.displayFunctionButton();
  byTitle.displaySortingButton();
  byLength.displaySortingButton();
  byArtist.displaySortingButton();
  byAlbum.displaySortingButton();
  fill(255);
  textFont(avenirb, 20);
  text("Page " + (currentPage + 1), 268, 760);
}


// Changes the currentSong value to a new value after
// the song library has been resorted according to a new order.
void changeCurrentSong(Song s) {
  for (int i = 0; i < songs.length; i++) {
    if (songs[i].equals(s)) {
      currentSong = i;
    }
  }
}


// Is the given index contained on the current page?
boolean isOnPage(int index) {
  return index >= lowerPageBound && index < upperPageBound;
}


// Sets the current page to a different one.
void moveToPage() {
  int newPage = (int) Math.floor(currentSong * 10.0 / 100);
  currentPage = newPage;
  int missingSongs = 0;
  if (currentSong < lowerPageBound) {
    numSongs+= (10 * (currentPage + 1));
    createTrackButtons();
  }
  else if (currentSong >= upperPageBound) {
    createTrackButtons();
  }
}


// Computes the duration of the song currently playing (in seconds).
int convertSongLength() {
  return Math.round((players[currentSong].length() * 1.0) / 1000);
}


// Calculates the current time of the current song.
void calculateCurrentTime() { 
  if (players[currentSong].isPlaying() && currentSongTime <= 301) {
    currentSongTime+= (10.2 / (convertSongLength()));
  }
}


// Converts a song's length in milliseconds to a string in the form of
// minutes and seconds.
String songDurationFormatted() {
  int totalSeconds = convertSongLength();
  int minutes = (int) Math.floor((totalSeconds * 1.0) / 60);
  int seconds = totalSeconds % 60;
  String newSeconds = "" + seconds;
  if (seconds < 10) {
    newSeconds+= 0 + seconds;
  }
  return minutes + ":" + newSeconds;
}


// Sets all the ids of the sorting buttons to 0.  The default sorting (byTitle)
// is applied as long as these values remain zero.
void resetSortButtonIds() {
  byTitle.setButtonId(0);
  byLength.setButtonId(0);
  byArtist.setButtonId(0);
  byAlbum.setButtonId(0);
}


// Sorts the song library according to the given comparator.  
// If a song is playing while the songs are resorted, the song will continue to play,
// and the player will move the user to the new page that contains the currently playing song.
void resortSongs(Comparator comp) {
  // The current song playing/paused when before resorting the songs.
  Song current = songs[currentSong];
  // The position the song was at when the songs were resorted.
  int songPosition = players[currentSong].position();

  // Reset the current song.
  players[currentSong].pause();
  players[currentSong].rewind();

  // Re-show all the songs and keep the current song playing.
  resetSortButtonIds();
  sortSongs(comp);
  createTrackButtons();
  changeCurrentSong(current);
  players[currentSong].cue(songPosition);
  if (songsClicked != 0) {
    moveToPage();
    players[currentSong].play();
  }
}


// Resorts the song library based on the sorting button clicked.
// Options to sort by: Title, Length, Artist, Album
void clickSort() {
  if (byTitle.hover()) {
    resortSongs(titlecomp);
    byTitle.setButtonId(1);
  }
  if (byLength.hover()) {
    resortSongs(lengthcomp);
    byLength.setButtonId(1);
  }
  if (byArtist.hover()) {
    resortSongs(artistcomp);
    byArtist.setButtonId(1);
  }
  if (byAlbum.hover()) {
    resortSongs(albumcomp);
    byAlbum.setButtonId(1);
  }
}


// Increments or decrements the current page by one, depending
// on the button pressed.
// Options: Next Page, Previous Page
void clickPageNav() {
  if (pageNext.hover() && currentPage < pages - 1) {
    currentPage++;
    createTrackButtons();
  }
  if (pageBack.hover() && currentPage > 0) {
    numSongs+=10;
    currentPage--;
    createTrackButtons();
  }
}


// Plays the given song as the next song in the song library.
void playNextSong(int nextSong) {
  if (nextSong >= songs.length) {
    nextSong = 0;
    currentPage = 0;
    numSongs = songs.length;
  }
  else if (nextSong == (currentPage + 1) * 10) {
    currentPage++;
  }
  currentSong = nextSong;
  // Updates the previous song by resetting it.
  players[prevSongIndex()].pause();
  players[prevSongIndex()].rewind();
  createTrackButtons();

  // Updates the next song and plays it.
  moveRemainingSongs(nextSong);
  tracks[nextSong].setButtonId(1);
  tracks[nextSong].displaySongInfo(songs[nextSong]);
  songsClicked++;
  players[nextSong].play();
  currentSongTime = 0;
}


// Plays the next song in the song library when the next
// button is pressed.
void clickNext() {
  if (songsClicked == 0) {
    playNextSong(currentSong);
  }
  else {
    currentSong++;
    playNextSong(currentSong);
  }
  moveToPage();
  tracks[currentSong].setButtonId(1);
  moveRemainingSongs(currentSong);
}


// Restarts the currently playing song when the back button
// is pressed.  Only works if at least one song has played already
// or is currently playing.
void clickBack() {
  if (songsClicked > 0) {
    players[currentSong].rewind();
    players[currentSong].play();
    currentSongTime = 0;
  }
}


// Play the current song when the pause button is pressed. 
// A song must be currently paused, or there must be no songs
// playing in order for this button to be available.
void clickPlay() {
  if (songsClicked == 0) {
    currentSong = 0;
    tracks[currentSong].setButtonId(1);
    moveRemainingSongs(currentSong);
    currentSongTime = 0;
  }
  songsClicked++;
  players[currentSong].play();
}


// Controls the songs through four buttons.  Clicking an available 
// button will alter the currently playing song in some way.
// Options: Next, Pause, Restart, Play
void clickSongControls() {
  if (next.hover()) {
    clickNext();
  }
  // Pauses the current song.  A song must already be playing.
  if (pause.hover()) {
    players[currentSong].pause();
  }
  if (back.hover()) {
    clickBack();
  }
  if (play.hover()) {
    clickPlay();
  }
}


// Plays the song at the given index, and resets the
// previous song that was being played.
void playNewSong(int index) {
  currentSong = index;
  players[prevSongIndex()].pause();
  players[prevSongIndex()].rewind();
  players[index].play();
  currentSongTime = 0;
}


// Upon mouse click, provided a button is clicked, the user can:
//  -- Change the sorting order of the song library
//  -- Navigate to different pages (provided there are more than 10 songs),
//  -- Use controls to alter the currently playing song
//  -- Select a new song to play
//  -- Show/hide detailed information about a song.
void mouseClicked() { 
  clickSort();
  clickPageNav();
  clickSongControls();
  upperPageBound = songsPerPage() + currentPage * 10;
  lowerPageBound = currentPage * 10;
  for (int i = 0; i < songs.length; i++) {
    if (tracks[i].hover() && isOnPage(i)) {
      currentSong = i;
    }
    if (tracks[i].hover() && songsClicked == 0 && isOnPage(i)) {
      tracks[i].setButtonId(1);
      moveRemainingSongs(i);
      playNewSong(i);
      songsClicked++;
    }
    else if (tracks[i].hover() && tracks[i].getButtonId() == 1 && isOnPage(i)) {
      tracks[i].setButtonId(0);
      createTrackButtons();
    }
    else if (tracks[i].hover() && isOnPage(i)) {
      tracks[i].setButtonId(1);
      moveRemainingSongs(i);
    }
    if (tracks[i].hover() && tracks[i].getButtonId() == 1 && isOnPage(i)) {
      if (!players[i].isPlaying()) {
        playNewSong(i);
      }
      createTrackButtons();
      tracks[i].setButtonId(1);
      moveRemainingSongs(i);
      songsClicked++;
    }
  }
}

