

import 'dart:io';
import 'package:flutter_application_1/API/api.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginUserPetition {
  final String username, password;
  const LoginUserPetition(String u, String p)
      : username = u,
        password = p;
}

class LoginUserResponse {
  // ignore: constant_identifier_names
  static const String OK_key = 'OK',
      t_key = 'token',
      eU_key = 'error_username',
      eP_key = 'error_password';
  // ignore: non_constant_identifier_names
  String token = "", error_username = "", error_password = "";
  // ignore: non_constant_identifier_names
  bool OK = false;

  LoginUserResponse();

  // ignore: non_constant_identifier_names
  void FillFields(http.Response r) {
    if (r.statusCode <= 300) {
      final responseJson = json.decode(utf8.decode(r.bodyBytes));

      String parameterValue = responseJson[OK_key];

      if (parameterValue == 'True') {
        OK = true;
        token = responseJson[t_key];
      } else {
        OK = false;
        error_username = responseJson[eU_key];
        error_password = responseJson[eP_key];
        print(error_username);
        print(error_password);
      }
    }
  }
}


Future<LoginUserResponse> iniciarSesionUsuario(LoginUserPetition p) async {
  HttpOverrides.global = MyHttpOverrides();

  LoginUserResponse r = LoginUserResponse();

  final url = Uri.parse('$urlDir/api/usuarios/login/');

  final response = await http.post(url, body: {
    // 'username': "bhjfasd",
    // 'password': "12345678",
    // 'confirm_password': "12345678",
    // 'fecha_nac': "22-01-22",
    // 'correo': "urioew",
    'username': p.username,
    'password': p.password,
  });

  r.FillFields(response);
  return r;
}