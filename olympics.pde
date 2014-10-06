import processing.serial.*;
import ddf.minim.*;


Minim minim;
AudioPlayer player;
AudioPlayer countdown;
AudioPlayer musicplayer;

Serial myPort;
int val;

int humanPenaltyButton = 230;
int alienPenaltyButton = 231;
int tossButton = 232;
int tiltButton = 233;
int hopButton = 234;

int modifyTime = 1;

int audienceButton = 2;
boolean pauseGame = false;
int hopPiezo = 1;
int tossPhoto = 3;
int tiltTilt = 4;

int whichGame = 0;

PImage background;
PImage image;
PFont f;

Timer timer;
boolean timesUP = false;
boolean timerStart = false;

boolean startGame = true;
boolean tiltGame = false;
boolean tossGame = false;
boolean hopGame = false;
boolean alienTurn = true;
boolean humanTurn = false;
boolean gameChosen = false;
boolean ballScored = false;
int currentRound = 0;

int humanScore = 0;
int alienScore = 0;

void setup() {
  size (800, 532);
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);

  minim = new Minim(this);
  timer = new Timer(400, 250);
  
  player = minim.loadFile("3beeps.wav");
  player.play();  
  //+++++++++++++++++++++++++++++++++++++++++++++play the start-screen sound
  musicplayer = minim.loadFile("music2.mp3");
  musicplayer.loop();
}

void draw() {

  if (val == humanPenaltyButton) {
    //+++++++++++++++++++++++++++++++++++++++++++play the human penalty sound
    player.close();
    player = minim.loadFile("humanpenalty.mp3");
    player.play();
    if (humanScore > 0)
      humanScore--;
  }
  if (val == alienPenaltyButton) {
    //+++++++++++++++++++++++++++++++++++++++++++play the alien penalty sound
    player.close();
    player = minim.loadFile("alienpenalty.mp3");
    player.play();
    if (alienScore > 0)
      alienScore--;
  }

  if (val == audienceButton)
  {  
    if (!pauseGame) {
      //+++++++++++++++++++++++++++++++++++++++++++play the INTERVENTION sound
      countdown.pause();
      player.close();
      player = minim.loadFile("buzzer.mp3");
      player.play();
      timer.pause();
      pauseGame = true;
    }
    else {
      //+++++++++++++++++++++++++++++++++++++++++++play the INTERVENTION sound
      player.close();
      player = minim.loadFile("resumegame.mp3");
      player.play();
      countdown.play();
      timer.continueRunning();
      pauseGame = false;
    }
  }
  if (startGame) {
    background = loadImage("backgroundstart.jpg");
    background(background);      


    val = myPort.read();
    println(val);

    if (val == tiltButton)
    {
      startGame = false;
      ++currentRound;
      delay(200);
      myPort.clear();
    }
  }

  if (currentRound == 1) {
    chooseGame();
  }
  if (currentRound == 2) {
    chooseGame();
  }
  if (currentRound == 3) {
    chooseGame();
  }
  if (currentRound == 4) {
    chooseGame();
  }     
  if (currentRound>4)
  {
    if (alienScore>humanScore)
    {
      background = loadImage("martianwin.jpg");
      //+++++++++++++++++++++++++++++++++++++++++++++play the martians-win sound
     // player.close();
    //  player = minim.loadFile("alienwin.wav");
     // player.play();
      background(background);
    }
    else
    {
      background = loadImage("humanswin.jpg");
      //+++++++++++++++++++++++++++++++++++++++++++++play the humans-win sound
     // player.close();
      //player = minim.loadFile("humanwin.wav");
     // player.play();
      background(background);
    }
  }

  delay(100);
}

int whichGame() {
  background = loadImage("whichgame.jpg");
  background(background);
  displayRound();

  val = myPort.read();
  println(val);

  if (val == tossButton) {
    return 5000;
  }
  // if (val == tiltButton){return 5001;}
  if (val == hopButton) {
    return 5002;
  } 

  return 0;
}

void tilt() {
  background = loadImage("tiltgame.jpg");
  background(background);
}

void hop() {
  background = loadImage("hopgame.jpg");
  background(background);   

  displayRound();


  f = loadFont("Arial-Black-60.vlw") ;
  textFont(f);
  fill(24, 237, 22);
  text(alienScore, 150, 355);
  fill(9, 225, 234);
  text(humanScore, 570, 355);

  if (alienTurn) {
    //start a timer --> 10 seconds
    if (timerStart == false) {
      timer.start();
      timerStart = true;
    }
    timer.DisplayTime();

    val = myPort.read();
    println(val); 

    if (val == hopPiezo) {
      alienScore++;
    }

    if (timesUP) {
      //+++++++++++++++++++++++++++++++++++++++++++++play the buzzer sound
      player.close();
      player = minim.loadFile("3beeps.wav");
      player.play();
      alienTurn = false;
      humanTurn = true;
      timerStart = false;
      timesUP = false;
      delay(2000);
    }
  }
  if (humanTurn) {
    if (timerStart == false) {
      timer.restart();
      timerStart = true;
    }

    timer.DisplayTime();

    val = myPort.read();
    println(val);

    if (val == hopPiezo) {
      humanScore++;
    }


    if (timesUP) {   
      humanTurn = false;
      alienTurn = true;
      timerStart = false;
      timesUP = false;
      ++currentRound;
      gameChosen = false;
    }
  }
}
void toss() {
  background = loadImage("tossgame.jpg");
  background(background);   
  //+++++++++++++++++++++++++++++++++++++++++++++play the toss-game-screen sound
  displayRound();

  f = loadFont("Arial-Black-60.vlw") ;
  textFont(f);
  fill(24, 237, 22);
  text(alienScore, 150, 355);
  fill(9, 225, 234);
  text(humanScore, 570, 355);


  if (alienTurn) {      
    player.close();
    if (timerStart == false) {

      timer.start();
      timerStart = true;
    }
    timer.DisplayTime();

    val = myPort.read();
    println(val); 

    if (val == tossPhoto) {
      if (ballScored != true) {
        alienScore += 10;
        ballScored = true;
      }
    }   


    if (timesUP) {
      //+++++++++++++++++++++++++++++++++++++++++++++play the buzzer sound
      player.close();
      player = minim.loadFile("3beeps.wav");
      player.play();
      alienTurn = false;
      humanTurn = true;
      timerStart = false;
      timesUP = false;
      ballScored = false;
      delay(2000);
      myPort.clear();
    }
  }
  if (humanTurn) {
    if (timerStart == false) {
      timer.start();
      timerStart = true;
    }
    timer.DisplayTime();

    val = myPort.read();
    println(val); 

    if (val == tossPhoto) {
      if (ballScored != true) {
        humanScore += 10;
        ballScored = true;
      }
    }     

    if (timesUP) {
      humanTurn = false;
      alienTurn = true;
      timesUP = false;
      timerStart = false;
      ballScored = false;
      ++currentRound;
      gameChosen = false;
    }
  }
}


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

  int currentTime()
  {
    if ( running )
      return ( (int) ( (modifyTime - (millis() - startTime) / 1000.0)/*+60*/) ) ;
    else
      return ( (int) (timeSoFar / 1000.0) ) ;
  }

  void start()
  {      
    //+++++++++++++++++++++++++++++++++++++++++++++play the countdown sound
    countdown = minim.loadFile("10-countdown.mp3");
    countdown.play();
    running = true ;
    startTime = millis() ;
  }

  void restart()
    // reset the timer to zero and restart, identical to start
  {
    start() ;
  }

  void pause()
  {
    if (running)
    {
      timeSoFar = millis() - startTime ;
      running = false ;
    }

    // else do nothing, pause already called
  }

  void continueRunning()
    // called after stop to restart the timer running
    // no effect if already running
  {
    if (!running)
    { 
      startTime = millis() - timeSoFar ;
      running = true ;
    }
  }

  void DisplayTime()
  {
    String output = "";
    int theTime;
    theTime = currentTime() ;
    output = output + theTime ;
    PFont font ;
    font = loadFont("Arial-Black-90.vlw") ;
    textFont(font) ;
    fill(245, 10, 15);

    if (running == false)
    {
      text("INTERVENTION", x-380, y-50);
    }
    else if (theTime > -1) {
      text(output, x-60, y-50);
    }
    else {
      font = loadFont("Arial-Black-45.vlw") ;
      textFont(font) ;
      // text("TURN OVER",x-180,y-70);
      timesUP = true;
    }
  }
}

void chooseGame() {
  if (!gameChosen) {
    whichGame = whichGame();
  }   
  if (whichGame == 5000) {
    gameChosen = true;
    toss();
  }  
  if (whichGame == 5001) {
    gameChosen = true;
    tilt();
  } 
  if (whichGame == 5002) {
    gameChosen = true;
    hop();
  }
}

void displayRound() {
  if (!startGame)
  {
    if (currentRound > 0) {
      f = loadFont("Arial-Black-45.vlw") ;
      textFont(f) ;
      text("Current Round: ", 10, 500);
      text(currentRound, 390, 500);
    }
  }
}



