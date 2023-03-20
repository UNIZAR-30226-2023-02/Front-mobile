import 'dart:ffi';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

const String urlDir = 'https://347b-146-158-156-138.eu.ngrok.io';

class LoginUserPetition{
  final String username,password;
  const LoginUserPetition(String u,String p) : username = u,password = p;
}

class LoginUserResponse{

  // ignore: constant_identifier_names
  static const String OK_key = 'OK',t_key = 'token', eU_key = 'error_username',eP_key = 'error_username';
  // ignore: non_constant_identifier_names
  late final String token,error_username,error_password;
  // ignore: non_constant_identifier_names
  late final Bool OK;

  LoginUserResponse();

  // ignore: non_constant_identifier_names
  void FillFields(http.Response r){
    if(r.statusCode == 200){
      final responseJson = json.decode(r.body);

      String parameterValue = responseJson[OK_key];

      if(parameterValue == 'True'){
        OK = true as Bool;
        token = responseJson[t_key];

      }
      else{
        OK = false as Bool;
        error_username = responseJson[eU_key];
        error_password = responseJson[eP_key];
      }
    }
  }
}



Future<LoginUserResponse> iniciarSesionUsuario(LoginUserPetition p) async {
  
  LoginUserResponse r = LoginUserResponse();

  final url = Uri.parse('$urlDir/api/usuarios/login/');

  final response = await http.post(url, body: {
    'username': p.username,
    'password': p.password,
  });

  r.FillFields(response);
  return r;
}