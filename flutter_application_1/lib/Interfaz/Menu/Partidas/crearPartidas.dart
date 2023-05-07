// ignore: file_names
// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Data_types/amigosUsuario.dart';
import 'package:flutter_application_1/Data_types/datosUsuario.dart';
import 'package:flutter_application_1/API/index.dart';
import 'package:flutter_application_1/Interfaz/Menu/Estilo/index.dart';

import '../../../../Data_types/sesion.dart';
import '../home.dart';

//ignore: must_be_immutable
class CrearPartida extends StatefulWidget {
  const CrearPartida(this._s, {Key? key}) : super(key: key);
  final Sesion _s;

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _CrearPartidaState createState() => _CrearPartidaState(_s);
}

class _CrearPartidaState extends State<CrearPartida> {
  final _formKey = GlobalKey<FormState>();
  final Sesion _s;
  _CrearPartidaState(this._s);

  bool _datosPartida = false;
  bool _modoClasico = false, _modoEquipos = false, _modoTematica = false;

  final TextEditingController _gameSearchController = TextEditingController();

  void conseguirDatosAmigo(int index) async {}

  void crearPartida() async {}

  void eliminarAmigoUsuario() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/tapete.png'),
              fit: BoxFit.fill,
              // contentMode = .ScaleAspectFill,
              // alignment: Alignment.topCenter,
            ),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Container(
                  alignment: Alignment.topCenter,
                  child: const Text(
                    "Crear Partida",
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFc9c154),
                      fontFamily: "Baskerville",
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 40, left: 50),
                  child: Boton1(
                    "VOLVER",
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return GestureDetector(
                    onTap: () {
                      _datosPartida = true;
                      _modoClasico = true;
                      setState(() {});
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 380),
                        child: Container(
                          width: constraints.maxWidth / 5,
                          height: constraints.maxHeight / 3,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: Colors.white)),
                          child: Stack(
                            children: [
                              const Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 15),
                                  child: Text(
                                    "Modo Clásico",
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontFamily: "Baskerville",
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topCenter,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: SizedBox(
                                    height: 75,
                                    width: 75,
                                    child: Image.asset(
                                      "assets/Clasico.png",
                                      color: Colors.white,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return GestureDetector(
                    onTap: () {
                      _datosPartida = true;
                      _modoEquipos = true;
                      setState(() {});
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: constraints.maxWidth / 5,
                        height: constraints.maxHeight / 3,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: Colors.white)),
                        child: Stack(
                          children: [
                            const Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 15),
                                child: Text(
                                  "Modo Equipos",
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontFamily: "Baskerville",
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: SizedBox(
                                  height: 75,
                                  width: 75,
                                  child: Image.asset(
                                    "assets/Clasico.png",
                                    color: Colors.white,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return GestureDetector(
                    onTap: () {
                      _datosPartida = true;
                      _modoTematica = true;
                      setState(() {});
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 380),
                        child: Container(
                          width: constraints.maxWidth / 5,
                          height: constraints.maxHeight / 3,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: Colors.white)),
                          child: Stack(
                            children: [
                              const Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 15),
                                  child: Text(
                                    "Modo Temática",
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontFamily: "Baskerville",
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topCenter,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: SizedBox(
                                    height: 75,
                                    width: 75,
                                    child: Image.asset(
                                      "assets/Clasico.png",
                                      color: Colors.white,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              
            ],
          ),
        ),
    );
  }
}



