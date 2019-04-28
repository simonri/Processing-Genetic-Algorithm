Population test;

PVector goal = new PVector(60, 60);
Obstacle[] obstacles;

boolean shouldDraw = false;

float tempFitness = 0.0;
int tempSteps = 0;

void setup() {
  size(800, 800);
  frameRate(60);
  test = new Population(2000);
  
  while(!shouldDraw) {
    if(test.allDotsDead()) {
      doAiStuff();
    } else {
      test.update();
    }
  }
}

void draw() {
  background(234, 196, 53);
  
  tempFitness += (test.bestFitness - tempFitness) * 0.1;
  textFont(createFont("Arial Bold", 16, true), 32);
  fill(52, 89, 149);
  text("Fitness: " + nf(tempFitness, 0, 4).replace(",", "."), 10, 34);
  
  tempSteps += (test.minStep - tempSteps) * 0.01;
  textFont(createFont("Arial Bold", 16, true), 32);
  fill(52, 89, 149);
  text("Steps: " + tempSteps, 10, height - 20);
  
  if(shouldDraw) {
    fill(251, 77, 61);
    rect(goal.x - 10, goal.y - 10, 20, 20);
    
    if(test.allDotsDead()) {
      doAiStuff();
    } else {
      test.update();
      
      if(shouldDraw) {
        test.show();
        saveFrame("frames/####.png");
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
