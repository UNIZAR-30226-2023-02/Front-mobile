import 'dart:io';
import 'package:flutter_application_1/API/api.dart';
import 'package:flutter_application_1/Data_types/index.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Data_types/sesion.dart';

class CrearSalaPetition {
  static const String modoClasico = "Clasico",
      modoEquipos = "Equipo",
      modoTematica = "Tematico",
      NS_key = 'nombre_sala',
      TR_key = 'tiempo_respuesta',
      PS_key = 'password_sala',
      NJ_key = 'n_jugadores';

  // ignore: non_constant_identifier_names
  String nombreSala, tiempoRespuesta, contrasenaSala, numeroJugadores;
  CrearSalaPetition(String nS, String tR, String cS, String nJ)
      : nombreSala = nS,
        tiempoRespuesta = tR,
        contrasenaSala = cS,
        numeroJugadores = nJ;
}

class CrearSalaResponse {
  // ignore: constant_identifier_names
  static const String OK_key = 'OK',
      ENS_key = 'error_nombre_sala',
      ETP_key = 'error_tipo_partida',
      ENJ_key = 'error_n_jugadores',
      ETR_key = 'error_tiempo_respuesta';
  // ignore: non_constant_identifier_names
  String errorNombreSala = "",
      errorTipoPartida = "",
      errorNJugadores = "",
      errorTiempoRespuesta = "";
  // ignore: non_constant_identifier_names
  bool OK = false;

  CrearSalaResponse();

  // ignore: non_constant_identifier_names
  void FillFields(http.Response r) {
    if (r.statusCode <= 300) {
      final responseJson = json.decode(utf8.decode(r.bodyBytes));

      String parameterValue = responseJson[OK_key];

      if (parameterValue == 'True') {
        OK = true;
        errorNombreSala = responseJson[ENS_key];
        errorTipoPartida = responseJson[ETP_key];
        errorNJugadores = responseJson[ENJ_key];
        errorTiempoRespuesta = responseJson[ENJ_key];
      } else {
        OK = false;
      }
    }
  }
}

// ignore: non_constant_identifier_names
Future<CrearSalaResponse> crearSalaPartida(
    CrearSalaPetition p, String token) async {
  HttpOverrides.global = MyHttpOverrides();

  CrearSalaResponse r = CrearSalaResponse();

  final url = Uri.parse('$urlDir/api/salas/crear/');

  final response = await http.post(url, headers: {
    'Authorization': "Token $token",
  }, body: {
    CrearSalaPetition.NS_key: p.nombreSala,
    CrearSalaPetition.NJ_key: p.numeroJugadores,
    CrearSalaPetition.PS_key: p.contrasenaSala,
    CrearSalaPetition.TR_key: p.tiempoRespuesta,
  });

  r.FillFields(response);
  return r;
}
