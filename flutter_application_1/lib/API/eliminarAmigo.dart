import 'dart:io';
import 'package:flutter_application_1/API/api.dart';
import 'package:flutter_application_1/Data_types/datosUsuario.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class EliminarAmigoPetition {
  String token, amigo;

  EliminarAmigoPetition(String t, String a)
      : token = t,
        amigo = a;
}

class EliminarAmigoResponse {
  // ignore: constant_identifier_names
  static const String OK_key = 'OK', E_key = 'error';
  // ignore: non_constant_identifier_names
  String error = "";
  // ignore: non_constant_identifier_names
  bool OK = false;

  EliminarAmigoResponse();

  // ignore: non_constant_identifier_names
  void FillFields(http.Response r) {
    if (r.statusCode <= 300) {
      final responseJson = json.decode(utf8.decode(r.bodyBytes));

      String parameterValue = responseJson[OK_key];

      if (parameterValue == 'True') {
        OK = true;
      } else {
        OK = false;
        error = responseJson[E_key];
      }
    }
  }
}

// ignore: non_constant_identifier_names
Future<EliminarAmigoResponse> eliminarAmigo(EliminarAmigoPetition p) async {
  HttpOverrides.global = MyHttpOverrides();

  EliminarAmigoResponse r = EliminarAmigoResponse();

  final url = Uri.parse('$urlDir/api/usuarios/delete/amigo/');

  final response = await http.post(url, headers: {
    'Authorization': "Token ${p.token}",
  }, body: {
    'amigo': p.amigo,
  });

  r.FillFields(response);
  return r;
}
