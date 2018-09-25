/////////////////////////////////////////////////////////////////////
// PROJET MASTERMIND - DUT informatique AS 2016-2017
// ALICHE Ceddyk, DUMOULIN Pierre, GILLIARD Tallulah, MARBAT Vincent
/////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////
//// VARIABLES ////

//fond d'écran
PImage fond;

// Couleurs
Interface interfaceJeu = new Interface();
int tourJeu = 1;// variable de tour de jeu (qui est aussi le Y)
int Indice = -1000;// variable d'indice des cases de la ligne en cours (qui est aussi le X)
int bienPlace;
int boutonX=320; 
int boutonY=320;
color vert = color(121, 199, 83);//0
color rouge = color(220, 68, 58);//1
color bleu = color(40, 163, 196);//2
color violet = color(178, 132, 190);//3
color jaune = color(248, 217, 116);//4
color orange = color(251, 170, 76);//5
color rose = color(247, 202, 201);//6
color marron = color(124, 115, 100);//7
color noir = color(0, 0, 0);//8
color blanc= color(255, 255, 255);//9

int taille = 20; // taille et espacement des pions de couleur
int espacement = 10;
int marge=50;

int positionX=680, positionY=390;//position standard des pions evaluation

color [] couleurDispo = {vert, rouge, bleu, violet, jaune, orange, rose, marron}; ///Tableau qui stocke les pions disponibles

Pions combinaisonProposee[] = new Pions[4];//Tableau qui stocke la combinaison proposée
Pions combinaisonMasquee[] = new Pions[4];//Tableau qui stocke la combinaison masquée
ArrayList<Pions>historiqueProposee=new ArrayList<Pions>();//Collection historique pions proposés
ArrayList<Evaluation>Evaluation=new ArrayList<Evaluation>();//Collection de pions evaluations

// Modes disponibles pour les operations sur les pions
enum Mode {
  NORMAL, AJOUT, MOUVEMENT;
}

//INFOS PIONS
//gestion deplacement des pions
// conditions initiales
Mode mode = Mode.NORMAL;
Pions Pions_selectionnee = null;

//Possibilité de déplacer une pion
Pions TrouverPions() {
  for (Pions B : combinaisonProposee) {
    if (dist(mouseX, mouseY, B.x, B.y) < B.taille/2) {
      return B;
    }
  }
  return null;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////
//// METHODE DESSINS ////

void Dessin_pions() {

  for (Pions p : historiqueProposee) {
    noStroke();
    fill(p.couleurPion);
    ellipse(p.x, p.y, taille, taille);
  }
  for (Evaluation e : Evaluation) {
    noStroke();
    fill(e.couleurEvalJ);
    ellipse(e.x, e.y, e.tailleEval, e.tailleEval);
  }
}

void dessinerPalette() { // dessine la palette de couleur
  noStroke();
  for (int i=0; i<couleurDispo.length; i++) {
    fill(this.couleurDispo[i]);
    int Pos1erePastX = width-(8*(taille+espacement))-marge;
    int Pos1erePastY = height-marge; 
    ellipse(Pos1erePastX+(taille+espacement)*i, Pos1erePastY, taille, taille);
  }
}



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// INITIALISATION

void genererCombinaisonMasquee() {///GESTION COMBINAISON MASQUEE
  for (int i = 0; i<4; i++) {//Calcul de la combinaison masquée
    int indiceAleatoire=(int)(Math.random()*(7-1));
    Pions aleatoire = new Pions((150+30*i), 20, color(couleurDispo[indiceAleatoire]));
    combinaisonMasquee[i] = aleatoire;
  }
}

void setup() {
  size(800, 500);
  genererCombinaisonMasquee();
  fond = loadImage("/Images/fond.jpg");
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////
//// METHODES DE TESTS ////
///COMPARAISON TABLEAU COMBINAISON MASQUEE ET TABLEAU PROPOSE
int bien_places(Pions[] t1, Pions [] t2, int taille) {
  bienPlace=0;
  for (int position = 0; position < taille; position++) {
    if (t1[position].code_couleur.equals(t2[position].code_couleur)) {
      bienPlace ++;
    }
  }
  return bienPlace;
}

int nb_el_commun(Pions[] t1, Pions [] t2, int taille) {
  int commun=0;
  boolean [] utilise=new boolean [4];
  for (Pions x : t1) {
    for (int i=0; i<taille; i++) {
      if ((x.code_couleur.equals(t2[i].code_couleur)) && !utilise[i]) {
        commun++;
        utilise[i]=true;
        break;
      }
    }
  }
  return commun;
}


//GESTION DE L'EVALUATION
void afficherPionPosition1(color couleur) {
  Evaluation e1 = new Evaluation(positionX, positionY-(interfaceJeu.tailleCarreau*(tourJeu-1)), couleur);
  Evaluation.add(e1);
}
void afficherPionPosition2(color couleur) {
  Evaluation e2 = new Evaluation(positionX+20, positionY-(interfaceJeu.tailleCarreau*(tourJeu-1)), couleur);
  Evaluation.add(e2);
}
void afficherPionPosition3(color couleur) {
  Evaluation e3 = new Evaluation(positionX, (positionY+20)-(interfaceJeu.tailleCarreau*(tourJeu-1)), couleur);
  Evaluation.add(e3);
}
void afficherPionPosition4(color couleur) {
  Evaluation e4 = new Evaluation(positionX+20, (positionY+20)-(interfaceJeu.tailleCarreau*(tourJeu-1)), couleur);
  Evaluation.add(e4);
}

void creerPionEvaluation(Pions []t1, Pions[] t2) {
  int bienPlace = bien_places(t1, t2, 4);
  int malPlace=nb_el_commun(t1, t2, 4)-bien_places(t1, t2, 4);
  if (bienPlace==0) {
    if (malPlace==1) {
      afficherPionPosition1(blanc);
    }
    if (malPlace==2) {
      afficherPionPosition1(blanc);
      afficherPionPosition2(blanc);
    }
    if (malPlace==3) {
      afficherPionPosition1(blanc);
      afficherPionPosition2(blanc);
      afficherPionPosition3(blanc);
    }
    if (malPlace==4) {
      afficherPionPosition1(blanc);
      afficherPionPosition2(blanc);
      afficherPionPosition3(blanc);
      afficherPionPosition4(blanc);
    }
  }
  if (bienPlace==1) {
    afficherPionPosition1(noir);
    if (malPlace==1) {
      afficherPionPosition2(blanc);
    }
    if (malPlace==2) {
      afficherPionPosition2(blanc);
      afficherPionPosition3(blanc);
    }
    if (malPlace==3) {
      afficherPionPosition2(blanc);
      afficherPionPosition3(blanc);
      afficherPionPosition4(blanc);
    }
  }
  if (bienPlace==2) {
    afficherPionPosition1(noir);
    afficherPionPosition2(noir);
    if (malPlace==1) {
      afficherPionPosition3(blanc);
    }
    if (malPlace==2) {
      afficherPionPosition3(blanc);
      afficherPionPosition4(blanc);
    }
  }
  if (bienPlace==3) {
    afficherPionPosition1(noir);
    afficherPionPosition2(noir);
    afficherPionPosition3(noir);
    if (malPlace==1) {
      afficherPionPosition4(blanc);
    }
  }
  if (bienPlace==4) {
    afficherPionPosition1(noir);
    afficherPionPosition2(noir);
    afficherPionPosition3(noir);
    afficherPionPosition4(noir);
  }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////
//// METHODES DEBUT/FIN PARTIE ////

void nouvellePartie() {

  //vider l'historique
  historiqueProposee.clear();

  //vider les combinaisons proposées
  viderCombinaisonProposee();

  // generer combinaison masquée
  genererCombinaisonMasquee();
  
  //vider l'evaluation
  Evaluation.clear();
  
  // tour de jeu à 1
  tourJeu=1;
  bienPlace = 0;
}

void fin_partie() {

  for (Pions p : combinaisonMasquee) {
    noStroke();
    fill(p.couleurPion);
    ellipse(p.x, p.y, taille, taille);
    fill(blanc);
    text("Solution", 130, 100);
  }
    if (bienPlace==4) {
      fill(blanc);
      text("vous avez gagné!", 150, 200);
    }
    // tour de jeu à 1
  tourJeu=11;
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////
//// METHODES BOOLEENES INTERFACE ////
// on est sur bouton validation
boolean sur_bouton() {
  if (dist(boutonX, boutonY, mouseX, mouseY)<(270)/2) {
    return true;
  } else {
    return false;
  }
}

//on est sur bouton nouvelle partie
boolean sur_boutonNouvellePartie() {
  if (dist(50, 380, mouseX, mouseY)<(270)/2) {
    return true;
  } else {
    return false;
  }
}
//sur ligne
// verifie que le joueur dépose bien les Pions dans la grille prevue a cet effet
boolean dans_grille() {
  return mouseX >= interfaceJeu.departX && mouseX < interfaceJeu.finX
    && mouseY >= ((interfaceJeu.finY+10)-(interfaceJeu.tailleCarreau*tourJeu)) && mouseY < ((interfaceJeu.finY+10)-(interfaceJeu.tailleCarreau*(tourJeu-1)));
}
//sur vide
// verifie que le joueur dépose les Pions dans une zone vide
boolean sur_zonevide() {
  if (dans_grille()) {
    return false;
  } else {
    return true;
  }
}

// SUR PALETTE
// positions des pions en x et y
int Y_AJOUT = 450;
int X_AJOUT = 510;
int X_AJOUT2 = 540;
int X_AJOUT3 = 570;
int X_AJOUT4 = 600;
int X_AJOUT5 = 630;
int X_AJOUT6 = 660;
int X_AJOUT7 = 690;
int X_AJOUT8 = 720;

// verifie chaque pion de couleur
boolean sur_palette() {
  return dist(X_AJOUT, Y_AJOUT, mouseX, mouseY)<(taille)/2;
}
boolean sur_palette2() {
  return dist(X_AJOUT2, Y_AJOUT, mouseX, mouseY)<(taille)/2;
}
boolean sur_palette3() {
  return dist(X_AJOUT3, Y_AJOUT, mouseX, mouseY)<(taille)/2;
}
boolean sur_palette4() {
  return dist(X_AJOUT4, Y_AJOUT, mouseX, mouseY)<(taille)/2;
}
boolean sur_palette5() {
  return dist(X_AJOUT5, Y_AJOUT, mouseX, mouseY)<(taille)/2;
}
boolean sur_palette6() {
  return dist(X_AJOUT6, Y_AJOUT, mouseX, mouseY)<(taille)/2;
}
boolean sur_palette7() {
  return dist(X_AJOUT7, Y_AJOUT, mouseX, mouseY)<(taille)/2;
}
boolean sur_palette8() {
  return dist(X_AJOUT8, Y_AJOUT, mouseX, mouseY)<(taille)/2;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////
//// METHODES EVENEMENTS SOURIS ////
int colo = 0;
void mousePressed() {

  if (sur_palette() || sur_palette2() || sur_palette3() || sur_palette4() || sur_palette5() || sur_palette6() || sur_palette7() || sur_palette8()) {
    colo = get(mouseX, mouseY);
    mode = Mode.AJOUT;
  } 
  if (dans_grille()) {
    Pions p = TrouverPions();
    if (p != null) {
      mode = Mode.MOUVEMENT;
      Pions_selectionnee = p;
    }

    mode = Mode.NORMAL;
  }

}

void mouseDragged() {

  if (dans_grille() && mode == Mode.MOUVEMENT) {
    Pions_selectionnee.x = mouseX;
    Pions_selectionnee.y = mouseY;
  }
}

void mouseReleased() {

  if (sur_bouton() && (combinaisonProposee[0]!=null) && (combinaisonProposee[1]!=null) &&(combinaisonProposee[2]!=null) &&(combinaisonProposee[3]!=null)) {

    creerPionEvaluation(combinaisonMasquee, combinaisonProposee);

    for (Pions p : combinaisonProposee) {
      historiqueProposee.add(p);
    }
    viderCombinaisonProposee();

    tourJeu+=1;
  }
  if (sur_boutonNouvellePartie()) {
    nouvellePartie();
  }
  if (sur_zonevide()) {
    if (mode == Mode.MOUVEMENT) {
      combinaisonProposee[Pions_selectionnee.indice]=null;
      Pions_selectionnee = null;
    }
  } else if (dans_grille()) {
    switch (mode) {
    case AJOUT : // ajout
      Indice = (mouseX % interfaceJeu.departX) / (interfaceJeu.tailleCarreau);
      Pions b = new Pions(Indice, tourJeu, colo); //ajout nouvelle Pions
      b.x = ((mouseX % interfaceJeu.departX) / (interfaceJeu.tailleCarreau))*interfaceJeu.tailleCarreau +(interfaceJeu.departX + (interfaceJeu.tailleCarreau/2)); 
      b.y = ((interfaceJeu.finY+10)-(interfaceJeu.tailleCarreau*tourJeu))+(interfaceJeu.tailleCarreau/2);
      b.couleurPion = colo;
      combinaisonProposee[Indice]=b;
      break;
    case MOUVEMENT: // deplacement
      Pions_selectionnee.x = ((mouseX % interfaceJeu.departX) / (interfaceJeu.tailleCarreau))*interfaceJeu.tailleCarreau +(interfaceJeu.departX + (interfaceJeu.tailleCarreau/2)); 
      Pions_selectionnee.y = ((interfaceJeu.finY+10)-(interfaceJeu.tailleCarreau*tourJeu))+(interfaceJeu.tailleCarreau/2);
      Pions_selectionnee = null;
    }
  }
  mode = Mode.NORMAL;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////
//// METHODE COMBINAISON ////

// dessine les Pions ajoutees dans la grille
void relache_Pions() {
  if ((combinaisonProposee[0]!=null)) {
    fill(combinaisonProposee[0].couleurPion);
    ellipse(combinaisonProposee[0].x, combinaisonProposee[0].y, taille, taille);
  }
  if ((combinaisonProposee[1]!=null)) {
    fill(combinaisonProposee[1].couleurPion);
    ellipse(combinaisonProposee[1].x, combinaisonProposee[1].y, taille, taille);
  }
  if ((combinaisonProposee[2]!=null)) {
    fill(combinaisonProposee[2].couleurPion);
    ellipse(combinaisonProposee[2].x, combinaisonProposee[2].y, taille, taille);
  }
  if ((combinaisonProposee[3]!=null)) {
    fill(combinaisonProposee[3].couleurPion);
    ellipse(combinaisonProposee[3].x, combinaisonProposee[3].y, taille, taille);
  }
}

//réinitialiser la combinaison Proposee a 0 pour chaque case
void viderCombinaisonProposee() {
  combinaisonProposee[0]=null;
  combinaisonProposee[1]=null;
  combinaisonProposee[2]=null;
  combinaisonProposee[3]=null;
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////
//// METHODE DRAW ////
void draw() {
  background(fond);
  noStroke();
  interfaceJeu.dessinerGrille();
  dessinerPalette();
  relache_Pions();
  if (mode == Mode.AJOUT) {
    noStroke();
    fill(colo);
    ellipse(mouseX, mouseY, taille, taille);
  }

  if ((combinaisonProposee[0]!=null) && (combinaisonProposee[1]!=null) &&(combinaisonProposee[2]!=null) &&(combinaisonProposee[3]!=null) ) {//si tableau proposée est plein
    interfaceJeu.dessiner_bouton_envoi();
  }

  Dessin_pions();

  if (bienPlace==4 || tourJeu==11) {
    fin_partie();
  }
  interfaceJeu.afficherNouvellepartie();
  interfaceJeu.afficherBoutonRegle();
}