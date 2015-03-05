import teilchen.Physics;
import teilchen.force.Attractor;
import teilchen.force.ViscousDrag;

final int CANVAS_WIDTH = 500;
final int CANVAS_HEIGHT = 500;

final int NBR_CREATURES = 2;

Physics physics;
Attractor attractor;
Creature t;

ArrayList<Creature> creatures = new ArrayList<Creature>();

void setup() {  
  size(CANVAS_WIDTH, CANVAS_HEIGHT);
  background(23, 68, 250);
  frameRate(30);

  physics = new Physics();

  // create a global drag
  ViscousDrag drag = new ViscousDrag();
  drag.coefficient = 2.5f;
  physics.add(drag);  

  // create attaractor
  attractor = new Attractor();
  attractor.radius(500);
  attractor.strength(100);
  physics.add(attractor);

  Creature c;
  for (int i = 0; i < NBR_CREATURES; i++) {
    c = new Blobs((int)random(width), (int)random(height), 20);
    creatures.add(c);
    physics.add(c);
  }
  t = new Thingamajiggy(width/2, height/2, 50);
}

void draw() {

  attractor.position().set(mouseX, mouseY);

  physics.step(1.0 / frameRate);

  //  background(23, 68, 250);
  stroke(255);
  noFill();

  for (int i = 0; i < creatures.size (); i++) {
    Creature c = creatures.get(i);
    c.display();
  }
  t.display();
}





void mousePressed() {
  float inv = -1 * attractor.strength();
  attractor.strength(inv);
}   

