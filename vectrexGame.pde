Vst vst;
PVector star_position;
ArrayList<Marker> markers = new ArrayList<Marker>();
ArrayList<Star> stars = new ArrayList<Star>();
ArrayList<Flower> garden = new ArrayList<Flower>();
int caught = 0;
int level = 0;
void setup() {
  vst = new Vst(this, createSerial());
  startScreen();
  size(512, 600, P2D);
  fill(0);
  blendMode(ADD); //makes lines brighter when they cross
  frameRate(25);
}

void draw() {
  background(0);
  for (Marker tic:markers){
    tic.display();
  }
  pushMatrix();
  PVector netPos = new PVector(width - 150, mouseY);
  translate(netPos.x, netPos.y);
  scale(1.5);
  mouseNet();
  popMatrix();
  //set starting position for each star
  // Star(PVector inCenter, float inRadius)
  star_position = new PVector(-width/8, random(height/2, height/3));
  //set the interval of time at which the starts are created
  println(random(20));
  if(floor(random(20))==0 && garden.size()<5 ){
    //set the starting location and radius
    stars.add(new Star(star_position, random(5,20)));
  }
   for(int i=0; i< stars.size(); i++){
    Star star = stars.get(i);
    float collideNet = dist(star.newPos.x, star.newPos.y, netPos.x, netPos.y);
    if (collideNet < 50){
      stars.remove(star);
      caught++;
      println(caught);
    }
    if(star.age > 150){
      stars.remove(star);
    }else{
    star.display();
    star.update();
    }
  }
  //after catching 3 stars, turn marker into flower
  if (caught == 3*level){
    if(garden.size() < 5){
      //remove tic from the marker list
      markers.remove(0);
      garden.add(new Flower(random(80,240), random(450,540), ceil(random(5.1,8.9)),
      random(0.5, 1.5) * level * 0.2,random(-0.2,0.2 )));
    }
    caught = 0 ;

  }
  //display flower
  stroke(64);
  for (Flower blossom: garden){
    blossom.display();
  }
  
  if (garden.size()==5){
    garden.clear();
    stars.clear();
    startScreen();
    level++;
  }
  
  vst.display();
}

void mouseNet() {
  for (int i = 1; i < 11; i++) {
    line(0, 10, 0, -28);
    PVector net = new PVector(0, -i * 2.8);
    PVector net2 = new PVector(i * 6, 0);
    PVector net3 = new PVector(i * 5, .54 * i * 5 -30);
    // draw the soft net in a thinner strokeweight
    stroke(150);
    line(net2.x, net2.y, net.x, net.y);
    line(net2.x, net2.y, net3.x, net3.y);
  }
}

void startScreen(){
  for (int i = 1; i<6 ; i++){
    markers.add(new Marker(180 + (i*30), 580));
  }
}