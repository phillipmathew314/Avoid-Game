/*
 *  This is a Player class created for the classic game mode.
 */

class Player {
  private int x;
  private int y;
  
  Player(int xLoc, int yLoc) {
    x = xLoc;
    y = yLoc;
  }
  
  /*
   *  This method functions just like moveBirds(), as it moves the player everytime it is called
   *  in the draw method.
   */
  void movePlayer() {
    smooth();
    fill(120, 30, 40);
    stroke(170, 30, 40);
    strokeWeight(5);
    ellipse(mouseX, mouseY, 50, 50);
  }
  
  /*
   *  This metod indicates the starting position of the player in the classic mode.
   */
  void startPos() {
    smooth();
    fill(120, 30, 40);
    stroke(170, 30, 40);
    strokeWeight(5);
    ellipse(width/2, height/2, 50, 50);
  }
}
