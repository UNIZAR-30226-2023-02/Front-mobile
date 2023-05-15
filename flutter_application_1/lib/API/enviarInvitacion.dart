import 'dart:io';
import 'package:flutter_application_1/API/api.dart';
import 'package:flutter_application_1/Data_types/index.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class EnviarInvitacionPetition {
  String _amigo;
  EnviarInvitacionPetition(String amigo) : _amigo = amigo;
}

class EnviarInvitacionResponse {
  static const String OK_KEY = 'OK',
      E_KEY = 'error';
  // ignore: non_constant_identifier_names
  bool OK = false;
  String error = "";

  EnviarInvitacionResponse();

  // ignore: non_constant_identifier_names
  void FillFields(http.Response r) {
    if (r.statusCode <= 300) {
      final responseJson = json.decode(utf8.decode(r.bodyBytes));

      String parameterValue = responseJson[OK_KEY];
      if (parameterValue == 'True') {
        OK = true;
      } else {
        error = responseJson[E_KEY];
      }
    }
  }
}

// ignore: non_constant_identifier_names
Future<EnviarInvitacionResponse> enviarInvitacion(
    EnviarInvitacionPetition p, String token) async {
  HttpOverrides.global = MyHttpOverrides();

  EnviarInvitacionResponse r = EnviarInvitacionResponse();

  final url = Uri.parse('$urlDir/api/salas/enviar-peticion/');

  final response = await http.post(url, headers: {
    'Authorization': "Token $token",
  },body: {
    'username_amigo' : p._amigo
  });

  r.FillFields(response);
  return r;
}
