// ignore_for_file: unnecessary_new, no_leading_underscores_for_local_identifiers

import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_application_1/Interfaz/InicioSesion/Estilo/index.dart';

import 'package:flutter_application_1/Data_types/registro.dart';
import 'package:flutter_application_1/Interfaz/InicioSesion/index.dart';

class RegistrandoUsuario extends StatefulWidget {
  Registro r;
  RegistrandoUsuario(this.r, {Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RegistrandoUsuario createState() => _RegistrandoUsuario();
}

class _RegistrandoUsuario extends State<RegistrandoUsuario> {
  late Timer _timer;
  UnsignedInt contador = 0 as UnsignedInt;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 1), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
    });
  }

  void setTimer() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        //margin: EdgeInsets.symmetric(horizontal: w*0.01,vertical: h*0.01 ),
        // ignore: prefer_const_constructors
        decoration: BoxDecoration(
          image: const DecorationImage(
              image: AssetImage('assets/tapete.png'), fit: BoxFit.fill),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 40, right: 80),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Padding(
                        padding: EdgeInsets.only(top: 12),
                        child: Text(
                          "Cargando...",
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFf7f6f6),
                            fontFamily: "Bona Nova",
                          ),
                        )),
                    const SizedBox(width: 8, height: 0),
                    SizedBox(width: 32, height: 33, child: AnimacionImagen())
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    //_timer.cancel();
    super.dispose();
  }
}
