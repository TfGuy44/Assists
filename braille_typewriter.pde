// https://forum.processing.org/two/discussion/25933/help-deleting-shape

String decode = " a c bif e d hjg k m lsp o n rtq              w  u x v   z y";
 
class Bchar {
  int x, y;
  char a;
  int f;
  boolean dead = false;
  Bchar(char ia) {
    a = ia;
    f = -1;
    for ( int i = 0; i < decode.length(); i++) {
      if (a == decode.charAt(i) ) {
        f = i;
      }
    }
    if ( a == ' ' ) {
      f = 0;
    }
  }
  void draw(int ix, int iy) {
    x = ix;
    y = iy;
    noStroke();
    if ( over() ) {
      stroke(255, 0, 0);
    }
    noFill();
    rect(0, 0, 19, 29);
    noStroke();
    if ( f == 0 ) {
      return;
    }
    fill(0);
    int m = 1;
    for ( int i = 0; i <3; i++) {
      for ( int j = 0; j <2; j++) {
        if ( (m & f) != 0 ) {
          ellipse( 5 + 10* j, 5 + 10 * i, 8, 8);
        } else {
          ellipse( 5 + 10* j, 5 + 10 * i, 2, 2);
        }
        m *= 2;
      }
    }
  }
  boolean over() {
    return(mouseX>x && mouseX<x+20 && mouseY>y && mouseY<y+30);
  }
  void click() {
    if ( over() ) {
      dead = true;
    }
  }
}
 
ArrayList<Bchar> bchars = new ArrayList();
 
void setup() {  
  size(500, 500);
}
 
void draw() {
  background(255);
  for (int i = bchars.size()-1; i >= 0; i-- ) {
    if ( bchars.get(i).dead ) {
      bchars.remove(i);
    }
  }
  int x = 0;
  int y = 0;
  for ( Bchar b : bchars ) {
    pushMatrix();
    translate(x,y);
    b.draw(x, y);
    popMatrix();
    x+=20;
    if ( x > width-20 ) {
      x = 0;
      y += 30;
    }
  }
}
 
void keyPressed() {
  if ( key == ' ' || ( key >= 'a' && key <= 'z' ) ) {
    bchars.add( new Bchar(key) );
  }
}
 
void mousePressed() {
  for ( Bchar b : bchars ) { 
    b.click();
  }
}
