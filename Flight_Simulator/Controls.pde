public class Controls {
   IntDict keypresses;
   float flyRate;
   float angle;
   float roll;
   float yaw;

   public Controls() {
     this.keypresses = new IntDict();
      this.keypresses.set("d",0);
      this.keypresses.set("a",0);
      this.keypresses.set("w",0);
      this.keypresses.set("s",0);
      this.keypresses.set("up",0);
      this.keypresses.set("down",0);
      this.keypresses.set("left",0);
      this.keypresses.set("right",0);
      
      this.flyRate = 0.01;
   }
   public void processKeyPress(char k, int code, int press){
     if(k == 'w'){
         this.keypresses.set("w", press);
      }
  
      if(k == 's'){
        this.keypresses.set("s", press);
      }
    
      if(k == CODED){
        if(code == UP){
          keypresses.set("up", press);
        }
        if(code == DOWN){
          keypresses.set("down", press);
        }
        if(code == LEFT){
          keypresses.set("left", press);
        }
        if(code == RIGHT){
          keypresses.set("right", press);
           
        }
      }

   
   }
   
   public void executeControl(){
    if (keypresses.get("w") == 1){
      this.flyRate += 0.01;
    }
  
    if (keypresses.get("s") == 1){
      this.flyRate -= 0.01;
    }
   
   
   if (this.keypresses.get("up") == 1){
    this.angle -= 0.005;
  }
  
  if (this.keypresses.get("down") == 1){
    this.angle += 0.005;
  }
  
  if (this.keypresses.get("left") == 1){
     this.roll-= 0.007;
       this.yaw = roll/100;
  }
  
  if (this.keypresses.get("right") == 1){
        this.roll += 0.007;
        this.yaw = roll/100;
  }
   }
  
}
