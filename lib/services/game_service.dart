import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:random_string/random_string.dart';
import 'package:ylyl/models/firestore/game.dart';
import 'package:ylyl/models/firestore/player.dart';

Future<Player> newPlayer(String name) {
  Player player = Player(name);

  return FirebaseFirestore.instance.collection('players').doc().get().then((snapshot) {
    if (!snapshot.exists) {
      FirebaseFirestore.instance.collection('players').doc().set(player.toMap());
    }
    return player;
  });
}

Future<Game> startGame(String owner) {
  String code = randomAlpha(5);
  return FirebaseFirestore.instance.collection('games').doc().get().then((snapshot) {
    if (!snapshot.exists) {
      Game game = Game(code, 'writing', [], 1, owner, []);
      FirebaseFirestore.instance.collection('games').doc(snapshot.id).set(game.toMap());

      return game;
    }

    return null;
  });
}

Future<Game> getGame(String code) {
  return FirebaseFirestore.instance.collection('games').where('code', isEqualTo: code).limit(1).get().then((snapshot) {
    if (snapshot.docs.isNotEmpty) {
      return Game.fromSnapshot(snapshot.docs[0]);
    }

    return null;
  });
}
