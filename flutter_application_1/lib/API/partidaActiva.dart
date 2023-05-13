import 'dart:io';
import 'package:flutter_application_1/API/api.dart';
import 'package:flutter_application_1/Data_types/index.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Data_types/sesion.dart';

class PartidaActivaPetition {
  PartidaActivaPetition();
}

class PartidaActivaResponse {
  // ignore: constant_identifier_names
  static const String OK_key = 'OK', E_key = 'error', WS_KEY = 'ws_partida';
  // ignore: non_constant_identifier_names
  String error = "", ws = "";
  // ignore: non_constant_identifier_names
  bool OK = false;

  PartidaActivaResponse();

  // ignore: non_constant_identifier_names
  void FillFields(http.Response r) {
    if (r.statusCode <= 300) {
      final responseJson = json.decode(utf8.decode(r.bodyBytes));
      String parameterValue = responseJson[OK_key];

      if (parameterValue == 'True') {
        OK = true;
        ws = responseJson[WS_KEY];
      } else {
        error = responseJson[E_key];
      }
    }
  }
}

// ignore: non_constant_identifier_names
Future<PartidaActivaResponse> partidaActiva(
    PartidaActivaPetition p, String token) async {
  HttpOverrides.global = MyHttpOverrides();

  PartidaActivaResponse r = PartidaActivaResponse();

  final url = Uri.parse('$urlDir/api/partida/activa/');

  final response = await http.post(url, headers: {
    'Authorization': "Token $token",
  }, body: {});

  r.FillFields(response);
  return r;
}
