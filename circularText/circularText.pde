//  Laurent at www.la-roue-tourne.fr 
// 2016-2017
//   Affichage de mots

// les mots
PFont f;
Mot mot[];
int index;
// les tailles
float[] tailleMot = { 1, 1.25, 1.5, 1.75, 2, 2.25, 2.5, 2.75, 3, 3.25, 3.5, 3.75, 4, 4.25, 4.5, 4.75, 5, 5.25, 5.5, 5.75, 6, 6.25, 6.5, 6.75, 7, 7.25, 7.5, 7.75, 8, 8.25, 8.5, 8.75, 
  9, 9.25, 9.5, 9.75, 10, 10.5, 11, 11.5, 12, 12.5, 13, 13.5, 14, 13.5, 13, 12.5, 12, 11.5, 11, 10.5, 10, 10.5, 11, 11.5, 12, 12.5, 13, 13.5, 14, 13.5, 13, 12.5, 12, 11.5, 11, 10.5, 10, 10.5, 11, 11.5, 12 };
String[] lesMots = {"When the world was created,"," you were created to beautify it"," and you have certainly done a great job"," because the world is smiling for you today."};
int nbreMot, compteurAngle;
float rInit;


// grille
boolean[] grilleLibre;

// divers
boolean fin;
int tMerci;
float dmax;
color colMerci, colTexte;

PImage bg;

void setup() {
  colMerci = color(250, 200, 50); 
  colTexte = color(255);

  index = -1;
  tMerci = 0;

  nbreMot = lesMots.length;

  grilleLibre = new boolean[nbreMot] ;
  for (int i = 0; i < nbreMot; i++) {
    grilleLibre[i] = true;
  }

  f = createFont("Arial", 20, true);
  mot = new Mot[100];
  size(800, 600);
  
  fin = false;

  rInit = min(width, height)*0.3;
  compteurAngle = 0;
  frameRate(24);
} 



void  draw() { 
  boolean onTrouve = false;
  int cx, cy;

  fill(0);
  background(0);
  for (int i = 0; i <= index; i++) {
    mot[i].draw(false);
    mot[i].respire();
  }


  if (random(1) < 0.05) {
    if (index < lesMots.length-1) {
      // on cherche une position de la grille qui soit libre
      while (!onTrouve) {
        cx = int(random(nbreMot));
        if (grilleLibre[cx]) {
          grilleLibre[cx] = false;
          onTrouve = true;
          mot[++index] = new Mot(rInit, cx * TWO_PI/nbreMot, 0, lesMots[index]);
        }
      }
    }
  }

  // est-ce que tous les mots sont dessinés ?
  if (index > 0) {
    onTrouve = true;
    for (int i = 0; i < nbreMot; i++) {
      onTrouve = onTrouve && mot[i].finMot();
    }

    if (onTrouve) {
      fin = true;
    }

    if (fin) {
      tMerci ++;
      if (tMerci < 120) {
        fill(colMerci);

        textSize(tMerci);
        text("Merci !", width/2, height/2);
        for (int i = 0; i <= index; i++) {
          mot[i].draw(false);
          mot[i].decaleR(mot[i].r + 1);
          mot[i].decaleA(mot[i].angleGeneral + .0001*(compteurAngle));
        }
      } else {
        fill(colMerci);
        textSize(max(240 - tMerci, 0.1));
        text("Merci !", width/2, height/2);
        for (int i = 0; i <= index; i++) {
          mot[i].draw(false);
          mot[i].decaleR(mot[i].r + 1 + 0.01*compteurAngle);
          mot[i].decaleA(mot[i].angleGeneral + .0001*(compteurAngle));
        }
      }
      compteurAngle++;
    }
  }
}
void pause(int delai) {
  int time = millis();

  while (millis() - time < delai) {
  }
}

// les mots en spirale


class Mot {
  String leMot;
  float r;
  float angleGeneral, angleMot;
  int indexTaille;
  boolean finDeDessin;
  Mot(float _r, float _angleGeneral, float _angleMot, String _leMot) {
    r = _r;
    angleGeneral = _angleGeneral;
    angleMot = _angleMot;
    indexTaille = 0;
    leMot = _leMot;
    finDeDessin = false;
  }

  void decaleR(float _r) {
    r = _r;
  }

  void decaleA(float _q) {
    angleGeneral = _q;
  }


  void draw(boolean decalage) {
    textFont(f);
    fill(colTexte);
    textAlign(CENTER, CENTER);
    textSize(tailleMot[indexTaille]*1.5);

    pushMatrix();
    rotate(angleMot);
    translate(width/2 + r * cos(angleGeneral), height/2 + r * sin(angleGeneral));
    if (decalage)
      translate(4, 4);
    text(leMot, 0, 0);
    popMatrix();
  }


  void respire() {
    indexTaille ++;
    if (indexTaille == tailleMot.length) {
      indexTaille --;
      finDeDessin = true;
    }
  }

  boolean finMot() {
    return (finDeDessin);
  }
}