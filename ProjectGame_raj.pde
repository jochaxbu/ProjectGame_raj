// Animation baby
int currentPosition = 0;
PImage [] animWin;
PImage lose;
PImage win;
PImage baby0;
PImage monster;
PImage fist;
PImage hand;

// making player array
int maxPlayerNumber=10;
int minPlayerNumber=3;
AudioPlayer[] player_Array;

// sounds
Maxim maxim;
AudioPlayer player1;
AudioPlayer player2;
AudioPlayer player3;
AudioPlayer player4;
AudioPlayer player5;

// flags to check if the sound is played
boolean playing4 = false;
boolean playing5 = false;

//define color names
color red= color(255, 0, 0);
color blue= color(0, 0, 255);
color black= color(0, 0, 0);



//rect appear aparameters
float r1x = random(1,560);
float r1y= random (1,400);
float r2x = random(1,560);
float r2y= random (1,400);
float r3x = random(1,560);
float r3y= random (1,400);

//define ball aprameteres
float ballX = random(20,600);
float ballY = 0;

// other flags 
boolean overBox = false;
/*boolean overBox2 = false;
boolean overBox3 = false;*/
boolean winstatus = false;
boolean losestatus= false;

// default speeds 
float speedX =2;
float speedY =4;


  
int hittime = 0;
int[] hitArray;
int hit1 = 0;
int hit2 = 0;
int hit3 = 0;

void mainFunction()
{ 
  int hit_array_sum=0;
  // set up minPlayerNumber the players 
  for (int i=0; i<minPlayerNumber; i++)
  {
    hitArray[i] = monitorRect(random(1,560),random (1,400),player_Array[i],hitArray[i] );    
   }
     
    //bounce against walls 
    if (ballX  < 0 || ballX  > width) speedX = -speedX ;
    if (ballY >height || ballY  <0) speedY = -speedY;
         
    //move the ball
      ballX +=speedX;
      ballY +=speedY;
       
    //fill(value);
      fill(black);
      ellipse(ballX, ballY, 50, 50);
      imageMode(CENTER);
      image(monster, ballX, ballY,80,80);
      //text ("hit:    " + hit , 10, 10);
      //text ("hit2:    " + hit2 , 100, 10);
      //text ("hit3:    " + hit3 , 190, 10);
       
    //you lose
    //if (hit+hit2+hit3==3){losestatus =true;}
    for (int i=0; i<minPlayerNumber; i++)
    {
      hit_array_sum=hit_array_sum+hitArray[i];
    }
    if (hit_array_sum==3){losestatus =true;}
    
    if (losestatus==true)
    {
        imageMode(CORNER);  
        image(lose, width/2, height/2,200,200);
        
        
        player5.play();
        playing5=true;}
        
        if(playing5==true)
        {
         
        
          //value=black;
        
          ballX=100;
          ballY=100;
        
          r1x=5000;
          r1y=5000;
        
          r2x=5000;
          r2y=5000;
        
          r3x=5000;
          r3y=5000;
        }
        
        imageMode(CENTER);
        image(hand,mouseX,mouseY, 50, 50);
        
        
        //you win
        //if (hit+hit2+hit3==0){imageMode(CENTER);image(fist,mouseX,mouseY, 50, 50);}
        if (hit_array_sum==0)
        {
          imageMode(CENTER);
          image(fist,mouseX,mouseY, 50, 50);
        }
        if (hit_array_sum==0 && mouseX > ballX-40 && mouseX < ballX + 40 && mouseY > ballY-40 && mouseY < ballY + 40 && mousePressed == true)
        {
          winstatus = true;
        }
        
        if (winstatus==true) 
        {
            imageMode(CENTER);image(win, width/2, height/2);
            player4.play();playing4=true;
        }
    
        if(playing4==true)
        {
          ballX=1000;
          ballY=1000;
        }
    
  
}

// Function to initialize Audio players
AudioPlayer initPlayers(AudioPlayer f_player,String f_soundFile,Maxim f_maximLib )
{

  f_player = f_maximLib.loadFile(f_soundFile);
  f_player.setLooping(true);
  return f_player;
}

// function to check the Rectangel
int monitorRect(float f_rectX,float f_rectY,AudioPlayer f_player, int f_hit)
{
  
  // Test if the cursor is over the box  
  if (mouseX > f_rectX && mouseX < f_rectX+80 && mouseY > f_rectY && mouseY < f_rectY+80 && mousePressed == true)
  {
    overBox = true; 
    hittime = 0;
    f_hit=0;
  }
  else 
  {
    overBox = false; 
  }
  //change bgd when hit by click
  /*if (overBox)
  {
    //value = red;
    //hit =0;
    //overBox = false;
    background( 250, 218, 221);
   } */
  
  //if ball enters rect, paint it black
  if (ballX +25 > f_rectX && ballX -25< f_rectX+80 && ballY +25 > f_rectY && ballY -25< f_rectY+80 )
  {
      //value = black;
      hittime += 1;
      background (0);
  }
  else 
  { 
      hittime=0;
  }
    
  if (hittime < 2 && hittime >0) 
  {
     f_hit = 1;
  }
 
  //draw first rect
  //fill(value);
  rect(f_rectX, f_rectY ,80 , 80);
 
    imageMode(CORNER);  
    image(baby0,f_rectX, f_rectY,80,80);
   
   //draw animation
   if(f_hit>=1)
   {
      f_player.play();   
       // draw the current image
      imageMode(CORNER);
      image(animWin[currentPosition], f_rectX, f_rectY ,80 , 80);
      // move to the next image
      currentPosition += 1;
      // when you get to the end, loop
      if(currentPosition >= animWin.length)
      {
         currentPosition = 0;
      }
    
   }
  else 
  {
    f_player.stop();
    
  }
  return f_hit;
  
}



// the  main Windon 
void setup (){
  
size (640,480);
smooth();

//
monster = loadImage("monster.png");
win = loadImage("win.jpg");
animWin = loadImages("anim/baby", ".jpg", 43);

baby0 = loadImage("anim/baby0.jpg");
lose = loadImage("lose.jpg");
fist = loadImage("fist.png");
hand = loadImage("hand.png");
maxim = new Maxim(this);


player_Array=new AudioPlayer[minPlayerNumber];
// set up minPlayerNumber the players 
for (int i=0; i<minPlayerNumber; i++)
{
     
     player_Array[i] = initPlayers(player_Array[i],"baby.wav",maxim);
}
/*player1 = initPlayers(player1,"baby.wav",maxim);
player2 = initPlayers(player2,"baby.wav",maxim);
player3 = initPlayers(player3,"baby.wav",maxim);*/
player4 = initPlayers(player4,"laugh.wav",maxim);
player5 = initPlayers(player5,"cry.wav",maxim);
}



void draw (){
background (255);
stroke(0);
 
 mainFunction();
/*hit1 =monitorRect(r1x,r1y,player1,hit1);
hit2 =monitorRect(r2x,r2y,player2,hit2);
hit3 =monitorRect(r3x,r3y,player3,hit3);
 

println(ballX + "," + ballY);
 
//bounce against walls 
if (ballX  < 0 || ballX  > width) speedX = -speedX ;
if (ballY >height || ballY  <0) speedY = -speedY;
     
//move the ball
  ballX +=speedX;
  ballY +=speedY;
   
//fill(value);
  fill(black);
  ellipse(ballX, ballY, 50, 50);
  imageMode(CENTER);
  image(monster, ballX, ballY,80,80);
  //text ("hit:    " + hit , 10, 10);
  //text ("hit2:    " + hit2 , 100, 10);
  //text ("hit3:    " + hit3 , 190, 10);
   
//you lose
//if (hit+hit2+hit3==3){losestatus =true;}
if (hit1+hit2+hit3==3){losestatus =true;}

if (losestatus==true)
{
    imageMode(CORNER);  
    image(lose, width/2, height/2,200,200);
    
    
    player5.play();
    playing5=true;}
    
    if(playing5==true)
    {
      hit1=2;
      hit2=2;
      hit3=2;
    
      //value=black;
    
      ballX=100;
      ballY=100;
    
      r1x=5000;
      r1y=5000;
    
      r2x=5000;
      r2y=5000;
    
      r3x=5000;
      r3y=5000;
    }
    
    imageMode(CENTER);
    image(hand,mouseX,mouseY, 50, 50);
    
    
    //you win
    //if (hit+hit2+hit3==0){imageMode(CENTER);image(fist,mouseX,mouseY, 50, 50);}
    if (hit1+hit2+hit3==0)
    {
      imageMode(CENTER);
      image(fist,mouseX,mouseY, 50, 50);
    }
    if (hit1+hit2+hit3==0 && mouseX > ballX-40 && mouseX < ballX + 40 && mouseY > ballY-40 && mouseY < ballY + 40 && mousePressed == true)
    {
      winstatus = true;
    }
    
    if (winstatus==true) 
    {
        imageMode(CENTER);image(win, width/2, height/2);
        player4.play();playing4=true;
    }

    if(playing4==true)
    {
      ballX=1000;
      ballY=1000;
    }*/
    
    strokeWeight(abs(mouseX-pmouseX)/10);
}

