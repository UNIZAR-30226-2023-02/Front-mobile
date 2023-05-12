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

  bool OK = false;

  ObtenerSalasResponse();

  // ignore: non_constant_identifier_names
  void FillFields(http.Response r) {
    if (r.statusCode <= 300) {
      final responseJson = json.decode(utf8.decode(r.bodyBytes));
      OK = true;
      for (var item in responseJson) {
        salas.add(DatosSalaPartida(nombre: item['nombre_sala'],creador: item['creador_username'],tiempoRespuesta: item['tiempo_respuesta'].toString(),numeroJugadores: item['n_jugadores'].toString(),tipoPartida: item['tipo_partida'],tipoSala: item['nombre_sala']));
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
