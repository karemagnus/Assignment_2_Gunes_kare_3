import teilchen.Physics;
import teilchen.force.Attractor;
import teilchen.force.ViscousDrag;
import teilchen.behavior.Arrival;

final int CANVAS_WIDTH = 500;
final int CANVAS_HEIGHT = 500;

final int NBR_CREATURES = 2;

Physics physics;
Attractor attractor;
Thingiemajiggy t;

Arrival arrival;

ArrayList<Blobs> creatures = new ArrayList<Blobs>();

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
  attractor.radius(300);
  attractor.strength(100);
  //physics.add(attractor);

  arrival = new Arrival();
  arrival.breakforce(100);
  arrival.breakradius(10);
  arrival.position().set((int)width/2, (int)height/2);

  for (int i = 0; i < NBR_CREATURES; i++) {
    Blobs c = new Blobs((int)random(width), (int)random(height), 20);
    creatures.add(c);
    physics.add(c);
  }
  t = new Thingiemajiggy(width/2, height/2, 50);
  physics.add(t);
  t.behaviors().add(arrival);
  
}

void draw() {

  physics.step(1.0 / frameRate);
  background(23, 68, 250);
  
  noFill();
  stroke(255,0,0);
  attractor.position().set(t.position().x, t.position().y);
  println(attractor.position().x + ":" + attractor.position().y + " thingie: " + t.centerX + ":" + t.centerY);
  ellipse(attractor.position().x, attractor.position().y, attractor.radius(), attractor.radius());  

  for (int i = 0; i < creatures.size (); i++) {
    Blobs c = creatures.get(i);
    c.display();
  }

  t.display(); // this call translates position for some reason
  //t.drawShape();
  
  // draw arrival
  stroke(255, 255, 0);
  fill(128);
  ellipse(arrival.position().x, arrival.position().y, arrival.breakradius() * 2, arrival.breakradius() * 2);
  noFill();

  if(frameCount % 150 == 0) {
    arrival.position().set((int)random(width),(int)random(height));
  }
  
}


void mousePressed() {
  float inv = -1 * attractor.strength();
  attractor.strength(inv);
}   

