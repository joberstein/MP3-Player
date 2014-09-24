/* 
Jesse Oberstein
MP3 Player
Updated: April 24th, 2014
*/

// A class that represents a song entry retrieved from the "Library.xml".
public class Song {
  // A complete song tag from the root XML.
  private XML track;
  // A number to indicate this song.
  private int id;
  // A song's name, file name, artist, and album.
  private String name, fileName, artist, album;
  // The duration of this song.
  private int duration;

  Song(XML track) {
    this.track = track;
    this.id = this.track.getInt("id");
    this.name = this.track.getString("name");
    this.fileName = this.track.getString("fileName");
    this.artist = this.track.getString("artist");
    this.album = this.track.getString("album");
    this.duration = 0;
  }
  
  // Get the title of this song.
  public String getSongName() {
    return this.name;
  }
  
  // Get the file name of this song.
  public String getFileName() {
    return this.fileName;
  }
  
  // Get the id of this song.
  public int getSongId() {
    return this.id;
  }
  
  // Set the id of this song to the given value.
  public void setSongId(int newId) {
    this.id = newId;
  }
  
  // Get the artist of this song.
  public String getArtist() {
    return this.artist;
  }
  
  // Get the album that this song belongs to.
  public String getAlbum() {
    return this.album;
  }
  
  // Get the duration of this song (in seconds).
  public int getDuration() {
    return this.duration;
  }
  
  // Set the duration of this song (in seconds)
  // with the given value.
  public void setDuration(int newDuration) {
    this.duration = newDuration;
  }
  
  // Display this song as a string with its name and id.
  public String songDisplay() {
    return this.id + ". " + this.name;
  }
  
  // Is this song equal to the given object?
  public boolean equals(Object obj) {
    if (obj == null || !(obj instanceof Song)) {
      return false;
    }
    Song temp = (Song) obj;
    return this.name.equals(temp.name)
      && this.artist.equals(temp.artist)
      && this.album.equals(temp.album)
      && this.fileName.equals(temp.fileName);
  }
  
  // Computes the hash code for this song.
  public int hashCode() {
    return this.name.hashCode() 
      + this.artist.hashCode() 
        + this.album.hashCode();
  }
}

