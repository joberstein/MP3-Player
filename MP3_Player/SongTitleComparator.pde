/* 
Jesse Oberstein
MP3 Player
Updated: April 24th, 2014
*/

import java.util.Comparator;

// Compares song title strings alphabetically.
public class SongTitleComparator implements Comparator<Song> {
  SongTitleComparator() {
  }
  
  // With this comparator, compare the two given songs.
  public int compare(Song s1, Song s2) {
    return s1.getSongName().compareTo(s2.getSongName());
  }
  
  
  // Is this comparator equal to another object?
  public boolean equals(Object obj) {
    return obj instanceof SongTitleComparator;
  }
  
  
  // There is no way to make a good hashCode since this comparator
  // has no fields or relevant objects to use.
  public int hashCode() {
    return 0;
  }
}

