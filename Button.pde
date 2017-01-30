/**********************
 *  The following is a class that comes from openprocessing.org as part of a program
 *  titled "Game Menu Tutorial 0.5". I modified it to fit in with Avoid better by changing
 *  the text font used and the draw method.
 **********************/

class Button {
  PVector pos;
  color textColor, hoverColor;
  float size, tWidth;
  String text;
 
  /*
   *  This is the constructor for Button. The parameters are the text, position,
   *  font size, text color, and hovering text color.
   */
  Button(String text, PVector pos, float size, color textColor, color hoverColor) {
    this.pos = pos;
    this.textColor = textColor;
    this.hoverColor = hoverColor;
    this.size = size;
    this.text = text;
    textSize(size);
    tWidth = textWidth(text);
    PFont t = loadFont("TwCenMT-Regular-48.vlw");
    textFont(t);
  }
 
   /*
   *  This is the draw method, which displays the button to the window.
   */
  void draw(boolean on) {
    textSize(size);
    if (containsMouse()) fill(hoverColor);
    else fill(textColor);
    text(text, pos.x, pos.y + size);
    if (on)
      rect(pos.x, pos.y, tWidth, size);
  }
 
   /*
   *  This is the mehtod to check if the button has been clicked.
   *
   *  @return boolean for whether it is clicked or not
   */
  boolean containsMouse() {
    if (mouseX > pos.x && mouseX < pos.x + tWidth && mouseY > pos.y && mouseY < pos.y + size )
      return true;
    else return false;
  }
}

