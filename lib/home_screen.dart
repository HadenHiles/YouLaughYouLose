// ignore_for_file: prefer_const_constructors_in_immutables
import 'package:flutter/material.dart';
import 'package:ylyl/play_game.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: MaterialButton(
            color: Colors.blueAccent,
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            child: const Text(
              'New Game',
              style: TextStyle(fontSize: 22, color: Colors.white),
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
                return const PlayGame();
              }));
            },
          ),
        ),
        const Divider(
          height: 10,
          color: Colors.transparent,
        ),
        Center(
          child: MaterialButton(
            color: Colors.grey,
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            child: const Text(
              'Join Game',
              style: TextStyle(fontSize: 22, color: Colors.white),
            ),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
