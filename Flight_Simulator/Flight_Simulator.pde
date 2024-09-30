Landscape land = new Landscape();
PlaneIcon planeIcon = new PlaneIcon(600, 600);
Controls controls = new Controls();
int cols, rows;
int scl = 20;
int w;
int h;
float altitude;
//float yaw;
//float prevYaw;

float flying = 0;
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

  //yaw = 0;
  //prevYaw = 0;

  keypresses = new IntDict();
  keypresses.set("d", 0);
  keypresses.set("a", 0);
  keypresses.set("up", 0);
  keypresses.set("down", 0);
  keypresses.set("left", 0);
  keypresses.set("right", 0);
}


void draw() {
  altitude = altitude + sin((controls.angle-PI/3))*controls.flyRate*1000;
  flying -= controls.flyRate;

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
  translate(width/2, height/2+500, 0);
  rotateX(controls.angle);
  translate(-w/2, -h/2, -altitude);
  //rotateY(controls.roll);
  //prevYaw += yaw;
  //rotateZ(prevYaw);
  land.render(rows, cols, terrain);
  popMatrix();


  controls.executeControl();
}


void keyPressed() {
  controls.processKeyPress(key, keyCode, 1);
}

void keyReleased() {
  controls.processKeyPress(key, keyCode, 0);
}
