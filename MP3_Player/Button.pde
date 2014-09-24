/* 
Jesse Oberstein
MP3 Player
Updated: April 24th, 2014
*/

// Allows text/image to be clickable by enclosing it in dimensions of a rectangle.
public class Button {
  // The text/image file to be displayed for this button.
  private String words;
  // Dimenstions of the button boundaries
  private int toprx, topry, w, h;
  // The toggle value for hovering effects.
  private int id;

  Button(String words, int toprx, int topry, int w, int h) {
    this.words = words;
    this.toprx = toprx;
    this.topry = topry;
    this.w = w;
    this.h = h;
    this.id = 0;
  }
  
  // Gets the id of this button.
  public int getButtonId() {
    return this.id;
  }
  
  // Set the id of this button to the given value.
  public int setButtonId(int i) {
    return this.id = i;
  }

  // Is the user hovering over this button?
  public boolean hover() {
    return mouseX >= this.toprx 
      && mouseX <= (this.toprx + this.w) 
      && mouseY >= this.topry
      && mouseY <= (this.topry + this.h);
  }

  // Change the color of this button if it's being hovered over.
  public void changeTrackBackground() {
    if (this.hover()) {
      tint(100, 80, 70);
      image(background, this.toprx, this.topry, this.w, this.h);
    }
  }

  // Change the color of this button if it's being hovered over.
  public void changeFunctionButtonBackground() {
    if (this.hover()) {
      tint(250, 250, 50);
    }
    else {
      noTint();
    }
  }

  // Displays this button as an option button (choices for prompts).
  public void displayTrackButton() {
    this.changeTrackBackground();
    noFill();
    stroke(255);
    strokeWeight(2);
    rect(this.toprx, this.topry, this.w, this.h);
    fill(255);
    textFont(avenirb, 20);
    text(this.words, this.toprx + 50, this.topry + 10, this.w + 20, this.h + 20);
    strokeWeight(1);
    noTint();
  }
  
  // Displays a bar that displays the progress of the currently playing song
  // corresponding to this button.
  public void displaySongProgress() {
    fill(0);
    rect(this.toprx + 240, this.topry + 105, 300, 5);
    fill(255, 0, 0);
    rect(toprx + 240 + currentSongTime, topry + 100, 5, 15);
  }
  
  // Displays detailed information about the given song for this button, such as artist,
  // album, length, and a progress bar of where the current time of the song.
  public void displaySongInfo(Song s) {
    if (this.id == 1) {
      tint(100, 80, 70);
      image(background, this.toprx + 15, this.topry + 40, this.w + 20, this.h + 40);
      noFill();
      strokeWeight(2);
      stroke(255);
      rect(this.toprx + 15, this.topry + 40, this.w + 20, this.h + 40);
      fill(255);
      text("Artist: " + s.getArtist() + "\n" 
        + "Album: " + s.getAlbum()  + "\n" 
        + "Length: " + songDurationFormatted(), 
      this.toprx + 90, this.topry + 45, this.w + 20, this.h + 60);
      displaySongProgress();
      strokeWeight(1);
    }
    noTint();
  }

  // Displays this button as a function button (start, home, back).
  public void displayFunctionButton() {
    this.changeFunctionButtonBackground();
    PImage s = loadImage(this.words);
    image(s, this.toprx, this.topry, this. w, this.h);
    noTint();
  }

  // Displays this button as a sorting button.
  public void displaySortingButton() {
    if (this.id == 1) {
      fill(220, 70, 70);
    }
    else if (this.hover()) {
      fill(200, 200, 100);
    }
    else {
      fill(255);
    }
    stroke(0);
    rect(this.toprx, this.topry, this.w, this.h);
    fill(0);
    textFont(avenirb, 16);
    text(this.words, this.toprx + 10, topry + 5, this.w, this.h);
    noTint();
  }
}

