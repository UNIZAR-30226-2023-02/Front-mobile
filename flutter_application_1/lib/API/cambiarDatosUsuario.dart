import 'dart:io';
import 'package:flutter_application_1/API/api.dart';
import 'package:flutter_application_1/Data_types/datosUsuario.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class CambioDatosUsuarioPetition {
  final String token,
      correo,
      fechaNac,
      telefono;
  const CambioDatosUsuarioPetition(String t,
      String f, String c, String te)
      : token = t,
        fechaNac = f,
        correo = c,
        telefono = te;
}

class CambioDatosUsuarioResponse {
  // ignore: constant_identifier_names
  static const String OK_key = 'OK',
      eF_key = 'error_fecha_nac',
      eC_key = 'error_correo',
      eT_key = 'error_telefono';
  // ignore: non_constant_identifier_names
  String error_fecha = "",
      error_correo = "",
      error_telefono = "";
  // ignore: non_constant_identifier_names
  bool OK = false;

  CambioDatosUsuarioResponse();

  // ignore: non_constant_identifier_names
  void FillFields(http.Response r) {
    if (r.statusCode <= 300) {
      final responseJson = json.decode(utf8.decode(r.bodyBytes));

      String parameterValue = responseJson[OK_key];

      if (parameterValue == 'True') {
        OK = true;
      } else {
        OK = false;
        error_fecha = responseJson[eF_key];
        error_correo = responseJson[eC_key];
        error_telefono = responseJson[eT_key];
      }
    }
  }
}

// ignore: non_constant_identifier_names
Future<CambioDatosUsuarioResponse> CambiarDatosUsuario(CambioDatosUsuarioPetition p, DatosUsuario dU) async {
  HttpOverrides.global = MyHttpOverrides();

  CambioDatosUsuarioResponse r = CambioDatosUsuarioResponse();

  final url = Uri.parse('$urlDir/api/usuarios/cambiar_datos/');

  final response = await http.post(url, body: {
    'token': p.token,
    'fecha_nac': p.fechaNac,
    'correo': p.correo,
    'telefono': p.telefono,
  });

  r.FillFields(response);
  return r;
}