import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

const String urlDir = 'http://51.142.118.71:8000';

class LoginUserPetition{
  final String username,password;
  const LoginUserPetition(String u,String p) : username = u,password = p;
}

class LoginUserResponse{

  // ignore: constant_identifier_names
  static const String OK_key = 'OK',t_key = 'token', eU_key = 'error_username',eP_key = 'error_username';
  // ignore: non_constant_identifier_names
  String token = "",error_username = "",error_password = "";
  // ignore: non_constant_identifier_names
  bool OK = false;

  LoginUserResponse();

  // ignore: non_constant_identifier_names
  void FillFields(http.Response r){
    print("status");
    print(r.statusCode);
    if(r.statusCode <= 300){
      print("status2");
      final responseJson = json.decode(r.body);

      String parameterValue = responseJson[OK_key];

      if(parameterValue == 'True'){
        OK = true;
        token = responseJson[t_key];
        print("OK1");

      }
      else{
        OK = false;
        print("OK2");
        error_username = responseJson[eU_key];
        error_password = responseJson[eP_key];
      }
    }
    else{
      print("status0");
    }
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
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