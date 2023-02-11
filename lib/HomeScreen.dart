import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MaterialButton(
            child: Text('Start Game'),
            onPressed: () {},
          ),
          MaterialButton(
            child: Text('Join Game'),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
