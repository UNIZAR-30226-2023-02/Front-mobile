import 'dart:io';
import 'package:flutter_application_1/API/api.dart';
import 'package:flutter_application_1/Data_types/datosUsuario.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class DatosUsuarioPetition {
  String token;
  DatosUsuarioPetition(String t) : token = t;
}

class DatosUsuarioResponse {
  // ignore: constant_identifier_names
  static const String OK_key = 'OK',
      U_key = 'username',
      F_key = 'fecha_nac',
      C_key = 'correo',
      T_key = 'telefono',
      I_key = 'imagen',
      M_key = 'monedas',
      A_key = 'amigos';
  // ignore: non_constant_identifier_names
  String username = "",
      fecha = "",
      correo = "",
      telefono = "",
      imagen = "";
  int monedas = 0;
  List<String> amigos = <String>[];
  // ignore: non_constant_identifier_names
  bool OK = false;

  DatosUsuarioResponse();

  // ignore: non_constant_identifier_names
  void FillFields(http.Response r) {
    if (r.statusCode <= 300) {
      final responseJson = json.decode(utf8.decode(r.bodyBytes));

      String parameterValue = responseJson[OK_key];

      if (parameterValue == 'True') {
        OK = true;
        username = responseJson[U_key];
        fecha = responseJson[F_key];
        correo = responseJson[C_key];
        telefono = responseJson[T_key].toString();
        imagen = responseJson[I_key];
        monedas = responseJson[M_key];
        List<dynamic> l = responseJson[A_key];
        amigos = l.map((item) => item as String).toList();
      } else {
        OK = false;
      }
      print("$OK $username $fecha $correo $telefono hola");
    }
  }
}

// ignore: non_constant_identifier_names
Future<DatosUsuarioResponse> obtenerDatosUsuario(DatosUsuarioPetition p) async {
  HttpOverrides.global = MyHttpOverrides();

  DatosUsuarioResponse r = DatosUsuarioResponse();

  final url = Uri.parse('$urlDir/api/usuarios/datos-yo/');

  final response = await http.post(url, headers: {
    'Authorization': "Token " + p.token,
  });

  r.FillFields(response);
  return r;
}