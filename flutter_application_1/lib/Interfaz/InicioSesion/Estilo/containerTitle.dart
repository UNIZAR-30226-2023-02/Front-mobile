import 'package:flutter/material.dart';

class ContainerTitle extends StatelessWidget {
  final String texto;
  const ContainerTitle(this.texto, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Container(
        alignment: Alignment.topCenter,
        child: Text(
          texto,
          style: const TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFFc9c154),
            fontFamily: "Baskerville",
          ),
        ),
      ),
    );
  }
}
