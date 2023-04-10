import 'dart:math';

import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _Menu(),
    );
  }
}

class _Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            Container(
              //alignment: Alignment.center,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/tapete.png'), fit: BoxFit.fill),
              ),
            ),
            Center(
              child: Transform.translate(
                offset: Offset(7.5, 15), // ajusta los valores de desplazamiento
                child: Transform.scale(
                  scale: 1.1,
                  child: Image.asset('assets/menu_trivial.png'),
                ),
              ),
            ),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Transform.rotate(
                        angle: -244 * pi / 180,
                        child: TriangleButton(
                          color: Color.fromARGB(0, 233, 30, 148),
                          //onPressed: () => showMessage(context, 'Rosa'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                transitionDuration: Duration(
                                    milliseconds:
                                        100), // La duración de la transición
                                pageBuilder: (context, animation,
                                        secondaryAnimation) =>
                                    PulsaMenu(
                                        imagen: 'assets/menu_trivial_rosa.png'),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      Transform.rotate(
                        angle: -296 * pi / 180,
                        child: TriangleButton(
                          color: Color.fromARGB(0, 231, 40, 26),
                          //onPressed: () => showMessage(context, 'Rojo'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                transitionDuration: Duration(
                                    milliseconds:
                                        100), // La duración de la transición
                                pageBuilder: (context, animation,
                                        secondaryAnimation) =>
                                    PulsaMenu(
                                        imagen: 'assets/menu_trivial_rojo.png'),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Transform.rotate(
                        angle: pi,
                        child: TriangleButton(
                          color: Color.fromARGB(0, 33, 149, 243),
                          //onPressed: () => showMessage(context, 'Azul'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                transitionDuration: Duration(
                                    milliseconds:
                                        100), // La duración de la transición
                                pageBuilder: (context, animation,
                                        secondaryAnimation) =>
                                    PulsaMenu(
                                        imagen: 'assets/menu_trivial_azul.png'),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 0, width: 0),
                      CircleButton(
                        color: Color.fromARGB(0, 0, 0, 0),
                        //onPressed: () => showMessage(context, 'Blanco'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration: Duration(
                                  milliseconds:
                                      100), // La duración de la transición
                              pageBuilder: (context, animation,
                                      secondaryAnimation) =>
                                  PulsaMenu(
                                      imagen: 'assets/menu_trivial_blanco.png'),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 0),
                      TriangleButton(
                        color: Color.fromARGB(0, 255, 153, 0),
                        // onPressed: () => showMessage(context, 'Naranja'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration: Duration(
                                  milliseconds:
                                      100), // La duración de la transición
                              pageBuilder: (context, animation,
                                      secondaryAnimation) =>
                                  PulsaMenu(
                                      imagen:
                                          'assets/menu_trivial_naranja.png'),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 0),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 0),
                      Transform.rotate(
                        angle: 244 * pi / 180,
                        child: TriangleButtonAMARILLO(
                          color: Color.fromARGB(0, 255, 235, 59),
                          // onPressed: () => showMessage(context, 'Amarillo'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                transitionDuration: Duration(
                                    milliseconds:
                                        100), // La duración de la transición
                                pageBuilder: (context, animation,
                                        secondaryAnimation) =>
                                    PulsaMenu(
                                        imagen:
                                            'assets/menu_trivial_amarillo.png'),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 0),
                      Transform.rotate(
                        angle: 296 * pi / 180,
                        child: TriangleButtonVERDE(
                          color: Color.fromARGB(0, 76, 175, 79),
                          // onPressed: () => showMessage(context, 'Verde'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                transitionDuration: Duration(
                                    milliseconds:
                                        100), // La duración de la transición
                                pageBuilder: (context, animation,
                                        secondaryAnimation) =>
                                    PulsaMenu(
                                        imagen:
                                            'assets/menu_trivial_verde.png'),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showMessage(BuildContext context, String message) {
    final snackBar =
        SnackBar(content: Text('Has pulsado el triángulo $message'));
    //ScaffoldMessenger.of(context).showSnackBar(snackBar);
    print(message);
  }
}

class CircleButton extends StatelessWidget {
  final Color color;
  final VoidCallback onPressed;

  const CircleButton({Key? key, required this.color, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: CustomPaint(
        size: Size(130, 130),
        painter: CirclePainter(color),
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  final Color color;

  CirclePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class TriangleButtonAMARILLO extends StatelessWidget {
  final Color color;
  final VoidCallback onPressed;

  const TriangleButtonAMARILLO(
      {Key? key, required this.color, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: CustomPaint(
        size: Size(70, 70),
        painter: TrianglePainterAMARILLO(color),
      ),
    );
  }
}

//AMARILLO
class TrianglePainterAMARILLO extends CustomPainter {
  final Color color;

  TrianglePainterAMARILLO(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path();
    // path.moveTo(0, size.height);
    // path.lineTo(size.width, size.height);
    // path.lineTo(size.width / 2, 0);
    path.moveTo(-13, size.height - 13);

    path.lineTo(size.width - 52, size.height - 2);
    path.lineTo(size.width - 40, size.height);
    path.lineTo(size.width - 20, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width + 30, size.height - 10);

    path.lineTo(size.width + 52, size.height - 24);
    path.lineTo(size.width + 14, -13);
    path.lineTo(size.width - 5, -2);
    path.lineTo(size.width - 30, 0);
    path.lineTo(size.width - 52, -10);

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(TrianglePainterAMARILLO oldDelegate) {
    return oldDelegate.color != color;
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///
class TriangleButtonVERDE extends StatelessWidget {
  final Color color;
  final VoidCallback onPressed;

  const TriangleButtonVERDE(
      {Key? key, required this.color, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: CustomPaint(
        size: Size(70, 70),
        painter: TrianglePainterVERDE(color),
      ),
    );
  }
}

//VERDE
class TrianglePainterVERDE extends CustomPainter {
  final Color color;

  TrianglePainterVERDE(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path();
    // path.moveTo(0, size.height);
    // path.lineTo(size.width, size.height);
    // path.lineTo(size.width / 2, 0);
    path.moveTo(-55, size.height - 15);

    path.lineTo(size.width - 90, size.height);
    path.lineTo(size.width - 40, size.height + 8);
    path.lineTo(size.width - 20, size.height + 5);

    path.lineTo(size.width + 9, size.height - 5);
    // path.lineTo(size.width + 14, - 13);
    path.lineTo(size.width - 20, -2);
    path.lineTo(size.width - 60, 4);
    path.lineTo(size.width - 84, -8);

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(TrianglePainterVERDE oldDelegate) {
    return oldDelegate.color != color;
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////
class TriangleButton extends StatelessWidget {
  final Color color;
  final VoidCallback onPressed;

  const TriangleButton({Key? key, required this.color, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: CustomPaint(
        size: Size(70, 70),
        painter: TrianglePainter(color),
      ),
    );
  }
}

//AMARILLO
class TrianglePainter extends CustomPainter {
  final Color color;

  TrianglePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path();
    // path.moveTo(0, size.height);
    // path.lineTo(size.width, size.height);
    // path.lineTo(size.width / 2, 0);
    path.moveTo(-13, size.height - 13);

    path.lineTo(size.width - 52, size.height - 2);
    path.lineTo(size.width - 40, size.height);
    path.lineTo(size.width - 20, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width + 30, size.height - 10);

    path.lineTo(size.width + 52, size.height - 24);
    path.lineTo(size.width + 14, -13);
    path.lineTo(size.width - 5, -2);
    path.lineTo(size.width - 30, 0);
    path.lineTo(size.width - 52, -10);

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

//ES PARA QUE CAMBIE EL BOTON DE COLOR PERO PARA ESO HAY QUE CAMBIAR DE PANTALLA
//Y COMO SALE UNA ANIMACION POR DEFECTO PUES YA SE VE QEU CAMBIAS
class PulsaMenu extends StatelessWidget {
  String imagen = "";
  PulsaMenu({required this.imagen});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            Container(
              //alignment: Alignment.center,
              decoration: BoxDecoration(
                image: const DecorationImage(
                    image: AssetImage('assets/tapete.png'), fit: BoxFit.fill),
              ),
            ),
            Center(
              child: Transform.translate(
                offset: Offset(7.5, 15), // ajusta los valores de desplazamiento
                child: Transform.scale(
                  scale: 1.1,
                  child: Image.asset(imagen),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
