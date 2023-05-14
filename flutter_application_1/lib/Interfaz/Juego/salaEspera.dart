// ignore: file_names
// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Interfaz/Menu/index.dart';
import 'package:flutter_application_1/Interfaz/Menu/Estilo/index.dart';
import 'package:web_socket_channel/io.dart';

import '../../../../Data_types/index.dart';

import '../../../../API/index.dart';

//ignore: must_be_immutable
class SalaEspera extends StatefulWidget {
  const SalaEspera(this._s, this._wS, this._tP, {Key? key}) : super(key: key);
  final String _wS;
  final Sesion _s;
  final String _tP;
  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _SalaEsperaState createState() => _SalaEsperaState(_s, _wS, _tP);
}

class _SalaEsperaState extends State<SalaEspera> {
  _SalaEsperaState(this._s, this._wS, this._tP);
  final Sesion _s;
  final String _wS;
  final String _tP;
  List<String> _jugadores = <String>[
    "Diego",
    "Acher",
    "akdkadladkadk",
    "jkakd",
    "akdkadladkadk",
    "jkakd"
  ];

  static const String ACCION_KEY = 'accion',
      ACCION_AL = 'actualizar_lista',
      ACCION_EP = 'empezar_partida',
      USERNAMES_KEY = 'usernames',
      URL_KEY = 'url_partida';

  late IOWebSocketChannel _socket;

  @override
  void initState() {
    super.initState();
    /*try {
      _socket = IOWebSocketChannel.connect(_wS);
    } catch (error) {
      print("Error url: $_wS");
      return;
    }

    _socket.stream.listen((mensaje) {
      _leerMensaje(mensaje);
    });*/
  }

  void _leerMensaje(String mensaje) {
    /*Map<String, dynamic> mensajeDecodificado = json.decode(mensaje);
    String accion = mensajeDecodificado[ACCION_KEY];
    if (accion == ACCION_AL) {
      List<dynamic> l = mensajeDecodificado[USERNAMES_KEY];
      _jugadores = l.map((item) => item as String).toList();
      setState(() {});
    } else if (accion == ACCION_EP) {
      String url = mensajeDecodificado[URL_KEY];
      _socket.sink.close();
      /*Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Juego(_s,'$wsDir$url?username=${_s.getField(SesionFieldsCodes.usuario)}')),
              (Route<dynamic> route) => false);*/
    }*/
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WillPopScope(
        onWillPop: () async {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Menu(_s)),
              (Route<dynamic> route) => false);
          return false;
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: LayoutBuilder(
            builder: (context, BoxConstraints constraints) {
              return Container(
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/tapete.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Stack(
                  children: [
                    const Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 30, right: 70),
                        child: Text(
                          "Esperando jugadores",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFf7f6f6),
                            fontFamily: "Bona Nova",
                          ),
                        ),
                      ),
                    ),
                    const Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 25, right: 30),
                        child: SizedBox(
                          width: 32,
                          height: 33,
                          child: AnimacionImagen(),
                        ),
                      ),
                    ),
                    _jugadores.isNotEmpty
                        ? Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: constraints.maxWidth / 15,
                                  top: constraints.maxHeight / 7),
                              child: Container(
                                height: constraints.maxHeight / 2.5,
                                width: constraints.maxWidth / 7,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            bottom: constraints.maxHeight / 25),
                                        child: Text(
                                          _jugadores[0],
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontFamily: "Baskerville",
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            bottom: constraints.maxHeight / 25),
                                        child: Icon(
                                          Icons.person,
                                          color: Colors.white,
                                          size: constraints.maxWidth / 10,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                    _jugadores.length > 5
                        ? Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: constraints.maxWidth / 4,
                                  bottom: constraints.maxHeight / 7),
                              child: Container(
                                height: constraints.maxHeight / 2.5,
                                width: constraints.maxWidth / 7,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            bottom: constraints.maxHeight / 25),
                                        child: Text(
                                          _jugadores[5],
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontFamily: "Baskerville",
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            bottom: constraints.maxHeight / 25),
                                        child: Icon(
                                          Icons.person,
                                          color: Colors.white,
                                          size: constraints.maxWidth / 10,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                    _jugadores.length > 2
                        ? Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: constraints.maxHeight / 7),
                              child: Container(
                                height: constraints.maxHeight / 2.5,
                                width: constraints.maxWidth / 7,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            bottom: constraints.maxHeight / 25),
                                        child: Text(
                                          _jugadores[2],
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontFamily: "Baskerville",
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            bottom: constraints.maxHeight / 25),
                                        child: Icon(
                                          Icons.person,
                                          color: Colors.white,
                                          size: constraints.maxWidth / 10,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                    _jugadores.length > 1
                        ? Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: constraints.maxWidth / 4,
                                  bottom: constraints.maxHeight / 7),
                              child: Container(
                                height: constraints.maxHeight / 2.5,
                                width: constraints.maxWidth / 7,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        bottom: constraints.maxHeight / 25),
                                    child: Text(
                                      _jugadores[1],
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontFamily: "Baskerville",
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class JumpingDotsProgressIndicator extends StatefulWidget {
  final int numberOfDots;
  final double beginTweenValue = 0.0;
  final double endTweenValue = 8.0;

  JumpingDotsProgressIndicator({
    this.numberOfDots = 3,
  });

  _JumpingDotsProgressIndicatorState createState() =>
      _JumpingDotsProgressIndicatorState(
        numberOfDots: this.numberOfDots,
      );
}

class _JumpingDotsProgressIndicatorState
    extends State<JumpingDotsProgressIndicator> with TickerProviderStateMixin {
  int numberOfDots;
  List<AnimationController> controllers = <AnimationController>[];
  List<Animation<double>> animations = <Animation<double>>[];
  List<Widget> _widgets = <Widget>[];

  _JumpingDotsProgressIndicatorState({
    required this.numberOfDots,
  });
  @override
  initState() {
    super.initState();
    for (int i = 0; i < numberOfDots; i++) {
// adding controllers
      controllers.add(AnimationController(
          duration: Duration(milliseconds: 250), vsync: this));
// adding animation values
      animations.add(Tween(
              begin: widget.beginTweenValue, end: widget.endTweenValue)
          .animate(controllers[i])
        ..addStatusListener((AnimationStatus status) {
          if (status == AnimationStatus.completed) controllers[i].reverse();
          if (i == numberOfDots - 1 && status == AnimationStatus.dismissed) {
            controllers[0].forward();
          }
          if (animations[i].value > widget.endTweenValue / 2 &&
              i < numberOfDots - 1) {
            controllers[i + 1].forward();
          }
        }));
// adding list of widgets
      _widgets.add(Padding(
        padding: EdgeInsets.only(right: 1.0),
        child: JumpingDot(
          animation: animations[i],
        ),
      ));
    }
// animating first dot in the list
    controllers[0].forward();
  }

  @override
  void dispose() {
    for (int i = 0; i < numberOfDots; i++) controllers[i].dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _widgets,
      ),
    );
  }
}
