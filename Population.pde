class Population {
  Dot[] dots;

  float fitnessSum;
  int gen = 1;

  boolean showOnlyBest = true;

  int showAtGeneration = 60;

  int bestDot = 0;
  int minStep = 1000;

  float bestFitness;

  Population(int size) {
    dots = new Dot[size];
    for (int i = 0; i < size; i++) {
      dots[i] = new Dot();
    }

    obstacles = new Obstacle[3];
    for (int i = 0; i < obstacles.length; i++) {
      obstacles[i] = new Obstacle(width / 2 - 700 / 2, 200 + i * 120, 700, 20);
    }
  }

  void show() {
    if(showOnlyBest) {
      dots[bestDot].show();
    } else {
      for (int i = 0; i < dots.length; i++) {
        dots[i].show();
      }
    }

    for (int i = 0; i < obstacles.length; i++) {
      obstacles[i].show();
    }
  }

  void update() {
    for (int i = 0; i < dots.length; i++) {
      if (dots[i].brain.step > minStep) {
        dots[i].dead = true;
      } else {
        dots[i].update();
      }
    }
    
    for (int i = 0; i < obstacles.length; i++) {
      obstacles[i].update();
    }
  }

  void calculateFitness() {
    for (int i = 0; i < dots.length; i++) {
      dots[i].calculateFitness();
    }
  }

  boolean allDotsDead() {
    for (int i = 0; i < dots.length; i++) {
      if (!dots[i].dead && !dots[i].reachedGoal) {
        return false;
      }
    }
    return true;
  }

  void naturalSelection() {
    Dot[] newDots = new Dot[dots.length];
    setBestDot();
    calculateFitnessSum();

    newDots[0] = dots[bestDot].gimmeBaby();
    newDots[0].isBest = true;
    for (int i = 1; i < newDots.length; i++) {
      Dot parent = selectParent();

      newDots[i] = parent.gimmeBaby();
    }

    dots = newDots.clone();
    gen++;
    // println("Gen: ", gen);
    println("Fitness: ", bestFitness);
    if (gen > showAtGeneration) {
      shouldDraw = true;
    }
  }

  void calculateFitnessSum() {
    fitnessSum = 0;
    for (int i = 0; i < dots.length; i++) {
      fitnessSum += dots[i].fitness;
    }

    bestFitness = dots[bestDot].fitness;
  }

  Dot selectParent() {
    float rand = random(fitnessSum);

    float runningSum = 0;

    for (int i = 0; i < dots.length; i++) {
      runningSum += dots[i].fitness;
      if (runningSum > rand) {
        return dots[i];
      }
    }

    return null;
  }

  void mutateDemBabies() {
    for (int i = 1; i < dots.length; i++) {
      dots[i].brain.mutate();
    }
  }

  void setBestDot() {
    float max = 0;
    int maxIndex = 0;
    for (int i = 0; i < dots.length; i++) {
      if (dots[i].fitness > max) {
        max = dots[i].fitness;
        maxIndex = i;
      }
    }

    bestDot = maxIndex;

    if (dots[bestDot].reachedGoal) {
      minStep = dots[bestDot].brain.step;
      // println("Steps: ", minStep);
    }
  }
  
  void resetObstacles() {
    for(int i = 0; i < obstacles.length; i++) {
      obstacles[i].reset();
    }
  }
}
