class Bullet extends GraphicObject {
  boolean isVisible = false;
  color c = color(51, 204, 255);
  
  float diameterBullet = 3;
  float radiusBullet = diameterBullet/2;
  
  float speed = 3;

  Bullet () {
    super();
  }
  
  void activate() {
    isVisible = true;
  }
  
  void update(float deltaTime) {
    
    if (!isVisible) return;
    
    super.update();
    
    if (location.x < 0 || location.x > width || location.y < 0 || location.y > height) {
      isVisible = false;
    }
  }
  
  void display(){
   
    if (isVisible) {
      pushMatrix();
        translate (location.x, location.y);
        fill(c);
        circle (0, 0, diameterBullet);
      popMatrix();
    }    
  }    
}
