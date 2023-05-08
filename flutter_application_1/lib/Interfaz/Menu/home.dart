import 'package:flutter_application_1/Data_types/amigosUsuario.dart';
import 'package:flutter_application_1/Data_types/datosUsuario.dart';
import 'package:flutter_application_1/Interfaz/Menu/Estadisticas/estadisticas.dart';
import 'package:flutter_application_1/Interfaz/Menu/Tienda/tiendaFichas.dart';

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Interfaz/Menu/Perfil/perfil.dart';
import 'package:flutter_application_1/Data_types/sesion.dart';
import 'package:flutter_application_1/API/index.dart';
import 'package:flutter_application_1/Interfaz/Menu/index.dart';

import '../../Data_types/index.dart';
import 'Amigos/amigos.dart';

//ignore: must_be_immutable
class Menu extends StatelessWidget {
  final Sesion _s;
  const Menu(this._s, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return _Menu(_s);
  }
}

//ignore: must_be_immutable
class _Menu extends StatelessWidget {
  final Sesion _s;
  const _Menu(this._s);
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
                offset: const Offset(
                    7.5, 15), // ajusta los valores de desplazamiento
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
                          color: const Color.fromARGB(0, 233, 30, 148),
                          //onPressed: () => showMessage(context, 'Rosa'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                transitionDuration: const Duration(
                                    milliseconds:
                                        100), // La duración de la transición
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        PulsaMenu(
                                  _s,
                                  'assets/menu_trivial_rosa.png',
                                  "Rosa",
                                ),
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
                      const SizedBox(height: 10),
                      Transform.rotate(
                        angle: -296 * pi / 180,
                        child: TriangleButton(
                          color: const Color.fromARGB(0, 231, 40, 26),
                          //onPressed: () => showMessage(context, 'Rojo'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                transitionDuration: const Duration(
                                    milliseconds:
                                        100), // La duración de la transición
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        PulsaMenu(
                                  _s,
                                  'assets/menu_trivial_rojo.png',
                                  "Rojo",
                                ),
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
                          color: const Color.fromARGB(0, 33, 149, 243),
                          //onPressed: () => showMessage(context, 'Azul'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                transitionDuration: const Duration(
                                    milliseconds:
                                        100), // La duración de la transición
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        PulsaMenu(
                                  _s,
                                  'assets/menu_trivial_azul.png',
                                  "Azul",
                                ),
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
                      const SizedBox(height: 0, width: 0),
                      CircleButton(
                        color: const Color.fromARGB(0, 0, 0, 0),
                        //onPressed: () => showMessage(context, 'Blanco'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration: const Duration(
                                  milliseconds:
                                      100), // La duración de la transición
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      PulsaMenu(
                                _s,
                                'assets/menu_trivial_blanco.png',
                                "Blanco",
                              ),
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
                      const SizedBox(height: 0),
                      TriangleButton(
                        color: const Color.fromARGB(0, 255, 153, 0),
                        // onPressed: () => showMessage(context, 'Naranja'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration: const Duration(
                                  milliseconds:
                                      100), // La duración de la transición
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      PulsaMenu(
                                _s,
                                'assets/menu_trivial_naranja.png',
                                "Naranja",
                              ),
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
                      const SizedBox(height: 0),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 0),
                      Transform.rotate(
                        angle: 244 * pi / 180,
                        child: TriangleButtonAMARILLO(
                          color: const Color.fromARGB(0, 255, 235, 59),
                          // onPressed: () => showMessage(context, 'Amarillo'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                transitionDuration: const Duration(
                                    milliseconds:
                                        100), // La duración de la transición
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        PulsaMenu(
                                  _s,
                                  'assets/menu_trivial_amarillo.png',
                                  "Amarillo",
                                ),
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
                      const SizedBox(height: 0),
                      Transform.rotate(
                        angle: 296 * pi / 180,
                        child: TriangleButtonVERDE(
                          color: const Color.fromARGB(0, 76, 175, 79),
                          // onPressed: () => showMessage(context, 'Verde'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                transitionDuration: const Duration(
                                    milliseconds:
                                        100), // La duración de la transición
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        PulsaMenu(
                                  _s,
                                  'assets/menu_trivial_verde.png',
                                  "Verde",
                                ),
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
        size: const Size(130, 130),
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
        size: const Size(70, 70),
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
        size: const Size(70, 70),
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
        size: const Size(70, 70),
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
//ignore: must_be_immutable
class PulsaMenu extends StatelessWidget {
  final Sesion _s;
  String imagen;
  String tipoBoton;
  dynamic datos;
  PulsaMenu(this._s, this.imagen, this.tipoBoton, {Key? key}) : super(key: key);

  void conseguirDatos(BuildContext context) async {
    if (tipoBoton == "Azul") {
      Future<DatosUsuarioResponse> f = obtenerDatosUsuario(
          DatosUsuarioPetition(_s.getField(SesionFieldsCodes.token)));
      DatosUsuarioResponse r = await f;
      if (r.OK) {
        datos = DatosUsuario(
            usuario: r.username,
            correoElectronico: r.correo,
            telefonoMovil: r.telefono,
            fechaNacimiento: r.fecha);
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => Perfil(_s, datos as DatosUsuario)),
            (Route<dynamic> route) => false);
      }
    } else if (tipoBoton == "Amarillo") {
      //ESTADISTICAS
      Future<EstadisticasUsuarioResponse> f = obtenerEstadisticasUsuario(
          EstadisticasUsuarioPetition(_s.getField(SesionFieldsCodes.token)));
      EstadisticasUsuarioResponse r = await f;
      if (r.OK) {
        datos = EstadisticasUsuario(
            r.quesitos, r.preguntas, r.incorrectas, r.correctas, r.aciertos);
        // ignore: use_build_context_synchronously
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Estadisticas(_s, datos as EstadisticasUsuario)));
      }
    } else if (tipoBoton == "Verde") {
      //TIENDA
      List<Ficha> fichas = <Ficha>[];
      List<Tablero> tableros = <Tablero>[];

      Future<ObjetosTiendaResponse> f = obtenerObjetosTienda(
          ObjetosTiendaPetition(_s.getField(SesionFieldsCodes.token)));
      ObjetosTiendaResponse r = await f;

      if (r.OK) {
        for (var item in r.fichas) {
          fichas.add(Ficha(
              id: item['id'],
              coste: item['coste'],
              enUso: item['enUso'],
              adquirido: item['adquirido'],
              imagen: item['imagen']));
        }

        for (var item in r.tableros) {
          tableros.add(Tablero(
              id: item['id'],
              coste: item['coste'],
              enUso: item['enUso'],
              adquirido: item['adquirido'],
              imagen: item['imagen']));
        }
      }

      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Tienda(_s, fichas, tableros)),
          (Route<dynamic> route) => false);
    } else if (tipoBoton == "Naranja") {
      Future<DatosUsuarioResponse> f = obtenerDatosUsuario(
          DatosUsuarioPetition(_s.getField(SesionFieldsCodes.token)));
      DatosUsuarioResponse r = await f;
      if (r.OK) {
        datos = AmigosUsuario(r.amigos);
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => Amigos(_s, datos as AmigosUsuario)),
            (Route<dynamic> route) => false);
      }
    } else if (tipoBoton == "Rojo") {
      //CONTACTO Y REDES
    } else if (tipoBoton == "Rosa") {
      //HISTORIAL
    } else if (tipoBoton == "Blanco") {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Partidas(_s)),
          (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 100), () {
      conseguirDatos(context);
    });

    return MaterialApp(
      home: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Stack(
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
                offset: const Offset(
                    7.5, 15), // ajusta los valores de desplazamiento
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
