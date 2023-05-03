import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Api/api.dart';
import 'package:flutter_application_1/Interfaz/Menu/Amigos/amigos.dart';
import 'package:flutter_application_1/Interfaz/InicioSesion_Registro/InicioSesion/iniciandoSesion.dart';
import 'package:flutter_application_1/Interfaz/InicioSesion_Registro/index.dart';
import 'package:flutter_application_1/Interfaz/Juego/juego.dart';
import 'package:flutter_application_1/Data_types/registro.dart';
import 'package:flutter_application_1/Data_types/datosUsuario.dart';

import 'Data_types/amigosUsuario.dart';
import 'Data_types/sesion.dart';
//import 'pruebas.dart';
//import 'Interfaz/InicioSesion/iniciarSesion.dart';
//import 'Interfaz/InicioSesion/inicioApp.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter_application_1/dentro.dart';

// import 'package:flutter_application_1/InicioSesion/home.dart';
import 'package:flutter_application_1/Interfaz/Menu/index.dart';

void main() {
  runApp(MaterialApp(home: Menu(Sesion())));
}

