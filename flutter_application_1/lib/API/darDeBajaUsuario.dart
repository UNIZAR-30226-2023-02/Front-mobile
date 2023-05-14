import 'dart:io';
import 'package:flutter_application_1/API/api.dart';
import 'package:http/http.dart' as http;

class DarDeBajaUsuarioPetition {
}

class DarDeBajaUsuarioResponse {
  // ignore: non_constant_identifier_names
  bool OK = false;

  DarDeBajaUsuarioResponse();

  // ignore: non_constant_identifier_names
  void FillFields(http.Response r) {
    if (r.statusCode <= 300) {
        OK = true;
    }
    else {
        OK = false;
      }
  }
}

// ignore: non_constant_identifier_names
Future<DarDeBajaUsuarioResponse> darDeBajaUsuario(DarDeBajaUsuarioPetition p,String token) async {
  HttpOverrides.global = MyHttpOverrides();

  DarDeBajaUsuarioResponse r = DarDeBajaUsuarioResponse();

  final url = Uri.parse('$urlDir/api/usuarios/dar-baja/');

  final response = await http.post(url, headers: {
    'Authorization': "Token $token",
  });

  r.FillFields(response);
  return r;
}
