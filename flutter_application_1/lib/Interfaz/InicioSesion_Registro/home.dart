import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Interfaz/InicioSesion_Registro/Estilo/index.dart';
import 'package:flutter_application_1/Interfaz/InicioSesion_Registro/InicioSesion/iniciarSesion.dart';

import 'package:flutter_application_1/Interfaz/InicioSesion_Registro/Registro/registrarse1.dart';

import '../../Data_types/registro.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          exit(0);
        },
        child: Container(
            //margin: EdgeInsets.symmetric(horizontal: w*0.01,vertical: h*0.01 ),
            // ignore: prefer_const_constructors
            decoration: BoxDecoration(
              image: const DecorationImage(
                  image: AssetImage('assets/tapete.png'), fit: BoxFit.fill),
            ),
            // ignore: prefer_const_constructors
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        const Text(
                          "Trivial B2B",
                          style: TextStyle(
                              fontFamily: "Baskerville",
                              fontSize: 50.0,
                              color: Color(0xFFc9c154),
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none),
                        ),
                        Image.asset('assets/quesito.png')
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(children: [
                          const SizedBox(height: 30),
                          Boton1(
                            "REGISTRARSE",
                            onPressed: () {
                              Registro r = Registro();
                              r.setField(RegistroFieldsCodes.usuario,
                                  "pruebaRegistro3");
                              r.setField(RegistroFieldsCodes.contrasena,
                                  "pruebaRegistro3");
                              r.setField(
                                  RegistroFieldsCodes.confirmarContrasena,
                                  "pruebaRegistro3");
                              r.setField(RegistroFieldsCodes.fechaNacimiento,
                                  "2002-01-01");
                              r.setField(RegistroFieldsCodes.correoElectronico,
                                  "pruebaregistro3@gmail.com");
                              r.setField(RegistroFieldsCodes.telefonoMovil,
                                  "787678987");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Registrarse1(
                                          reg: r,
                                        )),
                              );
                            },
                          )
                        ]),
                        Column(children: [
                          const SizedBox(height: 30),
                          Boton1("INICIAR SESIÓN", onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const InicioSesion()));
                          })
                        ])
                      ])
                ])));
  }
}
