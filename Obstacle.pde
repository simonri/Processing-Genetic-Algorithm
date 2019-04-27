class Obstacle {
  int x, y;
  int w, h;
  
  int xVel, yVel;
  
  boolean way = false;
  
  Obstacle(int xTemp, int yTemp, int wTemp, int hTemp) {
    x = xTemp;
    y = yTemp;
    w = wTemp;
    h = hTemp;
  }
  
  void show() {
    fill(100, 100, 100);
    rect(x + xVel, y + yVel, w, h);
    noStroke();
  }
  
  void update() {
    if(way) {
      if(x + xVel + w / 2 > width / 2 + 100) {
        way = false;
      }
    } else {
      if(x + xVel + w / 2 < width / 2 - 100) {
        way = true;
      }
    }
    
    xVel += way ? 2 : -2;
  }
  
  void reset() {
    way = false;
    
    xVel = 0;
    yVel = 0;
  }
}
