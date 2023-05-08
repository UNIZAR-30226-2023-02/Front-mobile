import 'dart:io';
import 'package:flutter_application_1/API/api.dart';
import 'package:flutter_application_1/Data_types/datosUsuario.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class EstadisticasAmigoPetition {
  String username;
  EstadisticasAmigoPetition(String u) : username = u;
}

class EstadisticasAmigoResponse {
  // ignore: constant_identifier_names
  static const String OK_key = 'OK',
      G_key = 'geografia',
      A_key = 'arte_y_literatura',
      H_key = 'historia',
      E_key = 'entretenimiento',
      C_key = 'ciencias',
      D_key = 'deportes',
      Q_key = 'quesitos_totales',
      T_key = 'total',
      B_key = 'bien',
      M_key = 'mal',
      P_key = 'porcentaje',
      TP_key = 'total_preguntas',
      TRC_key = 'total_respuestas_correctas',
      TRI_key = 'total_respuestas_incorrectas',
      PR_key = 'porcentaje_respuestas',
      EU_key = 'error_usuario';
  // ignore: non_constant_identifier_names
  List<String> preguntas = <String>[],incorrectas = <String>[],correctas = <String>[],aciertos = <String>[];
  // ignore: non_constant_identifier_names
  bool OK = false;
  String errorUsuario = "",quesitos = "";

  EstadisticasAmigoResponse();

  // ignore: non_constant_identifier_names
  void FillFields(http.Response r) {
    if (r.statusCode <= 300) {
      final responseJson = json.decode(utf8.decode(r.bodyBytes));

      String parameterValue = responseJson[OK_key];

      if (parameterValue == 'True') {
        OK = true;
        quesitos = responseJson[Q_key];
        Map<String,dynamic> aux;

        // total
        preguntas.add(responseJson[TP_key]);
        incorrectas.add(responseJson[TRI_key]);
        correctas.add(responseJson[TRC_key]);
        aciertos.add(responseJson[PR_key]);

        // geografía
        aux = responseJson[G_key];
        preguntas.add(aux[T_key]!);
        incorrectas.add(aux[B_key]!);
        correctas.add(aux[M_key]!);
        aciertos.add(aux[P_key]!);
      
        // ciencia
        aux = responseJson[C_key];
        preguntas.add(aux[T_key]!);
        incorrectas.add(aux[B_key]!);
        correctas.add(aux[M_key]!);
        aciertos.add(aux[P_key]!);

        // historia
        aux = responseJson[H_key];
        preguntas.add(aux[T_key]!);
        incorrectas.add(aux[B_key]!);
        correctas.add(aux[M_key]!);
        aciertos.add(aux[P_key]!);

        // entretenimiento
        aux = responseJson[E_key];
        preguntas.add(aux[T_key]!);
        incorrectas.add(aux[B_key]!);
        correctas.add(aux[M_key]!);
        aciertos.add(aux[P_key]!);

        // deportes
        aux = responseJson[D_key];
        preguntas.add(aux[T_key]!);
        incorrectas.add(aux[B_key]!);
        correctas.add(aux[M_key]!);
        aciertos.add(aux[P_key]!);

        // arte 
        aux = responseJson[A_key];
        preguntas.add(aux[T_key]!);
        incorrectas.add(aux[B_key]!);
        correctas.add(aux[M_key]!);
        aciertos.add(aux[P_key]!);
        
      } else {
        OK = false;
        errorUsuario = responseJson[EU_key];
        
      }
    }
  }
}

// ignore: non_constant_identifier_names
Future<EstadisticasAmigoResponse> obtenerEstadisticasAmigo(EstadisticasAmigoPetition p) async {
  HttpOverrides.global = MyHttpOverrides();

  EstadisticasAmigoResponse r = EstadisticasAmigoResponse();

  final url = Uri.parse('$urlDir/api/usuarios/estadisticas-usuario/');

  final response = await http.post(url, body: {
    'username': p.username,
  });

  r.FillFields(response);
  return r;
}
