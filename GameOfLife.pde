import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS=20;
public final static int NUM_COLS=20;
private Life[][] buttons; //2d array of Life buttons each representing one cell
private boolean[][] buffer; //2d array of booleans to store state of buttons array
private boolean running = true; //used to start and stop program

public void setup () {
  size(400, 400);
  frameRate(6);
  // make the manager
  Interactive.make( this );

  //your code to initialize buttons goes here
  buttons=new Life[NUM_ROWS][NUM_COLS];
  for(int n=0;n<NUM_ROWS;n++){
    for(int m=0;m<NUM_COLS;m++){
      buttons[n][m]=new Life(n,m);
    }
  }
  //your code to initialize buffer goes here
  buffer=new boolean[NUM_ROWS][NUM_COLS];
  for(int n=0;n<NUM_ROWS;n++){
    for(int m=0;m<NUM_COLS;m++){
      buffer[n][m]=buttons[n][m].getLife();
    }
  }
}

public void draw () {
  background( 0 );
  if (running == false) //pause the program
    return;
  copyFromButtonsToBuffer();

  //use nested loops to draw the buttons here
  for(int n=0;n<NUM_ROWS;n++){
    for(int m=0;m<NUM_COLS;m++){
      if(countNeighbors(n,m)==3) buffer[n][m]=true;
      else if(countNeighbors(n,m)==2) buffer[n][m]=true;
      else buffer[n][m]=false;
      buttons[n][m].draw();
    }
  }
  copyFromBufferToButtons();
}

public void keyPressed() {
  //your code here
  if(key=='f'){
    if(running) running=false;
    else running=true;
  }
  if(key=='e'){
    for(int n=0;n<NUM_ROWS;n++){
      for(int m=0;m<NUM_COLS;m++){
        buttons[n][m].setLife(false);
      }
    }
  }
}

public void copyFromBufferToButtons() {
  //your code here
  for(int n=0;n<NUM_ROWS;n++){
    for(int m=0;m<NUM_COLS;m++){
      if(buffer[n][m]) buttons[n][m].setLife(true);
      else buttons[n][m].setLife(false);
    }
  }
}

public void copyFromButtonsToBuffer() {
  //your code here
  for(int n=0;n<NUM_ROWS;n++){
    for(int m=0;m<NUM_COLS;m++){
      if(buttons[n][m].getLife()) buffer[n][m]=true;
      else buffer[n][m]=false;
    }
  }
}

public boolean isValid(int r, int c) {
  //your code here
  return((r<NUM_ROWS&&r>=0)&&(c<NUM_COLS&&c>=0));
}

public int countNeighbors(int row, int col) {
  int neighbors = 0;
  //your code here
  if(isValid(row+1,col)){if(buttons[row+1][col].getLife()) neighbors++;}
  if(isValid(row-1,col)){if(buttons[row-1][col].getLife()) neighbors++;}
  if(isValid(row,col+1)){if(buttons[row][col+1].getLife()) neighbors++;}
  if(isValid(row,col-1)){if(buttons[row][col-1].getLife()) neighbors++;}
  if(isValid(row+1,col+1)){if(buttons[row+1][col+1].getLife()) neighbors++;}
  if(isValid(row+1,col-1)){if(buttons[row+1][col-1].getLife()) neighbors++;}
  if(isValid(row-1,col+1)){if(buttons[row-1][col+1].getLife()) neighbors++;}
  if(isValid(row-1,col-1)){if(buttons[row-1][col-1].getLife()) neighbors++;}
  return neighbors;
}

public class Life {
  private int myRow, myCol;
  private float x, y, width, height;
  private boolean alive;

  public Life (int row, int col) {
    width = 400/NUM_COLS;
    height = 400/NUM_ROWS;
    myRow = row;
    myCol = col; 
    x = myCol*width;
    y = myRow*height;
    alive = Math.random() < .5; // 50/50 chance cell will be alive
    Interactive.add( this ); // register it with the manager
  }

  // called by manager
  public void mousePressed () {
    alive = !alive; //turn cell on and off with mouse press
  }
  public void draw () {    
    if (alive != true)
      fill(0);
    else 
      fill( 150 );
    rect(x, y, width, height);
  }
  public boolean getLife() {
    //replace the code one line below with your code
    return alive;
  }
  public void setLife(boolean living) {
    //your code here
    alive=living;
  }
}
