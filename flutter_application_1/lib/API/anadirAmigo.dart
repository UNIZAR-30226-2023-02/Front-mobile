import 'dart:io';
import 'package:flutter_application_1/API/api.dart';
import 'package:flutter_application_1/Data_types/datosUsuario.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AnadirAmigoPetition {
  String token, amigo;

  AnadirAmigoPetition(String t, String a)
      : token = t,
        amigo = a;
}

class AnadirAmigoResponse {
  // ignore: constant_identifier_names
  static const String OK_key = 'OK', E_key = 'error';
  // ignore: non_constant_identifier_names
  String error = "";
  // ignore: non_constant_identifier_names
  bool OK = false;

  AnadirAmigoResponse();

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
Future<AnadirAmigoResponse> anadirAmigo(AnadirAmigoPetition p) async {
  HttpOverrides.global = MyHttpOverrides();

  AnadirAmigoResponse r = AnadirAmigoResponse();

  final url = Uri.parse('$urlDir/api/usuarios/add/amigo/');

  final response = await http.post(url, headers: {
    'Authorization': "Token ${p.token}",
  }, body: {
    'amigo': p.amigo,
  });

  r.FillFields(response);
  return r;
}
