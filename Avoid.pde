/**
 *  This program is a game called Avoid. The purpose of the game is to navigate a character 
 *  using the mouse to avoid colliding with any enemies coming from the outside of the board
 *  from random directions ant different speeds according to the level. The final score after the 
 *  game is ended is the number of levels fully completed. There are two themes for the game: classic
 *  and angry birds.
 *
 *  @author Phillip Mathew
 *  @version May 29, 2015
*/

PVector location;      //enemy location
PVector velocity;      //speed of enemy
Player p = new Player(0, 0);    //player in classic mode
PVector[][] vals;      //2d array to hold values of locations and velocities of all enemies
float[][] colors;      //2d array to hold colors of each enemy in classic mode
Button[] startMenu;    //array of buttons to use for menu
boolean classic, angryBirds;        //booleans to indicate which game theme is chosen
boolean done;      //boolean to check if game is done
PImage main;      //image used on home page for classic mode
PImage startBirds, birdback;    //images used for home page and for background of the angry birds theme
PImage blueBird, greenBird, redBird;    //images for all the types of birds on the board
PImage[] birdTypes;        //array that holds the types of birds shown above
int[] birdEnemies;        //array to hold all the type indexes of bird enemies at one time, similar to vals
Timer timer;        //timer to time the game
float level, speed, number;      //class variables to hold the current level, speed, and number of enemies on the board

/**
 *  This is the setup method, required for all processing programs. It sets up the program and menu,
 *  and initilizes the class variables. *
*/
void setup() {
  //playing window
  size(1000, 800);
  background(18);
  
  main = loadImage("black agar background.png");
  //loading all images used in the game
  startBirds = loadImage("angry birds background.png");
  birdback = loadImage("birds bk.jpg");
  blueBird = loadImage("angry-bird-blue-icon.png");
  greenBird = loadImage("green bird.png");
  redBird = loadImage("angry-birds-icon.png");  
  
  //player starts at first level, speed of 1, and 15 enemies on board
  level = 1;
  speed = 1;
  number = 15;
  
  //initializes arrays to keep track of location values
  initializeArrays(15);
  birdTypes = new PImage[2]; 
  done = true;
  timer = new Timer(40, 95);
  
  createBirdTypes();
  generateEnemies();
  
  createStartMenu();
  displayButton(0);
  displayButton(2);
}

/**
 *  This method initializes all the arrays involved in the program. This involves the array that holds
 *  the locations and velocities of all enemies, the array that holds the indexes of all the types of 
 *  bird enemies, and an array to hold all colors of the enemies.
 *
 *  @param num  the number of enemies on the board currently
*/
void initializeArrays(int num) {
  vals = new PVector[num][2];
  birdEnemies = new int[num];
  colors = new float[num][3]; 
}

/**
 *  This method creates the start menu displayed at the beginning of the game. The menu
 *  has two different buttons leading to the two themes of the game, classic and angry
 *  birds. Another button that is not displayed is created that leads back to the menu
 *  after the game is completed.
*/
void createStartMenu() {
  startMenu = new Button[3];
  image(main, 320, 300);
  startMenu[0] = new Button("C  L  A  S  S  I  C", new PVector(355, 340), 48, color(255), color(0, 255, 0));
  classic = false;
  
  startMenu[1] = new Button("M   E   N   U", new PVector(390, 450), 48, color(0), color(0, 255, 0));
  
  image(startBirds, 20, 10);
  startMenu[2] = new Button("A N G R Y   B I R D S", new PVector(315, 130), 48, color(255), color(0, 255, 0));
  angryBirds = false;
}

/**
 *  This method displays a specific button from the array of buttons when called.
 *
 *  @param index  the index of which button to draw to the window
*/
void displayButton(int index) {
  startMenu[index].draw(false);
}

/**
 *  This method is called whenever the mouse is pressed on the window. It is used to tell
 *  if the mouse is clicking th buttons, which leads to other actions. If the mouse presses
 *  the classic button, the player will start playing the classic mode, and likewise with
 *  the angry birds button. If they click the menu button after the game is done, they will be
 *  sent back to the menu.
*/
void mousePressed() {
  if (startMenu[0].containsMouse()) {
    classic = true;  
    //classic mode true now
    background(200);
    generateEnemies();
    p.movePlayer();
    //creates the board, starts the timer, and the enemies start moving
    timer = new Timer(40, 95);
    timer.start();
    done = moveEnemies();
  }
  if (startMenu[1].containsMouse()) {
    //call to setup again to go back to beginning
    setup();
  }
  if (startMenu[2].containsMouse()) {
    angryBirds = true;
    timer = new Timer(40, 95);
    timer.start();
    image(birdback, 0, 0, 1400, 800);
    speed = 3;
  }
}

/**
 *  This method is teh draw method, which is called 10 times per second. If neither of the game
 *  modes are being played, it just displays the menu. If the game is in session, it draws all 
 *  elements accordingly and works with the timer to change instance variables when necessary.
 *  When the game is finished, a "game over" page will be displayed and a button going back to the
 *  menu will be available.
*/
void draw() {
  if (classic == false && angryBirds == false) {
    displayButton(0);
    displayButton(2);
  }
  
  //code run for classic mode
  if (classic) {
    if (done) {
      background(200);
      fill(255, 255, 255, 100);
      rect(25, 25, 100, 100);
      //if the stopwatch hits 15 seconds, the game moves to the next level
      //the timer restarts, the speed and number of enemies increases
      //the same logic is used for the angr birds mode
      if (timer.currentTime() == 15) {
        timer.restart();  
        level += 1;
        if (speed < 3) {
          speed += 0.35;
        }
        number += 4;
        initializeArrays((int)number);
        generateEnemies();
      }
      timer.displayTime();
      
      fill(60);
      textSize(60);
      text("Level " + (int)level, 400, 80);
      p.movePlayer();
      done = moveEnemies();
    }
    else {
      //when the game is over, tet will be displayed and button leading back home
      background(200);
      fill(0);
      textSize(70);
      text("G A M E   O V E R", 255, 300);
      textSize(60);
      text("S C O R E :  " + (int)(level-1), 345, 650);
      displayButton(1);
    }
  }
  
  //code run for angry birds mode
  //all logic similar to classic mode, explained in above code block
  if (angryBirds) {
    if (done) {
      image(birdback, 0, 0, 1400, 800);   
      fill(255, 255, 255, 100);
      rect(25, 25, 100, 100);
      if (timer.currentTime() == 15) {
        timer.restart();  
        level += 1;
        if (speed < 8) {
          speed += 1.5;
        }
        number += 5;
        initializeArrays((int)number);
        generateEnemies();
      }
      timer.displayTime();      
      fill(60);
      textSize(60);
      text("Level " + (int)level, 400, 80);
      
      moveBird();
      done = moveEnemies();
    }
    else {
      background(200);
      fill(0);
      textSize(70);
      text("G A M E   O V E R", 255, 300);
      textSize(60);
      text("S C O R E :  " + (int)(level-1), 345, 650);
      displayButton(1);
    }
  }
}

/**
 *  This method generates all enemies' locations and velocities when beginning the
 *  game, as it initializes the vals array.
*/
void generateEnemies() { 
  for (int i = 0; i < vals.length; i++) {
    //random int from 0 to 3 because the enemies come from 4 sides
    float rand = random(0, 4);
    //velocity vectors determined by which side the enemy is entering the window from
    if (rand >= 0 && rand < 1) {
      vals[i][0] = new PVector(0, random(height));
      vals[i][1] = new PVector(speed, random(-1*speed, speed));
    }
    else if (rand >= 1 && rand < 2) {
      vals[i][0] = new PVector(random(width), 0);
      vals[i][1] = new PVector(random(-1*speed, speed), speed);
    }
    else if (rand >= 2 && rand < 3) {
      vals[i][0] = new PVector(width, random(height));
      vals[i][1] = new PVector(-1*speed, random(-1*speed, speed));
    }
    else if (rand >= 3 && rand < 4) {
      vals[i][0] = new PVector(random(width), height);
      vals[i][1] = new PVector(random(-1*speed, speed), -1*speed);
    }
    
    //chooses either a random color for the enemy for classic mode or a random type
    //of bird for angry birds mode
    if (classic) {
      colors[i][0] = random(255);
      colors[i][1] = random(255);
      colors[i][2] = random(255);
    }
    else if (angryBirds) {
      birdEnemies[i] = (int)random(birdTypes.length);
    }   
  }
}

/**
 *  This method acts in the same way as generateEnemies, except it only runs for
 *  one index of the vals array. It is called to replace an enemy that has flown
 *  off the window.
 *
 *  @param ind  the index of the disappeared enemy in the vals array
*/
void generateSpecificEnemy(int ind) {
  float rand = random(0, 4);
  if (rand >= 0 && rand < 1) {
    vals[ind][0] = new PVector(0, random(height));
    vals[ind][1] = new PVector(speed, random(-1*speed, speed));
  }
  else if (rand >= 1 && rand < 2) {
    vals[ind][0] = new PVector(random(width), 0);
    vals[ind][1] = new PVector(random(-1*speed, speed), speed);
  }
  else if (rand >= 2 && rand < 3) {
    vals[ind][0] = new PVector(width, random(height));
    vals[ind][1] = new PVector(-1*speed, random(-1*speed, speed));
  }
  else if (rand >= 3 && rand < 4) {
    vals[ind][0] = new PVector(random(width), height);
    vals[ind][1] = new PVector(random(-1*speed, speed), -1*speed);
  }
  if (classic) {
      colors[ind][0] = random(255);
      colors[ind][1] = random(255);
      colors[ind][2] = random(255);
  }
  else if (angryBirds) {
    birdEnemies[ind] = (int)random(birdTypes.length);
  }   
}

/**
 *  This method initializes the two different types of bird enemies int he angry birds mode.
*/
void createBirdTypes() {
  birdTypes[0] = blueBird;
  birdTypes[1] = greenBird;
}

/**
 *  This method moves the enemies everytime it is called in draw. It tests for collisions between the 
 *  player and any enemy each time it is called.
 *
 *  @return a boolean that indicates if there has been a collision or not
*/
boolean moveEnemies() {
  for (int i = 0; i < vals.length; i++) {
    //adds the velocity vector to the location vector (movement)
    vals[i][0].add(vals[i][1]);
    
    //alternative distance formula to check if player and enemy have collided
    float xDif = vals[i][0].x - mouseX;
    float yDif = vals[i][0].y - mouseY;
    float distanceSquared = xDif * xDif + yDif * yDif;
    boolean col = distanceSquared < (35) * (35);
    //boolean col to indicate if there was a collision
    //false if there was a colliison, true if there wasn't
    if (col) {
      if (classic) {
        smooth();
        fill(120, 30, 40);
        stroke(170, 30, 40);
        strokeWeight(5);
        ellipse(mouseX, mouseY, 100, 100);
        return false;
      }
      else if (angryBirds) {
        image(redBird, mouseX - 35, mouseY - 35, 100, 100);
        return false;
      }
    }
    else {    
      //the game will still proceed if no collision
      fill(colors[i][0], colors[i][1], colors[i][2]);
      stroke(255);
      strokeWeight(3);
      //if the enemy has flown off the window, it is replaced with a call to generateSpecificEnemy()
      if (vals[i][0].x > width || vals[i][0].x < 0 || vals[i][0].y > height || vals[i][0].y < 0) {
        generateSpecificEnemy(i);
      }
      else {
        if (classic)
          ellipse(vals[i][0].x, vals[i][0].y, 20, 20);
        else if (angryBirds) 
          image(birdTypes[birdEnemies[i]], vals[i][0].x, vals[i][0].y, 30, 30);  
      }
    }
  }
  return true;
}

/**
 *  This method moves the main character for the angry bird game mode
*/
void moveBird() {
  image(redBird, mouseX - 35, mouseY - 35, 70, 70);
}
