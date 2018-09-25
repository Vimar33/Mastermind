class Pions {
  int indice;
  Integer code_couleur;
  color couleurPion;
  int taille = 20;
  int x;
  int y;

  //Constructeur
  Pions(int px, int py, color couleur) {
    couleurPion = couleur;
    this.x = px;
    this.y = py;
   
// ATTRIBUE CODE COULEUR A COULEUR DE PION
    if (this.couleurPion==vert) {
      this.code_couleur=0;
    }
    if (this.couleurPion==rouge) {
      this.code_couleur=1;
    }
    if (this.couleurPion==bleu) {
      this.code_couleur=2;
    }
    if (this.couleurPion==violet) {
      this.code_couleur=3;
    }
    if (this.couleurPion==jaune) {
      this.code_couleur=4;
    }
    if (this.couleurPion==orange) {
      this.code_couleur=5;
    }
    if (this.couleurPion==rose) {
      this.code_couleur=6;
    }
    if (this.couleurPion==marron) {
      this.code_couleur=7;
    }
  }
}