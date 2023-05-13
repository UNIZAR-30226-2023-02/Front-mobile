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

  // ignore: non_constant_identifier_names
  bool OK = false;

  ObtenerInvitacionesResponse();

  // ignore: non_constant_identifier_names
  void FillFields(http.Response r) {
    if (r.statusCode <= 300) {
      final responseJson = json.decode(utf8.decode(r.bodyBytes));

      String parameterValue = responseJson['OK'];
      if (parameterValue == 'True') {
        OK = true;

        for (var item in responseJson['peticiones']) {
          invitaciones.add(InvitacionPartida(
              nombreSala: item['ws'], nombreAmigo: item['me_invita']));
        }
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
