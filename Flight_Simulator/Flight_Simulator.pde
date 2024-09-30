Landscape land = new Landscape();
PlaneIcon planeIcon = new PlaneIcon(600, 600);
int cols, rows;
int scl = 20;
int w;
int h;
float altitude;
float angle = PI/3;
float roll;
float yaw;
float prevYaw;

float flying = 0;
float flyRate = 0.01;
float[][] terrain;
IntDict keypresses;

void setup() {
  size(600, 600, P3D);
  w = 4000;
  h = 4000;
  
  cols = w / scl;
  rows = h/ scl;
  terrain = new float[cols][rows];
  altitude = 0;
  roll = 0;
  yaw = 0;
  prevYaw = 0;
  
  keypresses = new IntDict();
  keypresses.set("d",0);
  keypresses.set("a",0);
  keypresses.set("up",0);
  keypresses.set("down",0);
  keypresses.set("left",0);
  keypresses.set("right",0);

}


void draw() {
  altitude = altitude + sin((angle-PI/3))*flyRate*1000;
  flying -= flyRate;

  float yoff = flying;
  for (int y = 0; y < rows; y++) {
    float xoff = 0;
    for (int x = 0; x < cols; x++) {
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -100, 100);
      xoff += 0.07;
    }
    yoff += 0.07;
  }



  background(0);
  stroke(255);
  noFill();

  pushMatrix();
  translate(width/2, height/2+500,0);
  rotateX(angle);
  //println(-altitude);
  translate(-w/2, -h/2,  -altitude);
  rotateY(roll);
  prevYaw += yaw;
  rotateZ(prevYaw); 
  land.render(rows, cols, terrain);
  popMatrix();  
  
  
  
  if (keypresses.get("up") == 1){
    angle -= 0.005;
  }
  
  if (keypresses.get("down") == 1){
    angle += 0.005;
  }
  
  if (keypresses.get("left") == 1){
     roll-= 0.007;
       yaw = roll/100;
  }
  
  if (keypresses.get("right") == 1){
        roll += 0.007;
        yaw = roll/100;
  }
}


void keyPressed(){
  if(key == 'w'){
    
    flyRate += 0.01;
  }
  
  if(key == 's'){
    flyRate -= 0.01;
  }
  
  if(key == CODED){
    if(keyCode == UP){
      keypresses.set("up", 1);
    }
    if(keyCode == DOWN){
      keypresses.set("down", 1);
    }
    if(keyCode == LEFT){
      keypresses.set("left", 1);
    }
    if(keyCode == RIGHT){
      keypresses.set("right", 1);
    }
   }
    

}

void keyReleased() {
  
  if(key == CODED){
    if(keyCode == UP){
      keypresses.set("up", 0);
    }
    if(keyCode == DOWN){
      keypresses.set("down", 0);
    }
    if(keyCode == LEFT){
      keypresses.set("left", 0);
    }
    if(keyCode == RIGHT){
      keypresses.set("right", 0);
       
    }
  }
}
