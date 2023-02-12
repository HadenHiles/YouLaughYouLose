import 'package:flutter/material.dart';
import 'package:ylyl/play_game.dart';
import 'package:ylyl/services/game_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _playerNameFieldController = TextEditingController();
  String _playerId;
  String _playerName;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        MaterialButton(
          child: const Text('Start Game'),
          onPressed: _startGame,
        ),
        MaterialButton(
          child: const Text('Join Game'),
          onPressed: () {},
        ),
      ],
    );
  }

  void _startGame() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Enter your name'),
          content: TextField(
            onChanged: (value) {
              setState(() {
                _playerName = value;
              });
            },
            controller: _playerNameFieldController,
            decoration: const InputDecoration(hintText: "Enter your name, fuckwit."),
          ),
          actions: [
            ElevatedButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              child: const Text('GO YO'),
              onPressed: () {
                Navigator.pop(context);

                newPlayer(_playerName).then((p) => () {
                      setState(() {
                        _playerId = p.id;
                      });

                      startGame(_playerId).then((g) => () {
                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                              builder: (BuildContext context) {
                                return PlayGame(
                                  code: g.code,
                                );
                              },
                            ));
                          });
                    });
              },
            ),
          ],
        );
      },
    );
  }
}
