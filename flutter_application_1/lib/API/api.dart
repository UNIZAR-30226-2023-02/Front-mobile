import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

const String urlDir = 'http://51.142.118.71:8000';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
//REGISTRO

class RegistroUserPetition {
  final String username,
      password,
      confirm_password,
      fecha_nac,
      correo,
      telefono;
  const RegistroUserPetition(
      String u, String p, String cp, String f, String c, String t)
      : username = u,
        password = p,
        confirm_password = cp,
        fecha_nac = f,
        correo = c,
        telefono = t;
}

class RegistroUserResponse {
  // ignore: constant_identifier_names
  static const String OK_key = 'OK',
      eU_key = 'error_username',
      eP_key = 'error_password',
      eCP_key = 'error_confirm_password',
      eF_key = 'error_fecha_nac',
      eC_key = 'error_correo',
      eT_key = 'error_telefono';
  // ignore: non_constant_identifier_names
  String error_username = "",
      error_password = "",
      error_confirm_password = "",
      error_fecha = "",
      error_correo = "",
      error_telefono = "";
  // ignore: non_constant_identifier_names
  bool OK = false;

  RegistroUserResponse();

  // ignore: non_constant_identifier_names
  void FillFields(http.Response r) {
    if (r.statusCode <= 300) {
      final responseJson = json.decode(utf8.decode(r.bodyBytes));

      String parameterValue = responseJson[OK_key];

      if (parameterValue == 'True') {
        OK = true;
      } else {
        OK = false;
        error_username = responseJson[eU_key];
        error_password = responseJson[eP_key];
        error_confirm_password = responseJson[eCP_key];
        error_fecha = responseJson[eF_key];
        error_correo = responseJson[eC_key];
        error_telefono = responseJson[eT_key];
      }
    }
    print(
        "${r.statusCode} $error_username $error_password $error_confirm_password $error_fecha $error_correo $error_telefono");
  }
}

Future<RegistroUserResponse> registroUsuario(RegistroUserPetition p) async {
  HttpOverrides.global = MyHttpOverrides();

  RegistroUserResponse r = RegistroUserResponse();

  final url = Uri.parse('$urlDir/api/usuarios/register/');

  final response = await http.post(url, body: {
    'username': p.username,
    'password': p.password,
    'confirm_password': p.confirm_password,
    'fecha_nac': p.fecha_nac,
    'correo': p.correo,
    'telefono': p.telefono,
  });
  print(
      "${p.username} ${p.password} ${p.confirm_password} ${p.fecha_nac} ${p.correo} ${p.telefono}");

  r.FillFields(response);
  return r;
}
