//https://www.openprocessing.org/sketch/205584

//   670-695  // 5s

float zDist = 16, zmin = -250, zmax = 300, zstep = 2.8, rad = 730;
int nb = int((zmax - zmin) / zDist);
PVector[] circles1 = new PVector[nb];
PVector[] circles2 = new PVector[nb];
color[] colors1 = new color[nb];
color[] colors2 = new color[nb];
Boolean bnw = false, dots = true;
int beat;

void setup() {
  frameRate(24);
  size(1920, 1080, P3D);
  //fullScreen(P3D);
  //size(600, 420, P3D);
  noFill();
  strokeWeight(4);
  //colorMode(HSB);
  
  beat = 0;
  
  for (int i = 0; i < nb; i++) {
    circles1[i] = new PVector(0, 0, map(i, 0, nb - 1, zmax/2, zmin));
    circles2[i] = new PVector(0, 0, map(i, 0, nb - 1, zmax, zmin/2));
    colors1[i] = color (191,8,186);
    colors2[i] = color (91,154,0);
    //colors[i]= color (85,100,60);
    //colors[i]= color (302,96,75);
    //colors[i] = color(random(110, 255), 0, random(60, 150));
    //colors[i] = color(random(220, 255), 255, 255);
  }
}

void draw() {
  background(0);
  translate(width/2, height/2);
  PVector pv1;
  PVector pv2;
  float fc1 = (float)frameCount, a1;
  float fc2 = (float)frameCount, a2;
  if (dots) beginShape(POINTS); 

  for (int i = 0; i < nb; i++) {
    pv1 = circles1[i];
    pv2 = circles2[i];
    pv1.z += zstep;
    pv2.z += zstep;
    pv1.x = (noise((fc1*2 + pv1.z) / 550) - .5) * height * map(pv1.z, zmin, zmax, 6, 0);
    pv2.x = (noise((fc2*2 + pv2.z) / 550) - .5) * height * map(pv2.z, zmin, zmax, 6, 0);
    pv1.y = (noise((fc1*2 - 3000 - pv1.z) / 550) - .5) * height * map(pv1.z, zmin, zmax, 6, 0);
    pv2.y = (noise((fc2*2 - 3000 - pv2.z) / 550) - .5) * height * map(pv2.z, zmin, zmax, 6, 0);

    a1 = map(pv1.z, zmin, zmax, 0, 255);
    a2 = map(pv2.z, zmin, zmax, 0, 255);
    
    float r1 = map(pv1.z, zmin, zmax, rad*.1, rad);
    float r2 = map(pv2.z, zmin, zmax, rad*.1, rad);

    if (dots) {
         
   if (!bnw)stroke(colors1[i], a1);
    else stroke(map(pv1.z, zmin, zmax, 0, 255), a1);
      for (int j  = 0; j < r1; j++)
      {
        vertex(pv1.x + r1*cos(j*TWO_PI/r1 + fc1/40)/2, pv1.y + r1*sin(j*TWO_PI/r1 + fc1/40)/2, pv1.z);
      }
      
   if (!bnw)stroke(colors2[i], a2);
    else stroke(map(pv2.z, zmin, zmax, 0, 255), a2);
      for (int j  = 0; j < r2; j++)
      {
        vertex(pv2.x + r2*cos(j*TWO_PI/r2 + fc2/40)/2, pv2.y + r2*sin(j*TWO_PI/r2 + fc2/40)/2, pv2.z);
      }
      
    } else {
      pushMatrix();
      translate(pv1.x, pv1.y, pv1.z);
      ellipse(0, 0, r1, r1);
      popMatrix();
      
      pushMatrix();
      translate(pv2.x, pv2.y, pv2.z);
      ellipse(0, 0, r2, r2);
      popMatrix();
    }

    if (pv1.z > zmax) {
      circles1[i].z = zmin;
    }
    
    if (pv2.z > zmax) {
      circles2[i].z = zmin;
    }
       
    
  }
  if (dots) endShape();
  
  beat++;
  if ( beat == 24*5 ){
    exit();
  }
  saveFrame("data/screen-1080/####.jpg");
}

void keyPressed(){dots = !dots;}
void mousePressed(){bnw = !bnw; exit();}