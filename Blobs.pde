class Blobs extends Creature {
  
  public Blobs(int x, int y, int r) {
    super(x, y, r);
    ellipseMode(RADIUS);
  }  
  
  public void draw_shape(){
    stroke(255);
    noFill();
    ellipse(0, 0, radius(), radius());  
  }
  
  public boolean inside(int mx, int my) {    
    if(dist(mx, my, position().x, position().y) < radius()) return true;
    return false;
  }
  
};
