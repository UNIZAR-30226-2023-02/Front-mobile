import 'dart:io';
import 'package:flutter_application_1/API/api.dart';
import 'package:flutter_application_1/Data_types/index.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Data_types/sesion.dart';

class ValidarSalaPetition {
  static const String 
      NS_key = 'nombre_sala';

  // ignore: non_constant_identifier_names
  String nombreSala;
  ValidarSalaPetition(String nS)
      : nombreSala = nS;
}

class ValidarSalaResponse {
  // ignore: constant_identifier_names
  static const String OK_key = 'OK',
      E_key = 'error';
  // ignore: non_constant_identifier_names
  String error = "";
  // ignore: non_constant_identifier_names
  bool OK = false;

  ValidarSalaResponse();

  // ignore: non_constant_identifier_names
  void FillFields(http.Response r) {
    if (r.statusCode <= 300) {
      final responseJson = json.decode(utf8.decode(r.bodyBytes));

      String parameterValue = responseJson[OK_key];

      if (parameterValue == 'True') {
        OK = true;
        error = responseJson[E_key];
      } else {
        OK = false;
      }
    }
  }
}

// ignore: non_constant_identifier_names
Future<ValidarSalaResponse> unirseSalaPartida(
    ValidarSalaPetition p, String token) async {
  HttpOverrides.global = MyHttpOverrides();

  ValidarSalaResponse r = ValidarSalaResponse();

  final url = Uri.parse('$urlDir/api/salas/validar/');

  final response = await http.post(url, headers: {
    'Authorization': "Token $token",
  },);

  r.FillFields(response);
  return r;
}
