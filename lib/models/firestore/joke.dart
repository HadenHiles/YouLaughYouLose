import 'package:cloud_firestore/cloud_firestore.dart';

class Joke {
  String id;
  final String joke;
  bool read;
  DocumentReference reference;

  Joke(this.joke);

  Joke.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['joke'] != null),
        id = map['id'],
        joke = map['joke'];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'joke': joke,
    };
  }

  Joke.fromSnapshot(DocumentSnapshot snapshot) : this.fromMap(snapshot.data(), reference: snapshot.reference);
}
