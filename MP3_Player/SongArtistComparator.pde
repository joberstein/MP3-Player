/* 
Jesse Oberstein
MP3 Player
Updated: April 24th, 2014
*/

import java.util.Comparator;

// Compares song artist strings alphabetically.
public class SongArtistComparator implements Comparator<Song> {
  SongArtistComparator() {
  }
  
  // With this comparator, compare the two given songs.
  public int compare(Song s1, Song s2) {
    return s1.getArtist().compareTo(s2.getArtist());
  }

  // Is this comparator equal to another object?
  public boolean equals(Object obj) {
    return obj instanceof SongArtistComparator;
  }

  // There is no way to make a good hashCode since this comparator
  // has no fields or relevant objects to use.
  public int hashCode() {
    return 0;
  }
}

