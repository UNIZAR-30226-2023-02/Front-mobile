import 'dart:io';
import 'package:flutter_application_1/API/api.dart';
import 'package:flutter_application_1/Data_types/index.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ObtenerSalasPetition {
  ObtenerSalasPetition();
}

class ObtenerSalasResponse {
  // ignore: constant_identifier_names
  List<DatosSalaPartida> salas = <DatosSalaPartida>[];
  List<String> nombreSalas = <String>[];

  static const String NS_KEY = 'nombre_sala',
      CS_KEY = 'creador_username',
      TR_KEY = 'tiempo_respuesta',
      NJ_KEY = 'n_jugadores',
      TP_KEY = 'tipo_partida',
      TS_KEY = 'tipo_sala';

  bool OK = false;

  ObtenerSalasResponse();

  // ignore: non_constant_identifier_names
  void FillFields(http.Response r) {
    if (r.statusCode <= 300) {
      final responseJson = json.decode(utf8.decode(r.bodyBytes));
      OK = true;
      for (var item in responseJson) {
        nombreSalas.add(item[NS_KEY]);
        salas.add(DatosSalaPartida(
            nombre: item[NS_KEY],
            creador: item[CS_KEY],
            tiempoRespuesta: item[TR_KEY].toString(),
            numeroJugadores: item[NJ_KEY].toString(),
            tipoPartida: item[TP_KEY],
            tipoSala: item[TS_KEY]));
      }
    }
  }
}

// ignore: non_constant_identifier_names
Future<ObtenerSalasResponse> obtenerSalas(
    ObtenerSalasPetition p, String token) async {
  HttpOverrides.global = MyHttpOverrides();

  ObtenerSalasResponse r = ObtenerSalasResponse();

  final url = Uri.parse('$urlDir/api/salas/lista-salas/');

  final response = await http.post(url, headers: {
    'Authorization': "Token $token",
  });

  r.FillFields(response);
  return r;
}
