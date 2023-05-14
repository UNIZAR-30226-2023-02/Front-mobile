import 'dart:io';
import 'package:flutter_application_1/API/api.dart';
import 'package:flutter_application_1/Data_types/datosUsuario.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RechazarAmigoPetition {
  String amigo;

  RechazarAmigoPetition(String a) : amigo = a;
}

class RechazarAmigoResponse {
  // ignore: constant_identifier_names
  static const String OK_key = 'OK', E_key = 'error';
  // ignore: non_constant_identifier_names
  String error = "";
  // ignore: non_constant_identifier_names
  bool OK = false;

  RechazarAmigoResponse();

  // ignore: non_constant_identifier_names
  void FillFields(http.Response r) {
    if (r.statusCode <= 300) {
      final responseJson = json.decode(utf8.decode(r.bodyBytes));

      String parameterValue = responseJson[OK_key];

      if (parameterValue == 'True') {
        OK = true;
      } else {
        error = responseJson[E_key];
      }
    }
  }
}

// ignore: non_constant_identifier_names
Future<RechazarAmigoResponse> rechazarAmigo(
    RechazarAmigoPetition p, String token) async {
  HttpOverrides.global = MyHttpOverrides();

  RechazarAmigoResponse r = RechazarAmigoResponse();

  final url = Uri.parse('$urlDir/api/usuarios/rechazar/amigo/');

  final response = await http.post(url, headers: {
    'Authorization': "Token $token",
  }, body: {
    'amigo': p.amigo,
  });

  r.FillFields(response);
  return r;
}
