import 'package:flutter/material.dart';

class ContainerTitle extends StatelessWidget {
  String texto;
  ContainerTitle(this.texto, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(16.0),
      child: Text(
        texto,
        style: const TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          color: Color(0xFFc9c154),
          fontFamily: "Baskerville",
        ),
      ),
    );
  }
}
