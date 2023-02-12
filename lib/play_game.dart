import 'package:flutter/material.dart';
import 'package:ylyl/models/firestore/game.dart';
import 'package:ylyl/services/game_service.dart';

class PlayGame extends StatefulWidget {
  const PlayGame({Key key, this.code}) : super(key: key);

  final String code;

  @override
  State<PlayGame> createState() => _PlayGameState();
}

class _PlayGameState extends State<PlayGame> {
  Game _game;

  @override
  void initState() async {
    super.initState();
    getGame(widget.code).then((g) => () {
          setState(() {
            _game = g;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _game.status == "writing"
          ? Column(
              children: const [
                Center(
                  child: Text("Game playing - writing"),
                )
              ],
            )
          : Column(
              children: const [
                Center(
                  child: Text("Game playing - reading"),
                ),
              ],
            ),
    );
  }
}
