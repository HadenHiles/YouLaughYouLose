import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ylyl/home_screen.dart';
// import 'package:ylyl/services/bootstrap.dart';

const firebaseConfig = FirebaseOptions(
  apiKey: "AIzaSyC3ayfGqwZb-6vICGswSQA702UseURZgpA",
  authDomain: "ylyl-youlaughyoulose.firebaseapp.com",
  projectId: "ylyl-youlaughyoulose",
  storageBucket: "ylyl-youlaughyoulose.appspot.com",
  messagingSenderId: "625378474529",
  appId: "1:625378474529:web:9eccee761dc0ed16e30160",
);

void main() {
  Firebase.initializeApp(options: firebaseConfig);
  runApp(const YLYL());
  // bootstrap();
}

class YLYL extends StatelessWidget {
  const YLYL({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Straight Face',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.deepPurple,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: const Text('Straight Face'),
          centerTitle: true,
        ),
        body: const HomeScreen(),
      ),
    );
  }
}
