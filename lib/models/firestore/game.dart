import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ylyl/models/firestore/joke.dart';
import 'package:ylyl/models/firestore/player.dart';

class Game {
  String? id;
  final String code;
  final String status;
  final List<Joke> jokes;
  final int round;
  final String owner;
  List<Player>? players;
  DocumentReference? reference;

  Game(this.code, this.status, this.jokes, this.round, this.owner, this.players);

  Game.fromMap(Map<String, dynamic>? map, {required this.reference})
      : assert(map!['code'] != null),
        assert(map!['status'] != null),
        assert(map!['owner'] != null),
        id = map!['id'],
        code = map['code'],
        status = map['status'],
        round = map['round'],
        owner = map['owner'],
        jokes = map['jokes'];

  Map<String, dynamic> toMap() {
    List<Map<String, dynamic>> plrs = [];
    for (var p in players!) {
      plrs.add(p.toMap());
    }

    List<Map<String, dynamic>> jks = [];
    for (var j in jokes) {
      jks.add(j.toMap());
    }

    return {
      'id': id,
      'code': code,
      'name': status,
      'owner': owner,
      'players': plrs,
      'jokes': jokes,
      'round': round,
    };
  }

  Game.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) : this.fromMap(snapshot.data(), reference: snapshot.reference);
}
