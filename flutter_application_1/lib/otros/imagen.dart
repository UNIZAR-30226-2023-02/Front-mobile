import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My App'),
      ),
      body: Center(
        child: Column (
          children: [
            Image.asset('assets/images/marciano.png'),
          ],
        ),
      ),
    );
  }
}