import 'package:flutter/material.dart';

class Dentro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Otra pantalla'),
      ),
      body: Center(
        child: Text('Esta es otra pantalla'),
      ),
    );
  }
}
