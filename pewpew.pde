int currentTime;
int previousTime;
int deltaTime;

ArrayList<Mover> flock;
int maxflock = 45;
int flockSize = int(random(10,21));
Vaisseau v;
int maxBullets = 10;
ArrayList<Bullet> bullets;

void setup () {
  size (800, 600);
  currentTime = millis();
  previousTime = millis();
  flockSize = int(random(10,21));
  
  v = new Vaisseau();
  flock = new ArrayList<Mover>();
  bullets = new ArrayList<Bullet>();
  flockSize = int(random(10,21));
  for (int i = 0; i < flockSize; i++) {
    Mover m = new Mover(new PVector(random(0, width), random(0, height)), new PVector(random (-2, 2), random(-2, 2)));
   m.fillColor = color(random(255), random(255), random(255));
    flock.add(m);
  }

  println(flock.size());
  
  v.location.x = width / 2;
  v.location.y = height / 2;
}

void draw () {
  currentTime = millis();
  deltaTime = currentTime - previousTime;
  previousTime = currentTime;
  
  update(deltaTime);
  display();  
}


void update(int delta) {
  
  for (Mover m : flock) {
          m.flock(flock);

      m.update(delta);
    }
  v.update(delta);
for (int i = flock.size() - 1; i >= 0; i--) {
       Mover m = flock.get(i);
      if(v.Boum(m))
      {
      boolean OkRespawn = false;
      PVector respawn = new PVector(width/2,height/2);
          while(!OkRespawn){
            respawn = new PVector(random(0,width),random(0,height));
            for(Mover f : flock){
              if(PVector.dist(f.location, respawn) >= 10){
              OkRespawn = true;
              }
              else
              {
                 OkRespawn  = false;
              }
            }
          }
          v = new Vaisseau();
          v.location = respawn;
      }
      for ( Bullet b : bullets) {
        if(m.Boum(b))
        {
            flock.remove(i);
            flockSize--;
        }
        
      }
    }
    for ( Bullet b : bullets) {
          b.update(deltaTime);
  }
}
      
void display () {
  background(0);
   //<>//
  for (Mover m : flock) {
    m.display();
  }
  
  
  for ( Bullet b : bullets) {
    b.display();
  }
  v.display();
  
}

void mousePressed()
{
  if(flock.size() <= maxflock){
     Mover m = new Mover(new PVector(mouseX, mouseY), new PVector(random (-5, 5), random(-5, 5)));
     m.fillColor = color(random(255), random(255), random(255));
     flock.add(m);
     flockSize += 1;
  }
  
}

void fire(GraphicObject m) {
  Vaisseau c = (Vaisseau)m; //<>//
  
  if (bullets.size() < maxBullets) {
    Bullet b = new Bullet();
    
    b.location = c.location.copy();
    b.topSpeed = b.speed;
    b.velocity = c.getShootingVector().copy().mult(b.topSpeed);
   
    b.activate();
    bullets.add(b);

  } else {
    for ( Bullet b : bullets) {
      if (!b.isVisible) {
        b.location.x = c.location.x;
        b.location.y = c.location.y;
        b.velocity.x = c.getShootingVector().x;
        b.velocity.y = c.getShootingVector().y;
        b.velocity.mult(b.topSpeed);
        b.activate();
        break;
      }
    }
  }  
}

void keyPressed(){
  if (keyPressed) {
    switch (key) {
      case 'a':
        v.pivote(-.03);
        break;
         case 'w':
        v.thrust();;
        break;
      case 'd':
        v.pivote(.03);
        break;
      case ' ':
       fire(v);
        break;  
        case 'r':
        setup();
        break;
    }
  }
}

void keyReleased(){
      if (key == 'w'){
        v.noThrust();
      }    
    }
