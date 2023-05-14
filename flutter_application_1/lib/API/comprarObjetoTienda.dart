import 'dart:io';
import 'package:flutter_application_1/API/api.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ComprarObjetoTiendaPetition {
  String token,id;
  ComprarObjetoTiendaPetition(String t,String i) : token = t,id = i;
}

class ComprarObjetoTiendaResponse {
  // ignore: constant_identifier_names
  static const String OK_key = 'OK',E_key = 'error';
  // ignore: non_constant_identifier_names
  bool OK = false;
  String error = "";

  ComprarObjetoTiendaResponse();

  // ignore: non_constant_identifier_names
  void FillFields(http.Response r) {
    print(r.statusCode);
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
Future<ComprarObjetoTiendaResponse> comprarObjetoTienda(ComprarObjetoTiendaPetition p) async {
  HttpOverrides.global = MyHttpOverrides();

  ComprarObjetoTiendaResponse r = ComprarObjetoTiendaResponse();

  final url = Uri.parse('$urlDir/api/tienda/comprar/');

  final response = await http.post(url, headers: {
    'Authorization': "Token ${p.token}",

  },body: {
    'objeto_id': p.id,
    
  });

  r.FillFields(response);
  return r;
}
