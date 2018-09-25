class Evaluation {

  int tourJeu;
  Integer code_couleur;
  color couleurEvalJ;
  int tailleEval = 5;
  int x;
  int y;

  //Constructeur
  Evaluation(int px, int py, color couleur) {
    couleurEvalJ = couleur;
    this.x = px;
    this.y = py;

    if (this.couleurEvalJ==blanc) {
      this.code_couleur=8;
    }
    if (this.couleurEvalJ==noir) {
      this.code_couleur=9;
    }
  }
}