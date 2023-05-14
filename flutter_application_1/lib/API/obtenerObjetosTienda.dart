import 'dart:io';
import 'package:flutter_application_1/API/api.dart';
import 'package:flutter_application_1/Data_types/datosUsuario.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ObjetosTiendaPetition {
  String token;
  ObjetosTiendaPetition(String t) : token = t;
}

class ObjetosTiendaResponse {
  // ignore: constant_identifier_names
  static const String OK_key = 'OK',
      F_key = 'fichas',
      T_key = 'tableros';
  // ignore: non_constant_identifier_names
  List<dynamic> fichas = <dynamic>[],tableros = <dynamic>[];
  // ignore: non_constant_identifier_names
  bool OK = false;

  ObjetosTiendaResponse();

  // ignore: non_constant_identifier_names
  void FillFields(http.Response r) {
    if (r.statusCode <= 300) {
      final responseJson = json.decode(utf8.decode(r.bodyBytes));

        OK = true;
        fichas = responseJson[F_key];
        tableros = responseJson[T_key];
    }
  }
}

// ignore: non_constant_identifier_names
Future<ObjetosTiendaResponse> obtenerObjetosTienda(ObjetosTiendaPetition p) async {
  HttpOverrides.global = MyHttpOverrides();

  ObjetosTiendaResponse r = ObjetosTiendaResponse();

  final url = Uri.parse('$urlDir/api/tienda/objetos/');

  final response = await http.post(url, headers: {
    'Authorization': "Token ${p.token}",
  });

  r.FillFields(response);
  return r;
}
