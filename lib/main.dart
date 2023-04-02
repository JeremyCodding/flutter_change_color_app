import 'package:flutter/material.dart';
import 'package:flutter_project/screens/home_screen.dart';
import 'package:flutter_project/screens/info_screen.dart';
import 'package:flutter_project/screens/task_screen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/info': (context) => InfoScreen(),
        '/task': (context) => TasksScreen(),
      },
    );
  }
}




