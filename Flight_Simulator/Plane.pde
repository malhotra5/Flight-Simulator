public class PlaneIcon {
  int h;
  int w;
  public PlaneIcon(int w, int h){
    this.w = w;
    this.h= h;
  }
  public void render(){
    int x1 = this.w - 300;
    int y1 = this.h - 300;
    int x2 = this.w - 200;
    int y2 = this.h - 200;
    int x3 = this.w - 100;
    int y3 = this.h - 300;
    triangle(x1, y1, x2, y2, x3, y3);

  }
}
