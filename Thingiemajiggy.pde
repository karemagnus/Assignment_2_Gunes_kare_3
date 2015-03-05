class Thingiemajiggy extends Creature {

// center point
float centerX;
float centerY;

float radius = 100, rotAngle = -50;
float accelX, accelY;
float springing = .0009, damping = 0.98;

//corner nodes
int nodes = 10;
float nodeStartX[] = new float[nodes];
float nodeStartY[] = new float[nodes];
float[]nodeX = new float[nodes];
float[]nodeY = new float[nodes];
float[]angle = new float[nodes];
float[]frequency = new float[nodes];

// soft-body dynamics
float organicConstant = 1;

  public Thingiemajiggy(int x, int y, int r) {
    super(x, y, r);

    for (int i=0; i<nodes; i++){
      frequency[i] = random(0, 10);
    }


  }

  public void draw_shape(){
    for (int i=0; i<nodes; i++){
      nodeStartX[i] = centerX+cos(radians(rotAngle))*radius;
      nodeStartY[i] = centerY+sin(radians(rotAngle))*radius;
      rotAngle += 360.0/nodes;
    }

    // draw polygon
    curveTightness(organicConstant);
    stroke(255);
    noFill();
    beginShape();
    for (int i=0; i<nodes; i++){
      curveVertex(nodeX[i], nodeY[i]);
    }
    for (int i=0; i<nodes-1; i++){
      curveVertex(nodeX[i], nodeY[i]);
    }
    endShape();


   moveShape();
}

void moveShape() {
  //move center point
  float deltaX = random(250);
  float deltaY = random(250);

  // create springing effect
  deltaX *= springing;
  deltaY *= springing;
  accelX += deltaX;
  accelY += deltaY;

  // move predator's center
  //centerX += accelX;
  //centerY += accelY;

  // slow down springing
  accelX *= damping;
  accelY *= damping;

  // change curve tightness
  organicConstant = 10-((abs(accelX)+abs(accelY))*1.3);

  //move nodes
  for (int i=0; i<nodes; i++){
    nodeX[i] = nodeStartX[i]+sin(radians(angle[i]))*(accelX*1);
    nodeY[i] = nodeStartY[i]+sin(radians(angle[i]))*(accelY*1);
    angle[i]+=frequency[i];
  }
}

  public boolean inside(int mx, int my) {
    if(dist(mx, my, position().x, position().y) < radius()) return true;
    return false;
  }

};
