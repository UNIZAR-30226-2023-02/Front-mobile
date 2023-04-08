// ignore_for_file: unnecessary_new, no_leading_underscores_for_local_identifiers

import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_application_1/Api/api.dart';

import 'package:flutter_application_1/Interfaz/InicioSesion_Registro/Estilo/index.dart';

import 'package:flutter_application_1/Data_types/registro.dart';
import 'package:flutter_application_1/Interfaz/InicioSesion_Registro/index.dart';
import 'package:flutter_application_1/Interfaz/Menu/home.dart';

class ErrorRegistro extends StatelessWidget {
  ErrorRegistro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Home()),
            (Route<dynamic> route) => false);
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
          child: Align(
            alignment: Alignment.topCenter,
            child: Stack(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 100),
                  child: SizedBox(
                    width: 350,
                    child: Text(
                      "No se ha podido completar el registro correctamente",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 35.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFf7f6f6),
                        fontFamily: "Bona Nova",
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 300, left: 80),
                  child: Boton1(
                    "VOLVER A INICIO",
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => Home()),
                          (Route<dynamic> route) => false);
                    },
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
