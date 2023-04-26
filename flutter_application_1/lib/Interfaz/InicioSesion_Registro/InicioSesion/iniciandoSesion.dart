// ignore_for_file: unnecessary_new, no_leading_underscores_for_local_identifiers

import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_application_1/Api/api.dart';
import 'package:flutter_application_1/Data_types/sesion.dart';

import 'package:flutter_application_1/Interfaz/InicioSesion_Registro/Estilo/index.dart';

import 'package:flutter_application_1/Data_types/registro.dart';
import 'package:flutter_application_1/Interfaz/InicioSesion_Registro/index.dart';
import 'package:flutter_application_1/Interfaz/Menu/home.dart';

class IniciandoSesion extends StatefulWidget {
  Sesion _s;
  String _contrasena;
  IniciandoSesion(this._s,this._contrasena, {Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _IniciandoSesion createState() => _IniciandoSesion(_s,_contrasena);
}

class _IniciandoSesion extends State<IniciandoSesion> {
  Sesion _s;
  String _contrasena;
  late Timer _timer;

  int contador = 0;
  bool registrado = false;

  _IniciandoSesion(this._s,this._contrasena);

  @override
  void initState() {
    super.initState();
    _setTimer();
  }

  void _setTimer() {
    _timer = Timer(const Duration(seconds: 6), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Menu(_s)),
          (Route<dynamic> route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          // ignore: prefer_const_constructors
          decoration: BoxDecoration(
            image: const DecorationImage(
                image: AssetImage('assets/tapete.png'), fit: BoxFit.fill),
          ),
          child: Align(
            alignment: Alignment.topLeft,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Container(
                      width: 550,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Bienvenido de nuevo ',
                                style: TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xFFf7f6f6),
                                  fontFamily: "Bona Nova",
                                ),
                              ),
                              TextSpan(
                                text: _s.getField(SesionFieldsCodes.usuario),
                                style: const TextStyle(
                                  fontSize: 30.0,
                                  fontStyle: FontStyle.italic,
                                  color: Color(0xFFf7f6f6),
                                  fontFamily: "Baskerville",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 450, top: 350),
                  child: Text(
                    "Iniciando sesión...",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFf7f6f6),
                      fontFamily: "Bona Nova",
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 600, top: 340),
                  child: SizedBox(
                    width: 32,
                    height: 33,
                    child: AnimacionImagen(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class IniciandoSesionRegistro extends StatefulWidget {
  Sesion _s;
  String _contrasena;
  IniciandoSesionRegistro(this._s,this._contrasena, {Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _IniciandoSesionRegistroState createState() =>
      _IniciandoSesionRegistroState(_s,_contrasena);
}

class _IniciandoSesionRegistroState extends State<IniciandoSesionRegistro> {
  Sesion _s;
  String _contrasena;
  late Timer _timer1, _timer2;

  int contador = 0;
  bool iniciado = false;

  _IniciandoSesionRegistroState(this._s,this._contrasena);

  @override
  void initState() {
    super.initState();
    _setTimer();
    _comprobarIniciarSesionUsuario();
  }

  void _comprobarIniciarSesionUsuario() async {
    if (contador < 3) {
      Future<LoginUserResponse> f = iniciarSesionUsuario(LoginUserPetition(
          _s.getField(SesionFieldsCodes.usuario),_contrasena));
      LoginUserResponse re = await f;

      if (re.OK) {
        iniciado = true;
      } else {
        _timer1 = Timer(
            const Duration(milliseconds: 500), _comprobarIniciarSesionUsuario);
      }
    }
  }

  void _setTimer() async {
    if (iniciado) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Menu(_s)),
          (Route<dynamic> route) => false);
    } else if (contador < 3) {
      contador++;
      _timer2 = Timer(const Duration(seconds: 2), _setTimer);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ErrorInicioSesion(_s,_contrasena)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          // ignore: prefer_const_constructors
          decoration: BoxDecoration(
            image: const DecorationImage(
                image: AssetImage('assets/tapete.png'), fit: BoxFit.fill),
          ),
          child: Align(
            alignment: Alignment.topLeft,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Container(
                      width: 550,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Bienvenido ',
                                style: TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xFFf7f6f6),
                                  fontFamily: "Bona Nova",
                                ),
                              ),
                              TextSpan(
                                text: _s.getField(SesionFieldsCodes.usuario),
                                style: const TextStyle(
                                  fontSize: 30.0,
                                  fontStyle: FontStyle.italic,
                                  color: Color(0xFFf7f6f6),
                                  fontFamily: "Baskerville",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 450, top: 350),
                  child: Text(
                    "Iniciando sesión...",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFf7f6f6),
                      fontFamily: "Bona Nova",
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 600, top: 340),
                  child: SizedBox(
                    width: 32,
                    height: 33,
                    child: AnimacionImagen(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
