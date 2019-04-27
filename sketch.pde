Population test;

PVector goal = new PVector(400, 10);
Obstacle[] obstacles;

boolean shouldDraw = false;

float tempFitness = 0.0;

void setup() {
  size(800, 800);
  frameRate(60);
  test = new Population(500);
  
  while(!shouldDraw) {
    if(test.allDotsDead()) {
      doAiStuff();
    } else {
      test.update();
    }
  }
}

void draw() {
  background(255);
  
  tempFitness += (test.bestFitness - tempFitness) * 0.1;
  textSize(32);
  fill(0);
  text(nf(tempFitness, 0, 6), 10, 30);
  
  if(shouldDraw) {
    fill(255, 0, 0);
    ellipse(goal.x, goal.y, 10, 10);
    
    if(test.allDotsDead()) {
      doAiStuff();
    } else {
      test.update();
      
      if(shouldDraw) {
        test.show();
      }
    }
  }
}

void doAiStuff() {
  test.calculateFitness();
  test.naturalSelection();
  test.mutateDemBabies();
  test.resetObstacles();
}
