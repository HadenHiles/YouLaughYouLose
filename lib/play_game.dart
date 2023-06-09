import 'dart:js_interop';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ylyl/models/current_game.dart';
import 'package:ylyl/models/firestore/game.dart';
import 'package:ylyl/models/firestore/player.dart';
import 'package:ylyl/services/game_service.dart';

class PlayGame extends StatefulWidget {
  const PlayGame({Key? key}) : super(key: key);

  @override
  State<PlayGame> createState() => _PlayGameState();
}

class _PlayGameState extends State<PlayGame> {
  final TextEditingController _playerNameFieldController = TextEditingController();
  Player? _player = Player("Player 1");
  Game? _game;

  @override
  void initState() {
    super.initState();

    _playerNameFieldController.value = TextEditingValue(text: _player!.name);

    CurrentGameCode cGame = CurrentGameCode();

    if (cGame.get().isNull) {
      _startGame();
    } else {
      // _loadGame();
      // _joinGame();
    }
  }

  void _startGame() {
    newGame(_player!.name).then((g) {
      setState(() {
        _game = g;
        _player = g!.players![0];
      });
    });
  }

  void _loadGame(Game g) async {
    await getGame(g.code).then((game) => () {
          setState(() {
            _game = game;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text('Straight Face'),
        centerTitle: true,
      ),
      body: _game.isNull
          ? const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: CircularProgressIndicator(backgroundColor: Colors.blueAccent),
                ),
              ],
            )
          : Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    "Game Code: ${_game!.code}",
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        _player!.setName(value);
                      });

                      updatePlayer(_player!);
                    },
                    controller: _playerNameFieldController,
                    decoration: const InputDecoration(hintText: "This is your name, fuckwit."),
                  ),
                  // Determine what stage the game is at and display the appropriate UI
                  _buildGame(),
                ],
              ),
            ),
    );
  }

  Widget _buildGame() {
    switch (_game!.status) {
      case "lobby":
        return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          // inside the <> you enter the type of your stream
          stream: FirebaseFirestore.instance.collection("games").where('code', isEqualTo: _game!.code).limit(1).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Game game = Game.fromSnapshot(snapshot.data!.docs[0]);
              List<Player> players = [];

              for (Player player in game.players!) {
                FirebaseFirestore.instance.collection("players").doc(player.id).get().then((p) {
                  players.add(Player.fromSnapshot(p));
                });
              }

              return ListView.builder(
                itemCount: players.length,
                itemBuilder: (context, i) {
                  return ListTile(
                    title: Text(
                      players[i].name,
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return const Text('Error');
            } else {
              return const CircularProgressIndicator();
            }
          },
        );
      case "writing":
        return const Column(
          children: [
            Text("Writing"),
          ],
        );
      case "reading":
        return const Column(
          children: [
            Text("Reading"),
          ],
        );
      default:
        return const Column(
          children: [
            Text('Unknown Game Status'),
          ],
        );
    }
  }
}
