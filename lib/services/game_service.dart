import 'dart:js_interop';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:random_string/random_string.dart';
import 'package:ylyl/models/current_game.dart';
import 'package:ylyl/models/firestore/game.dart';
import 'package:ylyl/models/firestore/player.dart';

Future<Player> newPlayer(String? name) {
  Player player = Player(name!);

  return FirebaseFirestore.instance.collection('players').doc().get().then((snapshot) {
    if (!snapshot.exists) {
      player.id = snapshot.id;
      player.reference = snapshot.reference;
      snapshot.reference.set(player.toMap());
    }
    return player;
  });
}

Future<void> updatePlayer(Player player) async {
  player.reference!.set(player.toMap());
}

Future<Game?> newGame(String? playerName) async {
  String code = randomAlpha(5).toUpperCase();

  if (playerName!.isNotEmpty) {
    return await newPlayer(playerName).then((p) async {
      return await startGame(code, p);
    });
  } else {
    return await startGame(code, null);
  }
}

Future<Game?> startGame(String? code, Player? player1) async {
  code = code!.isNotEmpty ? code : randomAlpha(5).toUpperCase();
  // Shared preferences (local cache)
  CurrentGameCode currentGame = CurrentGameCode();
  currentGame.save(code);

  return await FirebaseFirestore.instance.collection('games').doc().get().then((snapshot) async {
    if (!snapshot.exists) {
      Game game = Game(code!, 'lobby', [], 1, []);
      if (!player1.isNull) {
        game.players!.add(player1!);
      }

      await FirebaseFirestore.instance.collection('games').doc(snapshot.id).set(game.toMap());
      return game;
    }

    return null;
  });
}

Future<Game?> getGame(String code) async {
  return await FirebaseFirestore.instance.collection('games').where('code', isEqualTo: code).limit(1).get().then((snapshot) {
    if (snapshot.docs.isNotEmpty) {
      return Game.fromSnapshot(snapshot.docs[0]);
    }

    return null;
  });
}
