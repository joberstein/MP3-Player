/* 
Jesse Oberstein
MP3 Player
Updated: April 24th, 2014
*/

import java.util.Comparator;

// Compares song lengths by integer from least to greatest.
public class SongLengthComparator implements Comparator<Song> {
  SongLengthComparator() {
  }
  
  // With this comparator, compare the two given songs.
  public int compare(Song s1, Song s2) {
    if (s1.getDuration() <= s2.getDuration()) {
      return -1;
    }
    else {
      return 1;
    }
  }
  
  // Is this comparator equal to another object?
  public boolean equals(Object obj) {
    return obj instanceof SongLengthComparator;
  }
  
  // There is no way to make a good hashCode since this comparator
  // has no fields or relevant objects to use.
  public int hashCode() {
    return 0;
  }
}

