import "bot.dart";
import "dart:math";
import 'dart:io';
import 'player.dart';
import './NE_PAS_TOUCHER/user_input.dart';

void main(List<String> args) {
  // Création de l'objet Bot
  final Bot bot1 = Bot();
  bot1.Force = 1;
  bot1.Sante = 100;

  String question1 = "Quel est votre pseudo ?";
  final Player p1 = Player();
  p1.sante = 100;
  p1.force = 1;

  // Appel de la fonction de création du pseudo
  p1.pseudo = readText(question1);
  print("Votre pseudo est ${p1.pseudo}");

  while (bot1.Sante > 0 && p1.sante > 0) {
    int nbTour = 0;
    var commencer = Random().nextInt(1);
    if (commencer == 1) {

      print("\n##C'est au joueur de commencer.");

      // Appuyer sur entrée
      print("Appuyez sur entrer pour lancer les dés");
      stdin.readLineSync().toString();

      // Appel de la fonction de lancer de dés pour le joueur
      p1.force = Lancerdes(p1.pseudo, p1.force);
      
      // Applique les dêgats au bot
      bot1.Sante = Attack(p1.force, bot1.Sante, bot1.pseudo);

      // Lancer du bot
      bot1.Force = Lancerdes(bot1.pseudo, bot1.Force);
      // Applique les dêgats au joueur
      p1.sante = Attack(bot1.Force, p1.sante, p1.pseudo);
    }
    else {

      print("\n##C'est au Bot de commencer.");

      // Lancer du bot
      bot1.Force = Lancerdes(bot1.pseudo, bot1.Force);
      // Applique les dêgats au joueur
      p1.sante = Attack(bot1.Force, p1.sante, p1.pseudo);

      // Appuyer sur entrée
      print("Appuyez sur entrer pour lancer les dés");
      stdin.readLineSync().toString();

      // Appel de la fonction de lancer de dés pour le joueur
      p1.force = Lancerdes(p1.pseudo, p1.force);
      
      // Applique les dêgats au bot
      bot1.Sante = Attack(p1.force, bot1.Sante, bot1.pseudo);
    }
    nbTour += 1;
    print(nbTour);
  }

  if (bot1.Sante <= 0) {
  print("Bravo ${p1.pseudo} vous avez gagné !");
  }
  else {
  print("Dommage ${p1.pseudo} c'est perdu...");
  }
}

//Fonction lancer de dés
int Lancerdes(pseudo, force) {
  print("${pseudo} lance les dés...");

  // Valeur aléatoire du lancer
  force = Random().nextInt(6) + 1;
  print(force);
  return force;
}

Attack (attaquant, victime, pseudoVictime) {
  victime -= attaquant;
  print("${pseudoVictime} a ${victime} hp.");
  return victime;
}