import 'dart:math' show Random;
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _random = Random();
  Color _currentColor = Colors.white;

  void _changeColor() {
    setState(() {
      _currentColor = Color.fromARGB(
        255,
        _random.nextInt(256),
        _random.nextInt(256),
        _random.nextInt(256),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              Navigator.pushNamed(context, '/info');
            },
          ),
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              Navigator.pushNamed(context, '/task');
            },
          ),
        ],
      ),
      body: GestureDetector(
        onTap: _changeColor,
        child: Container(
          color: _currentColor,
          child: const  Center(
            child: Text(
              'Hello there!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
