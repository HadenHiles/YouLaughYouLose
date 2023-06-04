import 'package:cloud_firestore/cloud_firestore.dart';

class Player {
  String? id;
  final String name;
  DocumentReference? reference;

  Player(this.name);

  Player.fromMap(Map<String, dynamic>? map, {this.reference})
      : assert(map!['date'] != null),
        assert(map!['type'] != null),
        assert(map!['count'] != null),
        id = map!['id'],
        name = map['name'];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  Player.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) : this.fromMap(snapshot.data(), reference: snapshot.reference);
}
