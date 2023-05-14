// import 'dart:io';
// import 'dart:math';
// import 'dart:async';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// import 'package:flutter_application_1/API/api.dart';
// import 'package:flutter_application_1/Data_types/index.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/Interfaz/Juego/juego.dart';
// import 'package:flutter_application_1/Data_types/sesion.dart';

// class CrearBuscarPartida extends StatelessWidget {
//   const CrearBuscarPartida({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: _CrearBuscarPartida(),
//     );
//   }
// }

// class _CrearBuscarPartida extends StatefulWidget {
//   @override
//   __CrearBuscarPartidaState createState() => __CrearBuscarPartidaState();
// }

// class __CrearBuscarPartidaState extends State<_CrearBuscarPartida> {
//  void crearPartida() async {
//     _formKey.currentState!.save();
//     String aux = "";
//     String tipoPartida = "";
//     if (!_partidaPublica) {
//       aux = _dSPC.getField(DatosSalaPartidaClasicaFieldsCodes.contrasena);
//     }

//     if (_modoClasico) {
//       tipoPartida = "Clasico";
//     } else if (_modoEquipos) {
//       tipoPartida = "Equipo";
//     } else {
//       tipoPartida = "Tematico";
//     }
//     Future<CrearSalaResponse> f = crearSalaPartida(
//         CrearSalaPetition(
//             _dSPC.getField(DatosSalaPartidaClasicaFieldsCodes.nombre),
//             _dSPC.getField(DatosSalaPartidaClasicaFieldsCodes.tiempoRespuesta),
//             aux,
//             _dSPC.getField(DatosSalaPartidaClasicaFieldsCodes.numeroJugadores),
//             tipoPartida),
//         _s.getField(SesionFieldsCodes.token));
//     CrearSalaResponse r = await f;
//     if (r.OK) {
//       // ignore: use_build_context_synchronously
//       /*Navigator.pushAndRemoveUntil(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => IniciandoSesion(
//                     Sesion(usuario: _usuario, token: r.token), _contrasena)),
//             (Route<dynamic> route) => false);*/
//     } else {
//       _errorCampos = true;
//       if (r.errorNombreSala != "") {
//         _errorCambioDatos = r.errorNombreSala;
//       } else if (r.errorNJugadores != "") {
//         _errorCambioDatos = r.errorNJugadores;
//       } else if (r.errorTiempoRespuesta != "") {
//         _errorCambioDatos = r.errorTiempoRespuesta;
//       } else if (r.errorTipoPartida != "") {
//         _errorCambioDatos = r.errorTipoPartida;
//       }
//       setState(() {});
//     }
//   }



//   Color Azul = Colors.blue;
//   Color Naranja = Color.fromARGB(255, 240, 143, 17);
//   Color Rojo = Color.fromARGB(255, 230, 44, 19);
//   Color Rosa = Color.fromARGB(255, 231, 19, 185);
//   Color Verde = Color.fromARGB(255, 53, 224, 18);
//   Color Amarillo = Color.fromARGB(255, 231, 235, 42);
//   Color Blanco = Color.fromARGB(255, 255, 255, 255);

//   @override
//   Widget build(BuildContext context) {
//     final Size screenSize = MediaQuery.of(context).size;
//     return Scaffold(
//       body: Container(
//         width: screenSize.width,
//         height: screenSize.height,
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('assets/tapete.png'),
//             fit: BoxFit.fill,
//           ),
//         ),
//         child: Stack(
//           children: [
//             Positioned(
//               top: screenSize.height / 2 - 50,
//               left: screenSize.width / 2 - 50,
//               child: Stack(
//                 children: [
//                   Transform.translate(  
//                     offset: const Offset(-345, -150),
//                     child: const Padding(
//                       padding: EdgeInsets.only(top: 180, left: 168), // ajusta los valores según tus necesidades
//                       child: Boton(texto: 'BUSCAR PARTIDA', ruta: Juego()),
//                     ),
//                   ),
//                   Transform.translate(  
//                     offset: const Offset(-90, -150),
//                     child: const Padding(
//                       padding: EdgeInsets.only(top: 180, left: 168), // ajusta los valores según tus necesidades
//                       child: Boton(texto: 'CREAR PARTIDA', ruta: Juego()),
//                     ),
//                   ),
//                   Transform.translate(  //Imagen J1
//                     offset: const Offset(130, -45),
//                     child: Container(
//                       width: 70,
//                       height: 70,
//                       decoration: const BoxDecoration(
//                         image: DecorationImage(
//                           image: AssetImage('assets/mas.png'),
//                           fit: BoxFit.fill,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Transform.translate(  //Imagen J1
//                     offset: const Offset(-115, -45),
//                     child: Container(
//                       width: 70,
//                       height: 70,
//                       decoration: const BoxDecoration(
//                         image: DecorationImage(
//                           image: AssetImage('assets/lupa.png'),
//                           fit: BoxFit.fill,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class Boton extends StatelessWidget {
//   final String texto;
//   final Widget ruta;
  
//   const Boton({required this.texto, required this.ruta});

//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(4),
//       child: Stack(
//         children: <Widget>[
//           Positioned.fill(
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(30),
//                 gradient: const LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: <Color>[Color(0xFFdee8eb), Color(0xFFb0c7d0)],
//                   stops: [0.4, 1.0],
//                 ),
//               ),
//             ),
//           ),
//           TextButton(
//             style: TextButton.styleFrom(
//               foregroundColor: const Color(0xFF004461),
//               padding:
//                   const EdgeInsets.only(top: 4, bottom: 4, left: 15, right: 15),
//               textStyle: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 18,
//                   fontFamily: "Georgia"),
//             ),
//             onPressed: () async {
//               // Navigator.push(
//               //   context,
//               //   MaterialPageRoute(builder: (context) => ruta),
//               // );
//               String t = "NBi06VGyZ80o7u1u0CaSf9pY1HF75dnh6cmubNM8LsQF1aVtWslfZxMXnfdYauQj";
//               String ns = "salaPru";
//               int tr = 5;
//               String ps = "123456789";
//               int nj = 2;
//               String tp = "clasico";
//               Future<CrearSalaResponse> f = CrearSala(CrearSalaPetition(t, ns, tr, ps, nj, tp) );
//               CrearSalaResponse r = await f;

//               if (r.OK){
//                 print("SALA CREADA CORRECTAMENTE");
//               }else{
//                 print("SALA MAL CREADA");
//                 // print("error_ns: " + r.error_nombre_sala);
//                 // print("error_tp: " + r.error_tipo_partida);
//                 // print("error_nj: " + r.error_n_jugadores);
//                 // print("error_tr: " + r.error_tiempo_respuesta);
//               }
//             },
//             child: Text(texto),
//           ),
//         ],
//       ),
//     );
//   }
// }


// //CREAR SALA
// // const String urlDir = 'http://51.142.118.71:8000';
// // class CrearSalaPetition {
// //   final String token, nombre_sala, password_sala, tipo_partida;
// //   final int tiempo_respuesta, n_jugadores;
// //   const CrearSalaPetition(String t, String ns, int tr, String ps, int nj, String tp)
// //       : token = t,
// //         nombre_sala = ns,
// //         tiempo_respuesta = tr,
// //         password_sala = ps,
// //         n_jugadores = nj,
// //         tipo_partida = tp;
// // }

// // class CrearSalaResponse {
// //   // ignore: constant_identifier_names
// //   static const String OK_key = 'OK',
// //       eNS_key = 'error_nombre_sala',
// //       eTP_key = 'error_tipo_partida',
// //       eNJ_key = 'error_n_jugadores',
// //       eTR_key = 'error_tiempo_respuesta';
// //   // ignore: non_constant_identifier_names
// //   String error_nombre_sala = "", error_tipo_partida = "", error_n_jugadores = "", error_tiempo_respuesta = "";
// //   // ignore: non_constant_identifier_names
// //   bool OK = false;

// //   CrearSalaResponse();

// //   // ignore: non_constant_identifier_names
// //   void FillFields(http.Response r) {
// //     if (r.statusCode <= 300) {
// //       final responseJson = json.decode(utf8.decode(r.bodyBytes));

// //       String parameterValue = responseJson[OK_key];

// //       if (parameterValue == 'True') {
// //         OK = true;
// //       } else {
// //         OK = false;
// //         error_nombre_sala = responseJson[eNS_key];
// //         error_tipo_partida = responseJson[eTP_key];
// //         error_n_jugadores = responseJson[eNJ_key];
// //         error_tiempo_respuesta = responseJson[eTR_key];
// //         print(error_nombre_sala);
// //         print(error_tipo_partida);
// //         print(error_n_jugadores);
// //         print(error_tiempo_respuesta);
// //       }
// //     }
// //   }
// // }

// // class MyHttpOverrides extends HttpOverrides {
// //   @override
// //   HttpClient createHttpClient(SecurityContext? context) {
// //     return super.createHttpClient(context)
// //       ..badCertificateCallback =
// //           (X509Certificate cert, String host, int port) => true;
// //   }
// // }

// // Future<CrearSalaResponse> CrearSala(CrearSalaPetition p) async {
// //   HttpOverrides.global = MyHttpOverrides();

// //   CrearSalaResponse r = CrearSalaResponse();

// //   final url = Uri.parse('$urlDir/api/salas/crear/');

// //   final response = await http.post(url, body: {
// //     'token': p.token,
// //     'nombre_sala': p.nombre_sala,
// //     'tiempo_respuesta': p.tiempo_respuesta.toString(),
// //     'password_sala': p.password_sala,
// //     'n_jugadores': p.n_jugadores.toString(),
// //     'tipo_partida': p.tipo_partida,
    
// //   });

// //   r.FillFields(response);
// //   return r;
// // }




// class CrearSalaPetition {
//   static const String modoClasico = "Clasico",
//       modoEquipos = "Equipo",
//       modoTematica = "Tematico",
//       NS_key = 'nombre_sala',
//       TR_key = 'tiempo_respuesta',
//       PS_key = 'password_sala',
//       NJ_key = 'n_jugadores',
//       TP_key = 'tipo_partida';

//   // ignore: non_constant_identifier_names
//   String nombreSala,
//       tiempoRespuesta,
//       contrasenaSala,
//       numeroJugadores,
//       tipoPartida;
//   CrearSalaPetition(String nS, String tR, String cS, String nJ, String tP)
//       : nombreSala = nS,
//         tiempoRespuesta = tR,
//         contrasenaSala = cS,
//         numeroJugadores = nJ,
//         tipoPartida = tP;
// }

// class CrearSalaResponse {
//   // ignore: constant_identifier_names
//   static const String OK_key = 'OK',
//       ENS_key = 'error_nombre_sala',
//       ETP_key = 'error_tipo_partida',
//       ENJ_key = 'error_n_jugadores',
//       ETR_key = 'error_tiempo_respuesta';
//   // ignore: non_constant_identifier_names
//   String errorNombreSala = "",
//       errorTipoPartida = "",
//       errorNJugadores = "",
//       errorTiempoRespuesta = "";
//   // ignore: non_constant_identifier_names
//   bool OK = false;

//   CrearSalaResponse();

//   // ignore: non_constant_identifier_names
//   void FillFields(http.Response r) {
//     if (r.statusCode <= 300) {
//       final responseJson = json.decode(utf8.decode(r.bodyBytes));

//       String parameterValue = responseJson[OK_key];

//       if (parameterValue == 'True') {
//         OK = true;
//         errorNombreSala = responseJson[ENS_key];
//         errorTipoPartida = responseJson[ETP_key];
//         errorNJugadores = responseJson[ENJ_key];
//         errorTiempoRespuesta = responseJson[ENJ_key];
//       } else {
//         OK = false;
//       }
//     }
//   }
// }

// // ignore: non_constant_identifier_names
// Future<CrearSalaResponse> crearSalaPartida(
//     CrearSalaPetition p, String token) async {
//   HttpOverrides.global = MyHttpOverrides();

//   CrearSalaResponse r = CrearSalaResponse();

//   final url = Uri.parse('$urlDir/api/salas/crear/');

//   final response = await http.post(url, headers: {
//     'Authorization': "Token $token",
//   }, body: {
//     CrearSalaPetition.NS_key: p.nombreSala,
//     CrearSalaPetition.NJ_key: p.numeroJugadores,
//     CrearSalaPetition.PS_key: p.contrasenaSala,
//     CrearSalaPetition.TR_key: p.tiempoRespuesta,
//     CrearSalaPetition.TP_key: p.tipoPartida
//   });

//   r.FillFields(response);
//   return r;
// }