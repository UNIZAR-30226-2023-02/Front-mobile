// ignore_for_file: unnecessary_new, no_leading_underscores_for_local_identifiers

import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_application_1/Interfaz/InicioSesion_Registro/Estilo/index.dart';
import 'package:flutter_application_1/Interfaz/InicioSesion_Registro/home.dart';

class InicioApp extends StatefulWidget {
  const InicioApp({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _InicioAppState createState() => _InicioAppState();
}

class _InicioAppState extends State<InicioApp> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 6), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home()),
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
        body: Container(
          //margin: EdgeInsets.symmetric(horizontal: w*0.01,vertical: h*0.01 ),
          // ignore: prefer_const_constructors
          decoration: BoxDecoration(
            image: const DecorationImage(
                image: AssetImage('assets/tapete.png'), fit: BoxFit.fill),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Align(
                  alignment: Alignment.center,
                  child: Padding(
                      padding: const EdgeInsets.only(top: 120),
                      child: Image.asset(
                        'assets/logo.png',
                        height: 180,
                        width: 180,
                      ))),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 40, right: 80),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Padding(
                          padding: EdgeInsets.only(top: 12),
                          child: Text(
                            "Cargando...",
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFf7f6f6),
                              fontFamily: "Bona Nova",
                            ),
                          )),
                      SizedBox(width: 8, height: 0),
                      SizedBox(width: 32, height: 33, child: AnimacionImagen())
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
