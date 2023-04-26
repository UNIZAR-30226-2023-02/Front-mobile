import 'dart:math';

import 'package:flutter/material.dart';

class Juego extends StatelessWidget {
  const Juego({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _Juego(),
    );
  }
}

class _Juego extends StatefulWidget {
  @override
  __JuegoState createState() => __JuegoState();
}

class __JuegoState extends State<_Juego> {
  Color Bcolor1 = Colors.blue;
  Color Bcolor2 = Color.fromARGB(255, 255, 187, 0);
  Color Bcolor3 = Color.fromARGB(255, 255, 255, 255);

  void _cambiarColor2() {
    setState(() {
      Bcolor2 = Colors.green;
    });
  }
  void _cambiarColor1() {
    setState(() {
      Bcolor1 = Colors.green;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/tapete.png'), fit: BoxFit.fill),
          ),
          child: Stack(
            children: [
              //CHexagono
              Transform.translate(
                offset: const Offset(0, 0),
                child: HexagonButton(
                  color: Bcolor1,
                  onPressed: () {
                    _cambiarColor2();
                  },
                ),
              ),
              //C1
              Transform.rotate(
                angle: -27 * pi / 180,
                child: Transform.translate(
                  offset: const Offset(19, 66),
                  child: RectangleButton(
                    color: Bcolor2,
                    onPressed: () {
                      _cambiarColor2();
                    },
                  ),
                ),
              ),
              //C2
              Transform.rotate(
                angle: -27 * pi / 180,
                child: Transform.translate(
                  offset: const Offset(19, 87),
                  child: RectangleButton(
                    color: Bcolor1,
                    onPressed: () {
                      _cambiarColor2();
                    },
                  ),
                ),
              ),
              //C3
              Transform.rotate(
                angle: -27 * pi / 180,
                child: Transform.translate(
                  offset: const Offset(19, 108),
                  child: RectangleButton(
                    color: Bcolor2,
                    onPressed: () {
                      _cambiarColor2();
                    },
                  ),
                ),
              ),
              //C4
              Transform.rotate(
                angle: -27 * pi / 180,
                child: Transform.translate(
                  offset: const Offset(19, 129),
                  child: RectangleButton(
                    color: Bcolor1,
                    onPressed: () {
                      _cambiarColor2();
                    },
                  ),
                ),
              ),
              //C5
              Transform.rotate(
                angle: -27 * pi / 180,
                child: Transform.translate(
                  offset: const Offset(19, 150),
                  child: RectangleButton(
                    color: Bcolor2,
                    onPressed: () {
                      _cambiarColor2();
                    },
                  ),
                ),
              ),
              //C66
              Transform.rotate(
                angle: -154 * pi / 180,
                child: Transform.translate(
                  offset: const Offset(18, -17),
                  child: RectangleButton(
                    color: Bcolor2,
                    onPressed: () {
                      _cambiarColor2();
                    },
                  ),
                ),
              ),
              //C65
              Transform.rotate(
                angle: -154 * pi / 180,
                child: Transform.translate(
                  offset: const Offset(18, -37),
                  child: RectangleButton(
                    color: Bcolor1,
                    onPressed: () {
                      _cambiarColor2();
                    },
                  ),
                ),
              ),
              //C64
              Transform.rotate(
                angle: -154 * pi / 180,
                child: Transform.translate(
                  offset: const Offset(18, -57),
                  child: RectangleButton(
                    color: Bcolor2,
                    onPressed: () {
                      _cambiarColor2();
                    },
                  ),
                ),
              ),
              //C63
              Transform.rotate(
                angle: -154 * pi / 180,
                child: Transform.translate(
                  offset: const Offset(18, -77),
                  child: RectangleButton(
                    color: Bcolor1,
                    onPressed: () {
                      _cambiarColor2();
                    },
                  ),
                ),
              ),
              //C62
              Transform.rotate(
                angle: -154 * pi / 180,
                child: Transform.translate(
                  offset: const Offset(18, -98),
                  child: RectangleButton(
                    color: Bcolor2,
                    onPressed: () {
                      _cambiarColor2();
                    },
                  ),
                ),
              ),

              //C72
              Transform.rotate(
                angle: -90 * pi / 180,
                child: Transform.translate(
                  offset: const Offset(-150, 75),
                  child: RectangleButton(
                    color: Bcolor2,
                    onPressed: () {
                      _cambiarColor2();
                    },
                  ),
                ),
              ),
              //C71
              Transform.rotate(
                angle: -90 * pi / 180,
                child: Transform.translate(
                  offset: const Offset(-150, 55),
                  child: RectangleButton(
                    color: Bcolor1,
                    onPressed: () {
                      _cambiarColor2();
                    },
                  ),
                ),
              ),
              //C70
              Transform.rotate(
                angle: -90 * pi / 180,
                child: Transform.translate(
                  offset: const Offset(-150, 35),
                  child: RectangleButton(
                    color: Bcolor2,
                    onPressed: () {
                      _cambiarColor2();
                    },
                  ),
                ),
              ),
              //C69
              Transform.rotate(
                angle: -90 * pi / 180,
                child: Transform.translate(
                  offset: const Offset(-150, 15),
                  child: RectangleButton(
                    color: Bcolor1,
                    onPressed: () {
                      _cambiarColor2();
                    },
                  ),
                ),
              ),
              //C68
              Transform.rotate(
                angle: -90 * pi / 180,
                child: Transform.translate(
                  offset: const Offset(-150, -5),
                  child: RectangleButton(
                    color: Bcolor2,
                    onPressed: () {
                      _cambiarColor2();
                    },
                  ),
                ),
              ),
              //C67
              Transform.rotate(
                angle: -90 * pi / 180,
                child: Transform.translate(
                  offset: const Offset(-150, -25),
                  child: RectangleButton(
                    color: Bcolor1,
                    onPressed: () {
                      _cambiarColor2();
                    },
                  ),
                ),
              ),
              //C7
              Transform.rotate(
                angle: -148 * pi / 180,
                child: Transform.translate(
                  offset: const Offset(-142, -23),
                  child: RectangleButton(
                    color: Bcolor1,
                    onPressed: () {
                      _cambiarColor2();
                    },
                  ),
                ),
              ),
              //C8
              Transform.rotate(
                angle: -148 * pi / 180,
                child: Transform.translate(
                  offset: const Offset(-142, -5),
                  child: RectangleButton(
                    color: Bcolor2,
                    onPressed: () {
                      _cambiarColor2();
                    },
                  ),
                ),
              ),
              //C9
              Transform.rotate(
                angle: -148 * pi / 180,
                child: Transform.translate(
                  offset: const Offset(-142, 15),
                  child: RectangleButton(
                    color: Bcolor1,
                    onPressed: () {
                      _cambiarColor2();
                    },
                  ),
                ),
              ),
              //C10
              Transform.rotate(
                angle: -148 * pi / 180,
                child: Transform.translate(
                  offset: const Offset(-142, 35),
                  child: RectangleButton(
                    color: Bcolor2,
                    onPressed: () {
                      _cambiarColor2();
                    },
                  ),
                ),
              ),
              //C11
              Transform.rotate(
                angle: -148 * pi / 180,
                child: Transform.translate(
                  offset: const Offset(-142, 55),
                  child: RectangleButton(
                    color: Bcolor1,
                    onPressed: () {
                      _cambiarColor2();
                    },
                  ),
                ),
              ),
              //C12
              Transform.rotate(
                angle: -148 * pi / 180,
                child: Transform.translate(
                  offset: const Offset(-142, 75),
                  child: RectangleButton(
                    color: Bcolor2,
                    onPressed: () {
                      _cambiarColor2();
                    },
                  ),
                ),
              ),
              //C13
              Transform.rotate(
                angle: -270 * pi / 180,
                child: Transform.translate(
                  offset: const Offset(26, -135),
                  child: EsquinaButton(
                    color: Bcolor3,
                    onPressed: () {
                      _cambiarColor2();
                    },
                  ),
                ),
              ),
              //C49
              Transform.rotate(
                angle: 270 * pi / 180,
                child: Transform.translate(
                  offset: const Offset(0, -184),
                  child: EsquinaButton(
                    color: Bcolor3,
                    onPressed: () {
                      _cambiarColor2();
                    },
                  ),
                ),
              ),
              //C6
              Transform.rotate(
                angle: -207 * pi / 180,
                child: Transform.translate(
                  offset: const Offset(37, -158),
                  child: Esquina2Button(
                    color: Bcolor3,
                    onPressed: () {
                      _cambiarColor2();
                    },
                  ),
                ),
              ),
              //C18
              Transform.rotate(
                angle: -90 * pi / 180,
                child: Transform.translate(
                  offset: const Offset(13, 70),
                  child: RectangleButton(
                    color: Bcolor2,
                    onPressed: () {
                      _cambiarColor2();
                    },
                  ),
                ),
              ),
              //C17
              Transform.rotate(
                angle: -90 * pi / 180,
                child: Transform.translate(
                  offset: const Offset(13, 91),
                  child: RectangleButton(
                    color: Bcolor1,
                    onPressed: () {
                      _cambiarColor2();
                    },
                  ),
                ),
              ),
              //C16
              Transform.rotate(
                angle: -90 * pi / 180,
                child: Transform.translate(
                  offset: const Offset(13, 111),
                  child: RectangleButton(
                    color: Bcolor2,
                    onPressed: () {
                      _cambiarColor2();
                    },
                  ),
                ),
              ),
              //C15
              Transform.rotate(
                angle: -90 * pi / 180,
                child: Transform.translate(
                  offset: const Offset(13, 131),
                  child: RectangleButton(
                    color: Bcolor1,
                    onPressed: () {
                      _cambiarColor2();
                    },
                  ),
                ),
              ),
              //C14
              Transform.rotate(
                angle: -90 * pi / 180,
                child: Transform.translate(
                  offset: const Offset(13, 151),
                  child: RectangleButton(
                    color: Bcolor2,
                    onPressed: () {
                      _cambiarColor2();
                    },
                  ),
                ),
              ),
              //C54
              Transform.rotate(
                angle: -90 * pi / 180,
                child: Transform.translate(
                  offset: const Offset(13, -20),
                  child: RectangleButton(
                    color: Bcolor2,
                    onPressed: () {
                      _cambiarColor2();
                    },
                  ),
                ),
              ),
              //C53
              Transform.rotate(
                angle: -90 * pi / 180,
                child: Transform.translate(
                  offset: const Offset(13, -40),
                  child: RectangleButton(
                    color: Bcolor1,
                    onPressed: () {
                      _cambiarColor2();
                    },
                  ),
                ),
              ),
              //C52
              Transform.rotate(
                angle: -90 * pi / 180,
                child: Transform.translate(
                  offset: const Offset(13, -60),
                  child: RectangleButton(
                    color: Bcolor2,
                    onPressed: () {
                      _cambiarColor2();
                    },
                  ),
                ),
              ),
              //C51
              Transform.rotate(
                angle: -90 * pi / 180,
                child: Transform.translate(
                  offset: const Offset(13, -80),
                  child: RectangleButton(
                    color: Bcolor1,
                    onPressed: () {
                      _cambiarColor2();
                    },
                  ),
                ),
              ),
              //C50
              Transform.rotate(
                angle: -90 * pi / 180,
                child: Transform.translate(
                  offset: const Offset(13, -100),
                  child: RectangleButton(
                    color: Bcolor2,
                    onPressed: () {
                      _cambiarColor2();
                    },
                  ),
                ),
              ),

              //C60
              Transform.rotate(
                angle: 330 * pi / 180,
                child: Transform.translate(
                  offset: const Offset(-148, 88),
                  child: RectangleButton(
                    color: Bcolor1,
                    onPressed: () {
                      _cambiarColor2();
                    },
                  ),
                ),
              ),
              //C59
              Transform.rotate(
                angle: 330 * pi / 180,
                child: Transform.translate(
                  offset: const Offset(-148, 68),
                  child: RectangleButton(
                    color: Bcolor2,
                    onPressed: () {
                      _cambiarColor2();
                    },
                  ),
                ),
              ),
              //C58
              Transform.rotate(
                angle: 330 * pi / 180,
                child: Transform.translate(
                  offset: const Offset(-148, 48),
                  child: RectangleButton(
                    color: Bcolor1,
                    onPressed: () {
                      _cambiarColor2();
                    },
                  ),
                ),
              ),
              //C57
              Transform.rotate(
                angle: 330 * pi / 180,
                child: Transform.translate(
                  offset: const Offset(-148, 28),
                  child: RectangleButton(
                    color: Bcolor2,
                    onPressed: () {
                      _cambiarColor2();
                    },
                  ),
                ),
              ),
              //C56
              Transform.rotate(
                angle: 330 * pi / 180,
                child: Transform.translate(
                  offset: const Offset(-148, 8),
                  child: RectangleButton(
                    color: Bcolor1,
                    onPressed: () {
                      _cambiarColor2();
                    },
                  ),
                ),
              ),
              //C55
              Transform.rotate(
                angle: 330 * pi / 180,
                child: Transform.translate(
                  offset: const Offset(-148, -13),
                  child: RectangleButton(
                    color: Bcolor2,
                    onPressed: () {
                      _cambiarColor2();
                    },
                  ),
                ),
              ),
              //C61
              Transform.rotate(
                angle: 207 * pi / 180,
                child: Transform.translate(
                  offset: const Offset(30, -178),
                  child: Esquina3Button(
                    color: Bcolor3,
                    onPressed: () {
                      _cambiarColor2();
                    },
                  ),
                ),
              ),
              
            ],
          ),
        ),
    );
  }
}

class _HexagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final double w = size.width;
    final double h = size.height;
    // path.moveTo(size.width * 0.5, 0); //centro arriba (linea arriba izquierda)
    // path.lineTo(size.width * 0.5, 0); //centro arriba (linea arriba derecha)
    // path.lineTo(size.width, size.height * 0.4); //punto derecho
    // path.lineTo(size.width * 0.8, size.height); //abajo derecha
    // path.lineTo(size.width * 0.2, size.height); //abajo izquierda 
    // path.lineTo(size.width * 0, size.height * 0.4); //punto izquierdo


    path.moveTo(w * 0.5, 0);
    path.lineTo(w, h * 0.25);
    path.lineTo(w, h * 0.75);
    path.lineTo(w * 0.5, h);
    path.lineTo(0, h * 0.75);
    path.lineTo(0, h * 0.25);


    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class _RectangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final double w = size.width;
    final double h = size.height;

    path.moveTo(0, 0);
    path.lineTo(w * 0.56, 0);
    path.lineTo(w * 0.56, h * 0.3);
    path.lineTo(0, h * 0.3);


    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class _EsquinaClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final double w = size.width;
    final double h = size.height;

    path.moveTo(0.25 * w, 0);
    path.lineTo(0.75 * w, 0);
    // path.lineTo(w, 0.5 * h);
    // path.lineTo(w, 0.7 * h);
    path.lineTo(0.55 * w, h);
    // path.lineTo(0.25 * w, h);
    path.lineTo(28, h);
    path.lineTo(-28, -50);  //arriba izq
    path.close();

    // path.moveTo(10,20);
    // path.lineTo(size.width * 0.2, 0);
    // path.lineTo(size.width * 0.8, 0);
    // path.lineTo(size.width, size.height);
    // path.lineTo(0, size.height);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class _Esquina2Clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final double w = size.width;
    final double h = size.height;

    path.moveTo(0.25 * w, 0);
    path.lineTo(1 * w, -300);
    path.lineTo(0.55 * w, h);
    path.lineTo(30, h +8);
    path.lineTo(-19, -60);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class _Esquina3Clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final double w = size.width;
    final double h = size.height;

    path.moveTo(0.25 * w, 0);
    path.lineTo(w, -130);
    path.lineTo(0.55 * w, h);
    path.lineTo(35, h + 8);
    path.lineTo(-19, -200);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
/////////////////////////////////////////////////////////
class HexagonButton extends StatelessWidget {
  final Color color;
  final VoidCallback onPressed;

  const HexagonButton({
    Key? key,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: ClipPath(
        clipper: _HexagonClipper(),
        child: Container(
          width: 70,
          height: 70,
          color: color,
        ),
      ),
    );
  }
}

class RectangleButton extends StatelessWidget {
  final Color color;
  final VoidCallback onPressed;

  const RectangleButton({
    Key? key,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: ClipPath(
        clipper: _RectangleClipper(),
        child: Container(
          width: 70,
          height: 70,
          color: color,
        ),
      ),
    );
  }
}

class EsquinaButton extends StatelessWidget {
  final Color color;
  final VoidCallback onPressed;

  const EsquinaButton({
    Key? key,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: ClipPath(
        clipper: _EsquinaClipper(),
        child: Container(
          width: 120,
          height: 48,
          color: color,
        ),
      ),
    );
  }
}

class Esquina2Button extends StatelessWidget {
  final Color color;
  final VoidCallback onPressed;

  const Esquina2Button({
    Key? key,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: ClipPath(
        clipper: _Esquina2Clipper(),
        child: Container(
          width: 120,
          height: 55,
          color: color,
        ),
      ),
    );
  }
}

class Esquina3Button extends StatelessWidget {
  final Color color;
  final VoidCallback onPressed;

  const Esquina3Button({
    Key? key,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: ClipPath(
        clipper: _Esquina3Clipper(),
        child: Container(
          width: 120,
          height: 60,
          color: color,
        ),
      ),
    );
  }
}
/////////////////////////////////////////////////////////