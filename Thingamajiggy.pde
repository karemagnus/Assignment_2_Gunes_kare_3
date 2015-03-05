class Thingamajiggy extends Creature {

  //float targetX = width/2-10;
  //float targetY = height/2-10;

  public Thingamajiggy(int x, int y, int r) {
    super(x, y, r);
    ellipseMode(RADIUS);
    /*if (dist(position().x, position().y, targetX, targetY) < 20) {
      targetX = random(width);
      targetY = random(height);
      println(targetX, targetY);
    }*/
  }

  /*public void migrate_to(float x, float y) {
    position().set(targetX, targetY);
  }*/

  public void drawShape() {
    noFill();
    stroke(255);
    ellipse(position().x, position().y, radius(), radius());  
    //migrate_to(targetX, targetY);
  }

  public boolean inside(int mx, int my) {    
    if (dist(mx, my, position().x, position().y) < radius()) return true;
    return false;
  }
};

