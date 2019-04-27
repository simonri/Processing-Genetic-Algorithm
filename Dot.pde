class Dot {
  PVector pos;
  PVector vel;
  PVector acc;
  Brain brain;
  
  boolean dead = false;
  boolean reachedGoal = false;
  boolean isBest = false;
  
  float fitness = 0.0;
  
  int fade = 255;
  
  int size = 6;
  
  Dot() {
    brain = new Brain(400);
    
    pos = new PVector(width / 2, height - 10);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
  }
  
  void show() {
    if(isBest) {
      fill(251, 77, 61, fade);
      ellipse(pos.x, pos.y, 12, 12);
    } else {
      fill(0, 0, 0, fade);
      ellipse(pos.x, pos.y, size, size);
    }
  }
  
  void move() {
    if(brain.directions.length > brain.step) {
      acc = brain.directions[brain.step];
      brain.step++;
    } else {
      kill();
    }
    
    vel.add(acc);
    vel.limit(8);
    pos.add(vel);
  }
  
  void update() {
    if(!dead && !reachedGoal) {
      move();
      
      if(pos.x < 0 || pos.y < 0 || pos.x > width || pos.y > height) {
        kill();
      } else if(dist(pos.x, pos.y, goal.x, goal.y) < 10) {
        reachedGoal = true;
      } else {
        for(int i = 0; i < obstacles.length; i++) {
          if(pos.x - size / 2 < obstacles[i].x + obstacles[i].xVel + obstacles[i].w && pos.y - size / 2 < obstacles[i].y + obstacles[i].h && pos.x + size / 2 > obstacles[i].x + obstacles[i].xVel && pos.y + size / 2 > obstacles[i].y) {
            kill();
          }
        }
      }
    } else {
      fade *= 0.9;
    }
  }
    
  void calculateFitness() {
    if(reachedGoal) {
      fitness = 1.0 / 16.0 + 1000.0 / float(brain.step * brain.step);
    } else {
      float distanceToGoal = dist(pos.x, pos.y, goal.x, goal.y);
      fitness = 1.0 / (distanceToGoal * distanceToGoal);
    }
  }
  
  Dot gimmeBaby() {
    Dot baby = new Dot();
    baby.brain = brain.clone();
    return baby;
  }
  
  void kill() {
    dead = true;
  }
}
