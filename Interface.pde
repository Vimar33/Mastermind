class Interface {
  // ATTRIBUTS //
  int tailleCarreau = 40;
  int departX = 500;
  int departY = 10;
  int finX = 660;
  int finY = 410;
  int epaisseurCarreau = 1;

  int boutonX=320; 
  int boutonY=320;

  // METHODES //

  // DESSINE GRILLE
  void dessinerGrille() {
    for (int i = departX; i < finX; i+=tailleCarreau) {
      for (int j = departY; j < finY; j+=tailleCarreau) {
        stroke(0, 0, 255);
        strokeWeight(epaisseurCarreau);
        fill(255);
        rect(i, departY+j, tailleCarreau, tailleCarreau);
        fill(236, 239, 241);
        rect(finX, departY+j, 70, tailleCarreau);
      }
    }
  }

  // DESSINE BOUTON D'ENVOI
  void dessiner_bouton_envoi() {
    noStroke();
    fill(jaune);
    rect(boutonX, boutonY, 150, 100, 7);
    fill(255);
    textSize(30);
    text("ENTRER", boutonX+(150/8), boutonY+(100/2));
  }

  // DESSINE BOUTON NOUVELLE PARTIE
  void afficherNouvellepartie() {
    noStroke();
    fill(jaune);
    rect(50, 380, 150, 100, 7);
    fill(255);
    textSize(30);
    text("Nouvelle\n Partie", 50+(150/8), 370+(100/2));
  }
  //AFFICHER REGLE DU JEU
  void afficherBoutonRegle() {
    if (bienPlace==4 || tourJeu==11) {
    } else {
      noStroke();
      fill(blanc);
      textSize(18);
      text ("Pion noir = bien placé\nPion blanc = mal placé", (150/8), 50);
    }
  }
}