/**********************
 *  The following is a class that comes from learningprocessing.com as part of a program
 *  titled "Timer". I modified it to fit in with Avoid by changing the displayTime() method.
 **********************/

class Timer
{
 long startTime ; // time in msecs that timer started
 long timeSoFar ; // use to hold total time of run so far, useful in
 // conjunction with pause and continueRunning
 boolean running ;
 int x, y ; // location of timer output

 Timer(int inX, int inY)
 {
   x = inX ;
   y = inY ;
   running = false ;
   timeSoFar = 0 ;
 }

  /*
   *  This method calculates the current time on the timer.
   *
   *  @return the current time
   */
 int currentTime()
 {
   if ( running )
   return ( (int) ( (millis() - startTime) / 1000.0) ) ;
   else
   return ( (int) (timeSoFar / 1000.0) ) ;
 }
  
  /*
   *  This method starts the timer.
   */
 void start()
 {
   running = true ;
   startTime = millis() ;
 }
 
 /*
   *  This method restarts the timer.
   */
 void restart()
 // reset the timer to zero and restart, identical to start
 {
   start() ;
 }
  
  /*
   *  This method pauses the timer.
   */
 void pause()
 {
   if (running)
   {
   timeSoFar = millis() - startTime ;
   running = false ;
   }
 // else do nothing, pause already called
 }

  /*
   *  This method is called after stop to restart the timer running.
   */
 void continueRunning()
 {
   if (!running)
   {
   startTime = millis() - timeSoFar ;
   running = true ;
   }
 }

  /*
   *  This method displays the time from the timer onto the screen.
   */
 void displayTime()
 {
   int theTime ;
   String output = "";
  
   theTime = currentTime() ;
   output = output + theTime ;
  
   // println("output = " + output) ;
   fill(0);
   textSize(60);
   text(output,x,y) ;
 }
}
