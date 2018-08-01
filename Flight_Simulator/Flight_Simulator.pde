Landscape land = new Landscape();
int cols, rows;
int scl = 20;
int w;
int h;
float altitude;
float angle = PI/3;

float flying = 0;
float flyRate = 0.01;
float[][] terrain;

void setup() {
  size(600, 600, P3D);
  w = 4000;
  h = 4000;
  
  cols = w / scl;
  rows = h/ scl;
  terrain = new float[cols][rows];
  altitude = 0;
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

  translate(width/2, height/2+500,0);
  rotateX(angle);
  println(-altitude);
  translate(-w/2, -h/2,  -altitude);
  
  land.render(rows, cols, terrain);
  
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
    angle -= 0.05;  
  }
  if(keyCode == DOWN){
    angle += 0.05;
  }
  }
  if(key == 'd'){
    
  }
  if(key == 'a'){
  
  }
}