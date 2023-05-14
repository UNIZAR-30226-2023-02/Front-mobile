import 'dart:io';
import 'package:flutter_application_1/API/api.dart';
import 'package:flutter_application_1/Data_types/index.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ObtenerPeticionesPetition {
  ObtenerPeticionesPetition();
}

class ObtenerPeticionesResponse {
  // ignore: constant_identifier_names, non_constant_identifier_names
  List<String> peticiones = <String>[];

  static const OK_KEY = 'OK', AP_KEY = 'amigos_pendientes', E_KEY = 'error';

  // ignore: non_constant_identifier_names
  bool OK = false;
  String error = "";

  ObtenerPeticionesResponse();

  // ignore: non_constant_identifier_names
  void FillFields(http.Response r) {
    if (r.statusCode <= 300) {
      final responseJson = json.decode(utf8.decode(r.bodyBytes));

      String parameterValue = responseJson[OK_KEY];
      if (parameterValue == 'True') {
        OK = true;
        List<dynamic> l = responseJson[AP_KEY];
        peticiones = l.map((item) => item as String).toList();
      } else {
        error = responseJson[E_KEY];
      }
    }
  }
}

// ignore: non_constant_identifier_names
Future<ObtenerPeticionesResponse> obtenerPeticionesAmistad(
    ObtenerPeticionesPetition p, String token) async {
  HttpOverrides.global = MyHttpOverrides();

  ObtenerPeticionesResponse r = ObtenerPeticionesResponse();

  final url = Uri.parse('$urlDir/api/usuarios/listar-peticiones-amigos/');

  final response = await http.post(url, headers: {
    'Authorization': "Token $token",
  });

  r.FillFields(response);
  return r;
}
