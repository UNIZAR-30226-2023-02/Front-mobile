import 'package:flutter/material.dart';

class Boton1 extends StatelessWidget {
  final String textContrasenya;
  final VoidCallback onPressed;
  const Boton1(String t, {Key? key, required this.onPressed})
      : textContrasenya = t,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: dead_code
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[Color(0xFFdee8eb), Color(0xFFb0c7d0)],
                  stops: [0.4, 1.0],
                ),
              ),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF004461),
              // padding: const EdgeInsets.all(16.0),
              padding:
                  const EdgeInsets.only(top: 4, bottom: 4, left: 15, right: 15),
              textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontFamily: "Georgia"),
            ),
            onPressed: onPressed,
            child: Text(textContrasenya),
          ),
        ],
      ),
    );
  }
}

class Boton2 extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const Boton2(String t, {Key? key, required this.onPressed})
      : text = t,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: dead_code
    return ClipRRect(
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[Color(0xFFdee8eb), Color(0xFFb0c7d0)],
                  stops: [0.4, 1.0],
                ),
              ),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF004461),
              // padding: const EdgeInsets.all(16.0),
              padding:
                  const EdgeInsets.only(top: 4, bottom: 4, left: 15, right: 15),
              textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontFamily: "Georgia"),
            ),
            onPressed: onPressed,
            child: Text(text),
          ),
        ],
      ),
    );
  }
}
class BotonHome extends StatelessWidget {
  final String textContrasenya;
  final VoidCallback onPressed;
  const BotonHome(String t, {Key? key, required this.onPressed})
      : textContrasenya = t,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: dead_code
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[Color(0xFFdee8eb), Color(0xFFb0c7d0)],
                  stops: [0.4, 1.0],
                ),
              ),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF004461),
              // padding: const EdgeInsets.all(16.0),
              padding:
                  const EdgeInsets.only(top: 4, bottom: 4, left: 30, right: 30),
              textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontFamily: "Georgia"),
            ),
            onPressed: onPressed,
            child: Text(textContrasenya),
          ),
        ],
      ),
    );
  }
}
