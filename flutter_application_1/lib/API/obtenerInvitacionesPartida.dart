import 'dart:io';
import 'package:flutter_application_1/API/api.dart';
import 'package:flutter_application_1/Data_types/index.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ObtenerInvitacionesPetition {
  ObtenerInvitacionesPetition();
}

class ObtenerInvitacionesResponse {
  // ignore: constant_identifier_names, non_constant_identifier_names
  List<InvitacionPartida> invitaciones = <InvitacionPartida>[];
  static const String OK_KEY = 'OK',
      P_KEY = 'peticiones',
      NS_KEY = 'nombre_sala',
      NA_KEY = 'me_invita',
      TP_KEY = 'tipo_partida',
      WS_KEY = 'ws',
      NJ_KEY = 'n_jugadores',
      E_KEY = 'error';
  // ignore: non_constant_identifier_names
  bool OK = false;
  String error = "";

  ObtenerInvitacionesResponse();

  // ignore: non_constant_identifier_names
  void FillFields(http.Response r) {
    if (r.statusCode <= 300) {
      final responseJson = json.decode(utf8.decode(r.bodyBytes));

      String parameterValue = responseJson[OK_KEY];
      if (parameterValue == 'True') {
        OK = true;

        for (var item in responseJson[P_KEY]) {
          invitaciones.add(InvitacionPartida(
              nombreSala: item[NS_KEY],
              nombreAmigo: item[NA_KEY],
              tipoPartida: item[TP_KEY],
              numeroJugadores: item[NJ_KEY],
              webSocket: item[WS_KEY]));
        }
      } else {
        error = responseJson[E_KEY];
      }
    }
  }
}

// ignore: non_constant_identifier_names
Future<ObtenerInvitacionesResponse> obtenerInvitaciones(
    ObtenerInvitacionesPetition p, String token) async {
  HttpOverrides.global = MyHttpOverrides();

  ObtenerInvitacionesResponse r = ObtenerInvitacionesResponse();

  final url = Uri.parse('$urlDir/api/salas/listar-peticiones-sala/');

  final response = await http.post(url, headers: {
    'Authorization': "Token $token",
  });

  r.FillFields(response);
  return r;
}
