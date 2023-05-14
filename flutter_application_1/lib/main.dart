import 'package:flutter/material.dart';
import 'package:flutter_application_1/Interfaz/Juego/salaEspera.dart';
import 'Data_types/index.dart';

void main() {
  runApp(
    MaterialApp(title: 'Login', home: SalaEspera(Sesion(), '', '')),
  );
}
