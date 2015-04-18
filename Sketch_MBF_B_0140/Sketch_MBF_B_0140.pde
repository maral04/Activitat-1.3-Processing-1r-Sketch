var canvi = 1;
PFont font;                      // Declarem la font.
PImage[] img = new PImage[6];     // Declarem l'array d'imatge.
var firsttime = true;
var sucres = 0;

void setup() {
  size(1024, 480);
  background(235, 235, 235);
  //stroke(255, 255, 255);
  //strokeWeight(2);
  noStroke();
  frameRate(14); // Editant baixat FPS, al publicar 30-44-60.

  //font = loadFont("SnackerComic_PerosnalUseOnly.ttf");
  //font = loadFont("Snacker Comic Personal Use Only Normal.ttf");
  //font = loadFont("Snacker Comic Personal Use Only Normal");
  //font = createFont("SnackerComic_PerosnalUseOnly.ttf", true); // Creem la font. Tipus,Tamany,Antialasing.
  //font = createFont("Snacker Comic Personal Use Only Normal", true);

  //font = loadFont("Amandes Salées Normal, true");

  font = createFont("Arial", true);
  img[0] = loadImage("Jelly-Bean-Logov2.png"); // 768 x 545 -> 38,4 x 27,25  
  img[1] = loadImage("sugar-cubev2.png"); // 128 x 117 -> 32 x 29,25
  img[2] = loadImage("candy-wallv2.png"); // 1452 x 389 -> 145,2 x 38,9
  img[3] = loadImage("candy-wall-smallv2.png"); //1774 x 882 -> 88,7 x 44,1
  img[4] = loadImage("Saltv2.png"); //64 x 40 -> 38 x 24,13
  img[5] = loadImage("candy-wallv3.png"); // 1452 x 389 -> 243,936 x 65,352

  jelly = new Jelly(width, height);
  parets = new parets();

  /*
  sugar = new sugar();
   candywallbigsmall = new candywallbigsmall();
   candywallsmall = new candywallsmall();
   salt = new salt();
   candywallbig = new candywallbig();
   */
}

void draw() {

  // 1-Limits pantalla exterior.
  limitsExteriors();

  // 2-Limits laberint interior.
  limitsInteriors();

  /*
  // 3-Introducció del sucre i sal a recollir.
   image(img[4], 35, 25);
   image(img[4], 70, 25);
   image(img[4], 25, 125);
   image(img[1], 240, 133);
   image(img[1], 450, 110);
   image(img[1], 820, 25);
   image(img[1], 705, 130);
   */

  // 4-Creació de la jelly i crida dels seus metodes.
  jelly.move();
  jelly.draw();
  jelly.drawjelly();
}

void limitsExteriors() {
  fill(235, 5, 30);
  //Limit superior. ^ · >
  rect(0, 0, 1024, 5);
  //Limit dreta. > · ^
  rect(1024, 0, -5, 480);
  //Limit inferior.  · >
  rect(0, 480, 1024, -5);
  //Limit esquerra. < · ^
  rect(0, 0, 5, 480);
}

void limitsInteriors() {
  fill(0, 255, 5);
  //rect(15, 65, 95, 45);

  //smooth(8);
  img[4].resize(38, 24);

  image(img[3], 15, 65);
  image(img[5], 190, 55); 
  image(img[5], 495, 55); 
  image(img[2], 795, 65, 149, 41);
  image(img[3], 865, 15);

  image(img[2], 75, 125, 149, 41); 
  image(img[2], 395, 145, 149, 41);
  image(img[2], 695, 165, 149, 41);
  image(img[3], 795, 115);


  image(img[3], 695, 215);
  image(img[5], 15, 265); 
  image(img[5], 260, 265); 
  image(img[2], 595, 265, 149, 41);
}

void mousePressed() {
  if (jelly.mouseOver(mouseX, mouseY)) {
    jelly.mousePressed();
  }
}

void mouseReleased() {
  jelly.mouseReleased();
}

/*
void released() {
 jelly.released();
 }
 */

class Jelly {
  int x, y;
  int height, width;
  int releases = 0;

  Jelly(int x, int y) {
    this.x = x;
    this.y = y;
    this.height = 38;
    this.width = 27;
  }

  boolean moving = false;

  void mousePressed() {
    releases++;
    moving = true;
  }

  void mouseReleased() {
    moving = false;
  }

  boolean mouseOver(int mx, int my) {
    return ((x - mx)*(x - mx) + (y - my)*(y - my)) <= height*width;
  }

  void move() {
    if (moving) {
      this.x = mouseX;
      this.y = mouseY;
    }
  }

  void caixaText() {
    fill(250, 250, 250);                  // Color de background.
    rect(15, 365, 210, 100);              // Faig desapareixer el text amb un rectangle a sobre...
    textFont(font, 22);                   // Especificar la font a ser usada. 
    fill(165);                            // Especificar font color.
    text(mouseX+" "+mouseY, 25, 395);     // Mostra Text amb Coordenades.
    //text("Sucres: "+sucres, 25, 425);            // Mostrar Text amb puntuació.         
    text("Clicks: "+releases, 25, 455);   // Mostrar Text amb clicks.
  }

  void drawjelly() {
    image(img[0], x-15, y-15, height, width);
  }

  void draw() {
    // Posició inicial.
    if (firsttime == true) {
      caixaText();
      x = 145;
      y = 85;
      drawjelly();
      firsttime = false;
    }

    // Mentre està clicada
    if (moving) {
      background(235, 235, 235);
      limitsExteriors();
      limitsInteriors();
      caixaText();

      //height = 36;   // Redueix el tamany. -5%
      //width = 26;    // Redueix el tamany. -5%


      //imageMode(CENTER);
      //imageMode(CORNERS);
      drawjelly();

      // Colisió amb les parets exteriors.
      if (y < dist(0, 0, 0, 21) 
        || x < dist(0, 0, 21, 0)
        || y > dist(0, 480, 0, 18)
        || x > dist(1024, 0, 29, 0)
        ) {
        text("HAS XOCAT! ", 340, 375);
      } else {
        fill(235, 235, 235);
        rect(330, 345, 185, 45);
      }
      // Si hi ha colisió d'img[0] amb img[1] aumenta el tamany de Jelly. Desapareix img[1].
      // Si hi ha colisió d'img[0] amb img[4] redueix el tamany de Jelly. Desapareix img[4].
      /*if((x > dist(450, 110, 0, 0) && x < dist(480, 140, 0, 0))){
       //x < dist(70, 25, 0, 0) && x > 
       sucres++;
       image(img[0], x-15, y-15, height, width);
       //when image enters image radius
       
       }
       else{
       if((x > dist(35, 25, 0, 0) && x < dist(70, 50, 0, 0)) ||
       (x > dist(72, 25, 0, 0) && x < dist(109, 50, 0, 0))
       ){
       sucres--;
       }
       }*/
    }
  }
}

