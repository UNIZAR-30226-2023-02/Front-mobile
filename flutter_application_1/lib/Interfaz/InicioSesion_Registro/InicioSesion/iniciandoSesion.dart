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
  Sesion s;
  IniciandoSesion(this.s, {Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _IniciandoSesion createState() => _IniciandoSesion(s);
}

class _IniciandoSesion extends State<IniciandoSesion> {
  Sesion s;
  late Timer _timer;

  int contador = 0;
  bool registrado = false;

  _IniciandoSesion(this.s);

  @override
  void initState() {
    super.initState();
    //_setTimer();
  }

  void _setTimer() {
    _timer = Timer(const Duration(seconds: 6), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Menu()),
      );
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
            alignment: Alignment.center,
            child: Stack(
              children: const [
                Padding(
                  padding: EdgeInsets.only(left: 200, top: 200),
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
                Padding(
                  padding: EdgeInsets.only(left: 295, top: 200),
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
