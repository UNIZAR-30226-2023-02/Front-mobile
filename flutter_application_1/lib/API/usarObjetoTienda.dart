import 'dart:io';
import 'package:flutter_application_1/API/api.dart';
import 'package:flutter_application_1/Data_types/datosUsuario.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UsarObjetoTiendaPetition {
  String token,id;
  UsarObjetoTiendaPetition(String t,String i) : token = t,id = i;
}

class UsarObjetoTiendaResponse {
  // ignore: constant_identifier_names
  static const String OK_key = 'OK',E_key = 'error';
  // ignore: non_constant_identifier_names
  bool OK = false;
  String error = "";

  UsarObjetoTiendaResponse();

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
Future<UsarObjetoTiendaResponse> usarObjetoTienda(UsarObjetoTiendaPetition p) async {
  HttpOverrides.global = MyHttpOverrides();

  UsarObjetoTiendaResponse r = UsarObjetoTiendaResponse();

  final url = Uri.parse('$urlDir/api/tienda/usar/');

  final response = await http.post(url, headers: {
    'Authorization': "Token ${p.token}",

  },body: {
    'objeto_id': p.id,
    
  });

  r.FillFields(response);
  return r;
}
