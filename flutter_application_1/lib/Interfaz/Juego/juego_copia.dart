import 'dart:io';
import 'dart:math';
import 'dart:async';
import 'dart:ui';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_application_1/Interfaz/Menu/home.dart';
import 'package:flutter/services.dart';
import 'package:web_socket_channel/io.dart';

class Juego2 extends StatelessWidget {
  const Juego2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _Juego(),
    );
  }
}

class _Juego extends StatefulWidget {
  @override
  __JuegoState createState() => __JuegoState();
}

class __JuegoState extends State<_Juego> {
  Color Azul = Colors.blue;
  Color Naranja = const Color.fromARGB(255, 240, 143, 17);
  Color Rojo = const Color.fromARGB(255, 230, 44, 19);
  Color Rosa = const Color.fromARGB(255, 230, 32, 187);
  Color Verde = const Color.fromARGB(255, 53, 224, 18);
  Color Amarillo = const Color.fromARGB(255, 219, 205, 0);
  Color Blanco = const Color.fromARGB(255, 255, 255, 255);
  Color colorPregunta = Colors.blue;
  Color Gris = Colors.grey;
  bool ok = false;


  // List<Color> colorCasillasFijo = [ const Color.fromARGB(255, 255, 255, 255), const Color.fromARGB(255, 240, 143, 17),
  //                               const Color.fromARGB(255, 255, 255, 255), const Color.fromARGB(255, 219, 205, 0), 
  //                               const Color.fromARGB(255, 230, 44, 19), const Color.fromARGB(255, 255, 255, 255), 
  //                               Colors.blue, const Color.fromARGB(255, 255, 255, 255),
  //                               Colors.blue, const Color.fromARGB(255, 255, 255, 255),
  //                               const Color.fromARGB(255, 240, 143, 17), const Color.fromARGB(255, 53, 224, 18),
  //                               const Color.fromARGB(255, 255, 255, 255),const Color.fromARGB(255, 230, 44, 19), 
  //                               const Color.fromARGB(255, 255, 255, 255),const Color.fromARGB(255, 230, 44, 19), 
  //                               const Color.fromARGB(255, 255, 255, 255),Colors.blue,
  //                               const Color.fromARGB(255, 230, 32, 187), const Color.fromARGB(255, 255, 255, 255), 
  //                               const Color.fromARGB(255, 53, 224, 18), const Color.fromARGB(255, 255, 255, 255), 
  //                               const Color.fromARGB(255, 53, 224, 18), const Color.fromARGB(255, 255, 255, 255), 
  //                               const Color.fromARGB(255, 230, 44, 19), const Color.fromARGB(255, 219, 205, 0), 
  //                               const Color.fromARGB(255, 255, 255, 255), const Color.fromARGB(255, 230, 32, 187), 
  //                               const Color.fromARGB(255, 255, 255, 255), const Color.fromARGB(255, 230, 32, 187), 
  //                               const Color.fromARGB(255, 255, 255, 255), const Color.fromARGB(255, 53, 224, 18),
  //                               const Color.fromARGB(255, 240, 143, 17), const Color.fromARGB(255, 255, 255, 255), 
  //                               const Color.fromARGB(255, 219, 205, 0), const Color.fromARGB(255, 255, 255, 255), 
  //                               const Color.fromARGB(255, 219, 205, 0), const Color.fromARGB(255, 255, 255, 255), 
  //                               const Color.fromARGB(255, 230, 32, 187), Colors.blue,
  //                               const Color.fromARGB(255, 255, 255, 255), const Color.fromARGB(255, 240, 143, 17),
  //                               const Color.fromARGB(255, 240, 143, 17), const Color.fromARGB(255, 219, 205, 0), 
  //                               Colors.blue, const Color.fromARGB(255, 230, 44, 19), 
  //                               const Color.fromARGB(255, 230, 32, 187), Colors.blue,
  //                               const Color.fromARGB(255, 240, 143, 17), const Color.fromARGB(255, 230, 44, 19), 
  //                               const Color.fromARGB(255, 53, 224, 18), const Color.fromARGB(255, 219, 205, 0),
  //                               const Color.fromARGB(255, 230, 44, 19), Colors.blue,
  //                               const Color.fromARGB(255, 53, 224, 18), const Color.fromARGB(255, 230, 32, 187),
  //                               const Color.fromARGB(255, 240, 143, 17), const Color.fromARGB(255, 53, 224, 18),
  //                               const Color.fromARGB(255, 230, 44, 19), const Color.fromARGB(255, 230, 32, 187),
  //                               const Color.fromARGB(255, 219, 205, 0), Colors.blue,
  //                               const Color.fromARGB(255, 230, 32, 187), const Color.fromARGB(255, 53, 224, 18),
  //                               const Color.fromARGB(255, 219, 205, 0), const Color.fromARGB(255, 240, 143, 17),
  //                               const Color.fromARGB(255, 230, 44, 19), const Color.fromARGB(255, 219, 205, 0),
  //                               const Color.fromARGB(255, 230, 32, 187), const Color.fromARGB(255, 240, 143, 17),
  //                               Colors.blue, const Color.fromARGB(255, 53, 224, 18),
  //                               const Color.fromARGB(255, 255, 255, 255), 
  //                             ];

  List<Color> colorCasillas = [ const Color.fromARGB(255, 255, 255, 255), const Color.fromARGB(255, 240, 143, 17),
                                const Color.fromARGB(255, 255, 255, 255), const Color.fromARGB(255, 219, 205, 0), 
                                const Color.fromARGB(255, 230, 44, 19), const Color.fromARGB(255, 255, 255, 255), 
                                Colors.blue, const Color.fromARGB(255, 255, 255, 255),
                                Colors.blue, const Color.fromARGB(255, 255, 255, 255),
                                const Color.fromARGB(255, 240, 143, 17), const Color.fromARGB(255, 53, 224, 18),
                                const Color.fromARGB(255, 255, 255, 255),const Color.fromARGB(255, 230, 44, 19), 
                                const Color.fromARGB(255, 255, 255, 255),const Color.fromARGB(255, 230, 44, 19), 
                                const Color.fromARGB(255, 255, 255, 255),Colors.blue,
                                const Color.fromARGB(255, 230, 32, 187), const Color.fromARGB(255, 255, 255, 255), 
                                const Color.fromARGB(255, 53, 224, 18), const Color.fromARGB(255, 255, 255, 255), 
                                const Color.fromARGB(255, 53, 224, 18), const Color.fromARGB(255, 255, 255, 255), 
                                const Color.fromARGB(255, 230, 44, 19), const Color.fromARGB(255, 219, 205, 0), 
                                const Color.fromARGB(255, 255, 255, 255), const Color.fromARGB(255, 230, 32, 187), 
                                const Color.fromARGB(255, 255, 255, 255), const Color.fromARGB(255, 230, 32, 187), 
                                const Color.fromARGB(255, 255, 255, 255), const Color.fromARGB(255, 53, 224, 18),
                                const Color.fromARGB(255, 240, 143, 17), const Color.fromARGB(255, 255, 255, 255), 
                                const Color.fromARGB(255, 219, 205, 0), const Color.fromARGB(255, 255, 255, 255), 
                                const Color.fromARGB(255, 219, 205, 0), const Color.fromARGB(255, 255, 255, 255), 
                                const Color.fromARGB(255, 230, 32, 187), Colors.blue,
                                const Color.fromARGB(255, 255, 255, 255), const Color.fromARGB(255, 240, 143, 17),
                                const Color.fromARGB(255, 240, 143, 17), const Color.fromARGB(255, 219, 205, 0), 
                                Colors.blue, const Color.fromARGB(255, 230, 44, 19), 
                                const Color.fromARGB(255, 230, 32, 187), Colors.blue,
                                const Color.fromARGB(255, 240, 143, 17), const Color.fromARGB(255, 230, 44, 19), 
                                const Color.fromARGB(255, 53, 224, 18), const Color.fromARGB(255, 219, 205, 0),
                                const Color.fromARGB(255, 230, 44, 19), Colors.blue,
                                const Color.fromARGB(255, 53, 224, 18), const Color.fromARGB(255, 230, 32, 187),
                                const Color.fromARGB(255, 240, 143, 17), const Color.fromARGB(255, 53, 224, 18),
                                const Color.fromARGB(255, 230, 44, 19), const Color.fromARGB(255, 230, 32, 187),
                                const Color.fromARGB(255, 219, 205, 0), Colors.blue,
                                const Color.fromARGB(255, 230, 32, 187), const Color.fromARGB(255, 53, 224, 18),
                                const Color.fromARGB(255, 219, 205, 0), const Color.fromARGB(255, 240, 143, 17),
                                const Color.fromARGB(255, 230, 44, 19), const Color.fromARGB(255, 219, 205, 0),
                                const Color.fromARGB(255, 230, 32, 187), const Color.fromARGB(255, 240, 143, 17),
                                Colors.blue, const Color.fromARGB(255, 53, 224, 18),
                                const Color.fromARGB(255, 255, 255, 255), 
                              ];
  

  void _cambiarColor2(String tema) {
    if(tema == "historia"){
      setState(() {
        colorPregunta = Amarillo;
      });
    }else if(tema == "arte"){
      setState(() {
        colorPregunta = Rojo;
      });
    }else if(tema == "ciencia"){
      setState(() {
        colorPregunta = Verde;
      });
    }else if(tema == "geografia"){
      setState(() {
        colorPregunta = Azul;
      });
    }else if(tema == "deporte"){
      setState(() {
        colorPregunta = Naranja;
      });
    }else if(tema == "entretenimiento"){
      setState(() {
        colorPregunta = Rosa;
      });
    }    
  }

  List<bool> casillaCambia = [false, false, false, false, false, false, false, false, false, false, false, false, false, false,
                              false, false, false, false, false, false, false, false, false, false, false, false, false, false,
                              false, false, false, false, false, false, false, false, false, false, false, false, false, false,
                              false, false, false, false, false, false, false, false, false, false, false, false, false, false,
                              false, false, false, false, false, false, false, false, false, false, false, false, false, false,
                              false, false, false,];

  List<Color> colorVariado = [Colors.grey, Colors.grey, Colors.grey, Colors.grey, Colors.grey, Colors.grey, Colors.grey,
                              Colors.grey, Colors.grey, Colors.grey, Colors.grey, Colors.grey, Colors.grey, Colors.grey,
                              Colors.grey, Colors.grey, Colors.grey, Colors.grey, Colors.grey, Colors.grey, Colors.grey,
                              Colors.grey, Colors.grey, Colors.grey, Colors.grey, Colors.grey, Colors.grey, Colors.grey, 
                              Colors.grey, Colors.grey, Colors.grey, Colors.grey, Colors.grey, Colors.grey, Colors.grey,
                              Colors.grey, Colors.grey, Colors.grey, Colors.grey, Colors.grey, Colors.grey, Colors.grey,
                              Colors.grey, Colors.grey, Colors.grey, Colors.grey, Colors.grey, Colors.grey, Colors.grey,
                              Colors.grey, Colors.grey, Colors.grey, Colors.grey, Colors.grey, Colors.grey, Colors.grey,
                              Colors.grey, Colors.grey, Colors.grey, Colors.grey, Colors.grey, Colors.grey, Colors.grey,
                              Colors.grey, Colors.grey, Colors.grey, Colors.grey, Colors.grey, Colors.grey, Colors.grey,
                              Colors.grey, Colors.grey, Colors.grey,];
  

  //Color colorVariado = Colors.grey;
  late Timer _t;
  Color _getNextColor(int casilla) { //Si el color actual es gris se pone de su color y sino se pone gris
    if (colorVariado[casilla] == Colors.grey) {
      return colorCasillas[casilla];
    } else{
      return Colors.grey;
    }
  }

  void initState() {
    super.initState();
    _t = Timer.periodic(Duration(milliseconds: 500), (t) {
      setState(() {
        // colorVariado[0] = _getNextColor(0); // Cambia el color del cuadrado
        colorVariado[1] = _getNextColor(1);
        // colorVariado[2] = _getNextColor(2);
        // colorVariado[3] = _getNextColor(3);
        // colorVariado[4] = _getNextColor(4);
        // colorVariado[5] = _getNextColor(5);
        colorVariado[6] = _getNextColor(6);
      });
    });
  }

  void dispose2() {
    _t.cancel(); // Cancela el temporizador al cerrar la pantalla
    super.dispose();
  }

  void pulsar(int casilla){
    if(casillaCambia[casilla]){
      casillaCambia[casilla] = false;
    }else{
      casillaCambia[casilla] = true;
    }
  }


  // void _cambiarColor2() {
  //   setState(() {
  //     Bcolor2 = Colors.green;
  //   });
  // }
  // void _cambiarColor1() {
  //   setState(() {
  //     Bcolor1 = Colors.green;
  //   });
  // }

  //CONTADOR--------------------------------------------------------
  int _countdownTime = 10;
  Timer? _timer;
  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdownTime > 0) {
          _countdownTime--;
        } else {
          timer.cancel();
        }
      });
    });
  }
  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  //DADO------------------------------------------------------------
  int _diceNumber = 1;
  int turno = 1;

  void _rollDice() {
    setState(() {
      _diceNumber = Random().nextInt(6) + 1;
      turno = 0;
    });
  }

  void _resetTurno() {
    setState(() {
      turno = 1;
    });
  }

  //RELACIONADO CON PREGUNTA-------------------------------------------------------------
  bool preguntaActiva = false;
  String preguntaTema = "";
  String pregunta = "";
  String respuesta1 = "";
  String respuesta2 = "";
  String respuesta3 = "";
  String respuesta4 = "";
  Color ColorRespuesta1 = const Color.fromARGB(255, 255, 255, 255);
  Color ColorRespuesta2 = const Color.fromARGB(255, 255, 255, 255);
  Color ColorRespuesta3 = const Color.fromARGB(255, 255, 255, 255);
  Color ColorRespuesta4 = const Color.fromARGB(255, 255, 255, 255);

  void mostrarPregunta(){
    ColorRespuesta1 = const Color.fromARGB(255, 255, 255, 255);
    ColorRespuesta2 = const Color.fromARGB(255, 255, 255, 255);
    ColorRespuesta3 = const Color.fromARGB(255, 255, 255, 255);
    ColorRespuesta4 = const Color.fromARGB(255, 255, 255, 255);
    preguntaActiva = true;
  }
  void ocultarPregunta(){
    preguntaActiva = false;
  }

  void cambiarPregunta(String _preguntaTema, String _pregunta, String _respuesta1, String _respuesta2, String _respuesta3, String _respuesta4) {
    setState(() {
      preguntaTema = _preguntaTema;
      pregunta = _pregunta;
      respuesta1 = _respuesta1;
      respuesta2 = _respuesta2;
      respuesta3 = _respuesta3;
      respuesta4 = _respuesta4;
    });
  }

  void colorRespuesta(int numRespuesta, bool bien){
    if(bien){
      if(numRespuesta == 1){
        ColorRespuesta1 = Color.fromARGB(255, 37, 163, 12);
      }else if(numRespuesta == 2){
        ColorRespuesta2 = Color.fromARGB(255, 37, 163, 12);
      }else if(numRespuesta == 3){
        ColorRespuesta3 = Color.fromARGB(255, 37, 163, 12);
      }else if(numRespuesta == 4){
        ColorRespuesta4 = Color.fromARGB(255, 37, 163, 12);
      }
    }else{
      if(numRespuesta == 1){
        ColorRespuesta1 = Color.fromARGB(255, 148, 28, 13);
      }else if(numRespuesta == 2){
        ColorRespuesta2 = Color.fromARGB(255, 148, 28, 13);
      }else if(numRespuesta == 3){
        ColorRespuesta3 = Color.fromARGB(255, 148, 28, 13);
      }else if(numRespuesta == 4){
        ColorRespuesta4 = Color.fromARGB(255, 148, 28, 13);
      }
    }
  }

  //ACTIVOS?------------------------------------
  List<bool> jVisibles = [true,true,true,true,true,true];
  //JUGADORES-------------------------------------
  int numJ = 6; //numero de jugadores en la partida
  List<String> nombresJugadores = ['j1','j2','j3','j4','j5','j6'];
  //IMAGENES------------------------------
  List<String> imagenesJugadores = ['assets/perfil.png','assets/perfil.png','assets/perfil.png','assets/perfil.png','assets/perfil.png','assets/perfil.png'];
  //FICHAS---------------------------
  List<String> fichasJugadores = ['http://51.142.118.71:8000/static/images/objetos/1-amarillo.png','http://51.142.118.71:8000/static/images/objetos/1-rojo.png',
                                  'http://51.142.118.71:8000/static/images/objetos/1-rosa.png','http://51.142.118.71:8000/static/images/objetos/1-verde.png',
                                  'http://51.142.118.71:8000/static/images/objetos/1-azul.png','http://51.142.118.71:8000/static/images/objetos/1-naranja.png'];
  //------------------------------------------

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> WEB SOCKET <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<//
      //ANOTACIONES----------------------------------------------------------------------------------------//
      //-Creo que al meter aqui las opciones de ejecución del socket se comprobaran y repecto a esos datos
      //    hacemos el build del tablero
      //
      //
      //FIN ANOTACIONES-----------------------------------------------------------------------------------//
  bool msgIni = true;

  void cargarEstado_nombresImagenesJug(List<String> r_nombres){
    int j = 0;
    for(var n in r_nombres){
      nombresJugadores[j] = n;
      j++;
    }
  }

  void cargarEstado_fichasJug(List<String> r_fichas){
    int j = 0;
    for(var n in r_fichas){
      fichasJugadores[j] = n;
      j++;
    }
  }

  //hace visibles los nombres, imagenes y quesitos de los jugadores de la partida
  void habilitarJugadores(){
    for(int p=0;p < numJ;p++){
      jVisibles[p] = true;
    }
  }

  void ejecutarSocket(){
    final channel = IOWebSocketChannel.connect('');

    if(msgIni){
      msgIni = false;
      channel.stream.listen((message){
      Map<String, dynamic> decodedResponse = json.decode(message);
      String r_ok = decodedResponse['OK'];
      List<dynamic> r_jugadores = decodedResponse['jugadores'];
      List<String> r_nombres = [];
      List<String> r_posiciones = [];
      List<List<dynamic>> r_quesitos = [];
      List<String> r_turnos = [];
      List<String> r_fichas = [];
      List<String> r_tableros = [];
      List<bool> r_activos = [];
      // String r_type = decodedResponse['type'];
      // String r_subtype = decodedResponse['subtype'];
      for(var jugador in r_jugadores){
        //Esto lo puedo comprimir con lo de abajo
        String nombre = jugador['jugador'];
        String posicion = jugador['posicion'];
        List<dynamic> quesitos = jugador['quesitos'];
        String turno = jugador['turno'];
        String ficha = jugador['ficha'];
        String tablero = jugador['tablero'];
        bool activo = jugador['activo'];
        
        r_nombres.add(nombre);
        r_posiciones.add(posicion);
        r_quesitos.add(quesitos);
        r_turnos.add(turno);
        r_fichas.add(ficha);
        r_tableros.add(tablero);
        r_activos.add(activo);
      }
      String r_tiempo_pregunta = decodedResponse['tiempo_pregunta'];
      String r_tiempo_elegir_casilla = decodedResponse['tiempo_elegir_casilla'];
      String r_error = decodedResponse['error'];

      //CARGAR JUGADORES
      if(r_ok == "true"){
        numJ = r_jugadores.length;
        cargarEstado_nombresImagenesJug(r_nombres);
        
        //cargarEstado_posicionesJug(Njugadores, r_posiciones);
        //cargarEstado_quesosJug(Njugadores, r_quesitos);

        cargarEstado_fichasJug(r_fichas);
        
        //¿como cargo un tablero para cada usuario?
        //cargarEstado_tablerosJug();Tengo que cargar un tablero para cada usuario
      }

      });
    }
    

      // switch(r_type){
      //   case "Respuesta":
      //     print("tipo: Respuesta");

      //     switch (r_subtype){
      //       case "Dado_casillas":
      //         print("subtipo: Dado_casillas");
      //       break;

      //       case "Pregunta":
      //         print("subtipo: Pregunta");
      //       break;
      //     }
      //   break;

      //   case "Accion":
      //     print("tipo: Accion");

      //     switch (r_subtype){
      //       case "Dados":
      //         print("subtipo: Dados");
      //       break;
      //     }
      //   break;

      //   case "Fin":
      //     print("tipo: Fin");
      //   break;

      //   case "Chat":
      //     print("tipo: Chat");
      //   break;

      //   case "Peticion":
      //     print("tipo: Peticion");

      //     switch (r_subtype){
      //       case "Tirar_dado":
      //         print("subtipo: Tirar_dado");
      //       break;

      //       case "Movimiento_casilla":
      //         print("subtipo: Movimiento_casilla");
      //       break;
      //     }
      //   break;

      //   case "Actualizacion":
      //     print("tipo: Actualizacion");

      //     switch (r_subtype){
      //       case "Pausar_partida":
      //         print("subtipo: Pausar_partida");
      //       break;

      //       case "Continuar_partida":
      //         print("subtipo: Continuar_partida");
      //       break;

      //       case "Contestar_pregunta":
      //         print("subtipo: Contestar_pregunta");

      //         if(enunciado == "noContestada"){

      //         }else{
      //           switch (r_subtype){
      //             case "Ciencia":
      //             break;

      //             case "Arte":
      //             break;

      //             case "Deportes":
      //             break;

      //             case "Entretenimiento":
      //             break;

      //             case "Geografia":
      //             break;

      //             case "Historia":
      //             break;
      //           }
      //         }
      //       break;

      //       case "Fin_partida":
      //       break;
      //     }
      //   break;
      //}

    
  }
  
  
  
// bool parpadeoOON = true;
// Future<void> prueba() async {
//   while (true) {
//     // cambiar el valor de parpadeoOON a true para que el botón sea visible
//     setState(() {
//       parpadeoOON = true;
//     });
    
//     // esperar 500 milisegundos
//     await Future.delayed(Duration(milliseconds: 500));
    
//     // cambiar el valor de parpadeoOON a false para que el botón sea invisible
//     setState(() {
//       parpadeoOON = false;
//     });
    
//     // esperar 500 milisegundos
//     await Future.delayed(Duration(milliseconds: 500));
//   }
// }




//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> FIN WEB SOCKET <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<//

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/tapete.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: screenSize.height / 2 - 50, // ajustar la posición vertical del hexágono
              left: screenSize.width / 2 - 50, // ajustar la posición horizontal del hexágono
              child: Stack(
                children: [
                  
                  Transform.translate(  //Contador
                    offset: const Offset(-150, -128),
                    child: Text(
                      '$_countdownTime',
                      style: TextStyle(fontSize: 48),
                    ),
                  ),
                  
                  Visibility(
                    visible: jVisibles[0],
                    child: Transform.translate(  //Texto J0
                      offset: const Offset(-262, -128),
                      child: Text(
                        nombresJugadores[0],
                        style: const TextStyle(
                          fontFamily: "Baskerville",
                          fontSize: 12.0,
                          //color: Color(0xFFc9c154),
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: jVisibles[0],
                    child: Transform.translate(  //Imagen J0
                      offset: const Offset(-265, -110),
                      child: Container(
                        width: 70,
                        height: 70,
                        // decoration: const BoxDecoration(
                        //   image: DecorationImage(
                        //     image: AssetImage(img),
                        //     fit: BoxFit.fill,
                        //   ),
                        // ),
                        child: Image(image: AssetImage(imagenesJugadores[0]),fit: BoxFit.fill,),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: jVisibles[0],
                    child: Transform.translate(  //Putos J0
                      offset: const Offset(-205, -60),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/trivial_blanco.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),
                  

                  Visibility(
                    visible: jVisibles[1],
                    child: Transform.translate(  //Texto J1
                      offset: const Offset(-262, -8),
                      child: Text(
                        nombresJugadores[1],
                        style: const TextStyle(
                          fontFamily: "Baskerville",
                          fontSize: 12.0,
                          //color: Color(0xFFc9c154),
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: jVisibles[1],
                    child: Transform.translate(  //Imagen J1
                      offset: const Offset(-265, 10),
                      child: Container(
                        width: 70,
                        height: 70,
                        child: Image(image: AssetImage(imagenesJugadores[1]),fit: BoxFit.fill,),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: jVisibles[1],
                    child: Transform.translate(  //Putos J1
                      offset: const Offset(-205, 60),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/trivial_blanco.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Visibility(
                    visible: jVisibles[2],
                    child: Transform.translate(  //Texto J2
                      offset: const Offset(-262, 112),
                      child: Text(
                        nombresJugadores[2],
                        style: const TextStyle(
                          fontFamily: "Baskerville",
                          fontSize: 12.0,
                          //color: Color(0xFFc9c154),
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: jVisibles[2],
                    child:Transform.translate(  //Imagen J2
                      offset: const Offset(-265, 130),
                      child: Container(
                        width: 70,
                        height: 70,
                        child: Image(image: AssetImage(imagenesJugadores[2]),fit: BoxFit.fill,),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: jVisibles[2],
                    child: Transform.translate(  //Putos J2
                      offset: const Offset(-205, 180),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/trivial_blanco.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Visibility(
                    visible: jVisibles[3],
                    child: Transform.translate(  //Texto J3
                      offset: const Offset(293, -128),
                      child: Text(
                        nombresJugadores[3],
                        style: const TextStyle(
                          fontFamily: "Baskerville",
                          fontSize: 12.0,
                          //color: Color(0xFFc9c154),
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: jVisibles[3],
                    child: Transform.translate(  //Imagen J3
                      offset: const Offset(290, -110),
                      child: Container(
                        width: 70,
                        height: 70,
                        child: Image(image: AssetImage(imagenesJugadores[3]),fit: BoxFit.fill,),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: jVisibles[3],
                    child: Transform.translate(  //Putos J3
                      offset: const Offset(260, -60),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/trivial_blanco.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Visibility(
                    visible: jVisibles[4],
                    child: Transform.translate(  //Texto J4
                      offset: const Offset(293, -8),
                      child: Text(
                        nombresJugadores[4],
                        style: const TextStyle(
                          fontFamily: "Baskerville",
                          fontSize: 12.0,
                          //color: Color(0xFFc9c154),
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: jVisibles[4],
                    child: Transform.translate(  //Imagen J4
                      offset: const Offset(290, 10),
                      child: Container(
                        width: 70,
                        height: 70,
                        child: Image(image: AssetImage(imagenesJugadores[4]),fit: BoxFit.fill,),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: jVisibles[4],
                    child: Transform.translate(  //Putos J4
                      offset: const Offset(260, 60),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/trivial_blanco.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Visibility(
                    visible: jVisibles[5],
                    child: Transform.translate(  //Texto J5
                      offset: const Offset(293, 112),
                      child: Text(
                        nombresJugadores[5],
                        style: const TextStyle(
                          fontFamily: "Baskerville",
                          fontSize: 12.0,
                          //color: Color(0xFFc9c154),
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: jVisibles[5],
                    child: Transform.translate(  //Imagen J5
                      offset: const Offset(290, 130),
                      child: Container(
                        width: 70,
                        height: 70,
                        child: Image(image: AssetImage(imagenesJugadores[5]),fit: BoxFit.fill,),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: jVisibles[5],
                    child: Transform.translate(  //Putos J5
                      offset: const Offset(260, 180),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/trivial_blanco.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),

                  //c1 boton
                 

                  //C72
                  Transform.translate(
                    offset: const Offset(0, 0),
                    child: HexagonButton(
                      color: casillaCambia[72] == true ? colorVariado[72] : colorCasillas[72],
                      onPressed: () {
                        //_cambiardecolor2();
                        setState(() {
                          _countdownTime = 10;
                        });
                        startTimer();
                        pulsar(72);
                        print("pulsado72");
                      },
                    ),
                  ),
                  //C51
                  Transform.rotate(
                    angle: -27 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(19, 66),
                      child: RectangleButton(
                        color: ok == true ? Colors.grey : colorCasillas[51],
                        onPressed: () {
                          //_cambiarColor2();
                          print("pulsado51");
                        },
                      ),
                    ),
                  ),

                  //C50
                  Transform.rotate(
                    angle: -27 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(19, 87),
                      child: RectangleButton(
                        color: ok == true ? Colors.grey : colorCasillas[50],
                        onPressed: () {
                          //_cambiarColor2();
                          print("pulsado52");
                        },
                      ),
                    ),
                  ),
                  //C49
                  Transform.rotate(
                    angle: -27 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(19, 108),
                      child: RectangleButton(
                        color: ok == true ? Colors.grey : colorCasillas[49],
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C48
                  Transform.rotate(
                    angle: -27 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(19, 129),
                      child: RectangleButton(
                        color: ok == true ? Colors.grey : colorCasillas[48],
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C47
                  Transform.rotate(
                    angle: -27 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(19, 150),
                      child: RectangleButton(
                        color: ok == true ? Colors.grey : colorCasillas[47],
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C46
                  Transform.rotate(
                    angle: -154 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(18, -17),
                      child: RectangleButton(
                        color: ok == true ? Colors.grey : colorCasillas[46],
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C45
                  Transform.rotate(
                    angle: -154 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(18, -37),
                      child: RectangleButton(
                        color: ok == true ? Colors.grey : colorCasillas[45],
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C44
                  Transform.rotate(
                    angle: -154 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(18, -57),
                      child: RectangleButton(
                        color: ok == true ? Colors.grey : colorCasillas[44],
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C43
                  Transform.rotate(
                    angle: -154 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(18, -77),
                      child: RectangleButton(
                        color: ok == true ? Colors.grey : colorCasillas[43],
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C42
                  Transform.rotate(
                    angle: -154 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(18, -98),
                      child: RectangleButton(
                        color: ok == true ? Colors.grey : colorCasillas[42],
                        onPressed: () {
                          //_cambiarColor2();
                          print("pulsado42");
                        },
                      ),
                    ),
                  ),

                  //C6
                  Transform.rotate(
                    angle: -90 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-150, 75),
                      child: RectangleButton(
                        color: casillaCambia[6] == true ? colorVariado[6] : colorCasillas[6],
                        onPressed: () {
                          //_cambiarColor2();
                          pulsar(6);
                          print("pulsado6");
                        },
                      ),
                    ),
                  ),
                  //C5
                  Transform.rotate(
                    angle: -90 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-150, 55),
                      child: RectangleButton(
                        color: casillaCambia[5] == true ? colorVariado[5] : colorCasillas[5],
                        onPressed: () {
                          //_cambiarColor2();
                          pulsar(5);
                          print("pulsado5");
                        },
                      ),
                    ),
                  ),
                  //C4
                  Transform.rotate(
                    angle: -90 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-150, 35),
                      child: RectangleButton(
                        color: casillaCambia[4] == true ? colorVariado[4] : colorCasillas[4],
                        onPressed: () {
                          //_cambiarColor2();
                          pulsar(4);
                          print("pulsado4");
                        },
                      ),
                    ),
                  ),
                  //C3
                  Transform.rotate(
                    angle: -90 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-150, 15),
                      child: RectangleButton(
                        color: casillaCambia[3] == true ? colorVariado[3] : colorCasillas[3],
                        onPressed: () {
                          //_cambiarColor2();
                          pulsar(3);
                          print("pulsado3");
                        },
                      ),
                    ),
                  ),
                  //C2
                  Transform.rotate(
                    angle: -90 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-150, -5),
                      child: RectangleButton(
                        color: casillaCambia[2] == true ? colorVariado[2] : colorCasillas[2],
                        onPressed: () {
                          //_cambiarColor2();
                          pulsar(2);
                          print("pulsado2");
                        },
                      ),
                    ),
                  ),
                  //C1
                  Transform.rotate(
                    angle: -90 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-150, -25), //-150,-25
                      child: IgnorePointer(
                        child: RectangleButton(
                          color: casillaCambia[1] == true ? colorVariado[1] : colorCasillas[1],
                          onPressed: () {
                            //_cambiarColor2();
                            pulsar(1);
                            print("pulsado1");
                          },
                        ),
                      ),
                    ),
                  ),
                  
                      
                  //     child: ElevatedButton(
                  //       onPressed: () {
                  //         print('1');
                  //       },
                  //       child: null,
                  //       style: ButtonStyle(
                  //         minimumSize: MaterialStateProperty.all<Size>(Size(40, 20)),
                  //         backgroundColor: MaterialStateProperty.all<Color>(casillaCambia[1] == true ? colorVariado[1] : colorCasillas[1]),
                  //       ),
                  //                 ),
                  //   ),
                  // ),
                  
                  //C8
                  Transform.rotate(
                    angle: -148 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-142, -23),
                      child: RectangleButton(
                        color: ok == true ? Colors.grey : colorCasillas[8],
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C9
                  Transform.rotate(
                    angle: -148 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-142, -5),
                      child: RectangleButton(
                        color: ok == true ? Colors.grey : colorCasillas[9],
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C10
                  Transform.rotate(
                    angle: -148 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-142, 15),
                      child: RectangleButton(
                        color: ok == true ? Colors.grey : colorCasillas[10],
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C11
                  Transform.rotate(
                    angle: -148 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-142, 35),
                      child: RectangleButton(
                        color: ok == true ? Colors.grey : colorCasillas[11],
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C12
                  Transform.rotate(
                    angle: -148 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-142, 55),
                      child: RectangleButton(
                        color: ok == true ? Colors.grey : colorCasillas[12],
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C13
                  Transform.rotate(
                    angle: -148 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-142, 75),
                      child: RectangleButton(
                        color: ok == true ? Colors.grey : colorCasillas[13],
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),

                  //C7
                  Transform.rotate(
                    angle: -207 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(37, -158),
                      child: Esquina2Button(
                        color: ok == true ? Colors.grey : colorCasillas[7],
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C56
                  Transform.rotate(
                    angle: -90 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(13, 70),
                      child: RectangleButton(
                        color: ok == true ? Colors.grey : colorCasillas[56],
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C55
                  Transform.rotate(
                    angle: -90 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(13, 91),
                      child: RectangleButton(
                        color: ok == true ? Colors.grey : colorCasillas[55],
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C54
                  Transform.rotate(
                    angle: -90 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(13, 111),
                      child: RectangleButton(
                        color: ok == true ? Colors.grey : colorCasillas[54],
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C53
                  Transform.rotate(
                    angle: -90 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(13, 131),
                      child: RectangleButton(
                        color: ok == true ? Colors.grey : colorCasillas[53],
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C52
                  Transform.rotate(
                    angle: -90 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(13, 151),
                      child: RectangleButton(
                        color: ok == true ? Colors.grey : colorCasillas[52],
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C71
                  Transform.rotate(
                    angle: -90 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(13, -20),
                      child: RectangleButton(
                        color: ok == true ? Colors.grey : colorCasillas[71],
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C70
                  Transform.rotate(
                    angle: -90 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(13, -40),
                      child: RectangleButton(
                        color: ok == true ? Colors.grey : colorCasillas[70],
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C69
                  Transform.rotate(
                    angle: -90 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(13, -60),
                      child: RectangleButton(
                        color: ok == true ? Colors.grey : colorCasillas[69],
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C68
                  Transform.rotate(
                    angle: -90 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(13, -80),
                      child: RectangleButton(
                        color: ok == true ? Colors.grey : colorCasillas[68],
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C67
                  Transform.rotate(
                    angle: -90 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(13, -100),
                      child: RectangleButton(
                        color: ok == true ? Colors.grey : colorCasillas[67],
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),

                  //C41
                  Transform.rotate(
                    angle: 330 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-148, 88),
                      child: RectangleButton(
                        color: ok == true ? Colors.grey : colorCasillas[41],
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C40
                  Transform.rotate(
                    angle: 330 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-148, 68),
                      child: RectangleButton(
                        color: ok == true ? Colors.grey : colorCasillas[40],
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C39
                  Transform.rotate(
                    angle: 330 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-148, 48),
                      child: RectangleButton(
                        color: ok == true ? Colors.grey : colorCasillas[39],
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C38
                  Transform.rotate(
                    angle: 330 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-148, 28),
                      child: RectangleButton(
                        color: ok == true ? Colors.grey : colorCasillas[38],
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C37
                  Transform.rotate(
                    angle: 330 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-148, 8),
                      child: RectangleButton(
                        color: ok == true ? Colors.grey : colorCasillas[37],
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C36
                  Transform.rotate(
                    angle: 330 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-148, -13),
                      child: RectangleButton(
                        color: ok == true ? Colors.grey : colorCasillas[36],
                        onPressed: () {
                          //_cambiarColor2();
                          print("pulsado36");
                        },
                      ),
                    ),
                  ),
                  //C0
                  // Transform.rotate(
                  //   angle: 207 * pi / 180,
                  //   child: Transform.translate(
                  //     offset: const Offset(30, -178),
                  //     child: Esquina3Button(
                  //       color: casillaCambia[0] == true ? colorVariado[0] : colorCasillas[0],
                  //       onPressed: () {
                  //         //_cambiarColor2();
                  //         pulsar(0);
                  //       },
                  //     ),
                  //   ),
                  // ),

                  //C66
                  Transform.rotate(
                    angle: -207 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(19, 66),
                      child: RectangleButton(
                        color: ok == true ? Colors.grey : colorCasillas[66],
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C65
                  Transform.rotate(
                    angle: -207 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(19, 86),
                      child: RectangleButton(
                        color: ok == true ? Colors.grey : colorCasillas[65],
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C64
                  Transform.rotate(
                    angle: -207 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(19, 106),
                      child: RectangleButton(
                        color: ok == true ? Colors.grey : colorCasillas[64],
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C63
                  Transform.rotate(
                    angle: -207 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(19, 126),
                      child: RectangleButton(
                        color: ok == true ? Colors.grey : colorCasillas[63],
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C62
                  Transform.rotate(
                    angle: -207 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(19, 146),
                      child: RectangleButton(
                        color: ok == true ? Colors.grey : colorCasillas[62],
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),


                  //C29
                  Transform.rotate(
                    angle: -329 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-142, -23),
                      child: RectangleButton(
                        color: ok == true ? Colors.grey : colorCasillas[29],
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C30
                  Transform.rotate(
                    angle: -329 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-142, -5),
                      child: RectangleButton(
                        color: ok == true ? Colors.grey : colorCasillas[30],
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C31
                  Transform.rotate(
                    angle: -329 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-142, 15),
                      child: RectangleButton(
                        color: ok == true ? Colors.grey : colorCasillas[31],
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C32
                  Transform.rotate(
                    angle: -329 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-142, 35),
                      child: RectangleButton(
                        color: ok == true ? Colors.grey : colorCasillas[32],
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C33
                  Transform.rotate(
                    angle: -329 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-142, 55),
                      child: RectangleButton(
                        color: ok == true ? Colors.grey : colorCasillas[33],
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C34
                  Transform.rotate(
                    angle: -329 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-142, 75),
                      child: RectangleButton(
                        color: ok == true ? Colors.grey : colorCasillas[34],
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  

                  //C61
                  Transform.rotate(
                    angle: -331 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(18, -17),
                      child: RectangleButton(
                        color: ok == true ? Colors.grey : colorCasillas[61],
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C60
                  Transform.rotate(
                    angle: -331 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(18, -37),
                      child: RectangleButton(
                        color: ok == true ? Colors.grey : colorCasillas[60],
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C59
                  Transform.rotate(
                    angle: -331 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(18, -57),
                      child: RectangleButton(
                        color: ok == true ? Colors.grey : colorCasillas[59],
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C58
                  Transform.rotate(
                    angle: -331 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(18, -77),
                      child: RectangleButton(
                        color: ok == true ? Colors.grey : colorCasillas[58],
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C57
                  Transform.rotate(
                    angle: -331 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(18, -98),
                      child: RectangleButton(
                        color: ok == true ? Colors.grey : colorCasillas[57],
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),          

                  //C27
                  Transform.rotate(
                    angle: 90 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-140, 73),
                      child: RectangleButton(
                        color: ok == true ? Colors.grey : colorCasillas[27],
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C26
                  Transform.rotate(
                    angle: 90 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-140, 53),
                      child: RectangleButton(
                        color: ok == true ? Colors.grey : colorCasillas[26],
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C25
                  Transform.rotate(
                    angle: 90 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-140, 33),
                      child: RectangleButton(
                        color: ok == true ? Colors.grey : colorCasillas[25],
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C24
                  Transform.rotate(
                    angle: 90 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-140, 13),
                      child: RectangleButton(
                        color: ok == true ? Colors.grey : colorCasillas[24],
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C23
                  Transform.rotate(
                    angle: 90 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-140, -8),
                      child: RectangleButton(
                        color: ok == true ? Colors.grey : colorCasillas[23],
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C22
                  Transform.rotate(
                    angle: 90 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-140, -29),
                      child: RectangleButton(
                        color: ok == true ? Colors.grey : colorCasillas[22],
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),

                  //C20
                  Transform.rotate(
                    angle: 150 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-145, 75),
                      child: RectangleButton(
                        color: ok == true ? Colors.grey : colorCasillas[20],
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C19
                  Transform.rotate(
                    angle: 150 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-145, 57),
                      child: RectangleButton(
                        color: ok == true ? Colors.grey : colorCasillas[19],
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C18
                  Transform.rotate(
                    angle: 150 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-145, 38),
                      child: RectangleButton(
                        color: ok == true ? Colors.grey : colorCasillas[18],
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C17
                  Transform.rotate(
                    angle: 150 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-145, 18),
                      child: RectangleButton(
                        color: ok == true ? Colors.grey : colorCasillas[17],
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C16
                  Transform.rotate(
                    angle: 150 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-145, -2),
                      child: RectangleButton(
                        color: ok == true ? Colors.grey : colorCasillas[16],
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C15
                  Transform.rotate(
                    angle: 150 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-145, -21),
                      child: RectangleButton(
                        color: ok == true ? Colors.grey : colorCasillas[15],
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),

                  //C35
                  Transform.rotate(
                    angle: 270 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(0, -184),
                      child: EsquinaButton(
                        color: ok == true ? Colors.grey : colorCasillas[35],
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C28
                  Transform.rotate(
                    angle: -27 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-16, -164),
                      child: Esquina2Button(
                        color: ok == true ? Colors.grey : colorCasillas[28],
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C21
                  Transform.rotate(
                    angle: 30 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-8, -146),
                      child: Esquina3Button(
                        color: ok == true ? Colors.grey : colorCasillas[21],
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C14
                  Transform.rotate(
                    angle: -270 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(26, -135),
                      child: EsquinaButton(
                        color: ok == true ? Colors.grey : colorCasillas[14],
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),

                  //TrianguloRojo
                  Transform.rotate(
                    angle: 90 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(20, 137),
                      child: TriangleWidget(color: Rojo),
                    ),
                  ),

                  //TrianguloAzul
                  Transform.rotate(
                    angle: 152 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-5, 132),
                      child: TriangleWidget(color: Azul),
                    ),
                  ),

                  //TrianguloNaranja
                  Transform.rotate(
                    angle: 207 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-37, 150),
                      child: TriangleWidget(color: Naranja),
                    ),
                  ),

                  //TrianguloAmarillo
                  Transform.rotate(
                    angle: 270 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-22, 177),
                      child: TriangleWidget(color: Amarillo),
                    ),
                  ),

                  //TrianguloRosa
                  Transform.rotate(
                    angle: 332 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(10, 185),
                      child: TriangleWidget(color: Rosa),
                    ),
                  ),

                  //TrianguloVerde
                  // Transform.rotate(
                  //   angle: -330 * pi / 180,
                  //   child: Transform.translate(
                  //     offset: const Offset(33, 170),
                  //     child: TriangleWidget(color: Verde),
                  //   ),
                  // ),

                  //ImagenDado
                  Transform.translate(  
                    offset: const Offset(190, -120),
                    child: Image.asset(
                      'assets/cara$_diceNumber.png',
                      height: 50,
                    ),
                  ),
                  //BotonDado
                  Padding(
                    padding: EdgeInsets.only(top: 180, left: 168), // ajusta los valores según tus necesidades
                    child: BotonDado(
                      'Tirar',
                      onPressed: _rollDice,
                      turno: turno,
                    ),
                  ),
                  //BotonSalir
                  // Transform.translate(
                  //   offset: const Offset(-240, 0),
                  //   child: Padding(
                  //     padding: EdgeInsets.only(top: 180, left: 80), // ajusta los valores según tus necesidades
                  //     child: BotonHome(
                  //       "Salir",
                  //       onPressed: () {
                  //         Navigator.push(
                  //           context,
                  //           MaterialPageRoute(builder: (context) => const Menu()),
                  //         );
                  //       },
                  //     ),
                  //   ),
                  // ),

                  //BOTON TEMPORAL REINICIO TURNO
                  // Padding(
                  //   padding: EdgeInsets.only(top: 190, left: 300), // ajusta los valores según tus necesidades
                  //   child: ElevatedButton(
                  //     onPressed: _resetTurno,
                  //     child: Text('Reiniciar turno'),
                  //   ),
                  // ),

                  //BOTON CHAT
                  Transform.translate(
                    offset: const Offset(375, -125),
                    child: Container(
                      width: 80,
                      height: 50,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/Chat.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),            

                  
                   
                  //FICHAS---------------------------------------------------------------------------------------------
                  Visibility(
                    visible: jVisibles[0],
                    child: Transform.translate(  //Ficha J0
                      offset: const Offset(0, 0),
                      child: Container(
                        width: 15,
                        height: 15,
                        child: Image.network(fichasJugadores[0],fit: BoxFit.fill,),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: jVisibles[1],
                    child: Transform.translate(  //Ficha J1
                      offset: const Offset(10, 10),
                      child: Container(
                        width: 15,
                        height: 15,
                        child: Image.network(fichasJugadores[1],fit: BoxFit.fill,),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: jVisibles[2],
                    child: Transform.translate(  //Ficha J2
                      offset: const Offset(20, 20),
                      child: Container(
                        width: 15,
                        height: 15,
                        child: Image.network(fichasJugadores[2],fit: BoxFit.fill,),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: jVisibles[3],
                    child: Transform.translate(  //Ficha J3
                      offset: const Offset(30, 30),
                      child: Container(
                        width: 15,
                        height: 15,
                        child: Image.network(fichasJugadores[3],fit: BoxFit.fill,),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: jVisibles[4],
                    child: Transform.translate(  //Ficha J4
                      offset: const Offset(40, 40),
                      child: Container(
                        width: 15,
                        height: 15,
                        child: Image.network(fichasJugadores[4],fit: BoxFit.fill,),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: jVisibles[5],
                    child: Transform.translate(  //Ficha J5
                      offset: const Offset(50, 50),
                      child: Container(
                        width: 15,
                        height: 15,
                        child: Image.network(fichasJugadores[5],fit: BoxFit.fill,),
                      ),
                    ),
                  ),
                

                ],
              ),

            ),

            //c1 boton
            // Transform.rotate(

            //   angle: -90 * pi / 180,
            //   child: Transform.translate(
            //     offset: const Offset(-307, 312), //-150,-25
            //     child: ElevatedButton(
            //       onPressed: () {
            //         print('1');
            //       },
            //       child: null,
            //       style: ButtonStyle(
            //         minimumSize: MaterialStateProperty.all<Size>(Size(38, 20)),
            //         backgroundColor: MaterialStateProperty.all<Color>(casillaCambia[1] == true ? colorVariado[1] : colorCasillas[1]),
            //       ),
            //                 ),
            //   ),
            // ),
             Transform.rotate(
              angle: -90 * pi / 180,
              child: Transform.translate(
                offset: const Offset(-318, 316), //-150,-25
                child: Ink(
                  width: 39,
                  height: 22,
                  decoration: ShapeDecoration(
                    color: casillaCambia[1] == true ? colorVariado[1] : colorCasillas[1],
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                      ),
                      side: BorderSide(color: Colors.black, width: 1),
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      print('1');
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Colors.transparent, 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            

            

            //PREGUNTAS-----------------------------------------------------------------------------------------
            Visibility(
              visible: preguntaActiva,
              child: Center(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    width: screenSize.width,
                    height: screenSize.height,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(68, 0, 0, 0),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center( 
                      child: Container(
                        width: 400,
                        height: 250,
                        decoration: BoxDecoration(
                          color: colorPregunta,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 20.0, left: 160, bottom: 210),
                              child: Text(
                                'HISTORIA',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontFamily: "Baskerville",
                                ),
                              ),
                            ),


                            Expanded(
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  width: 70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      width: 4,
                                      color: colorPregunta,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '$_countdownTime',
                                      style: const TextStyle(fontSize: 48),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            
                            
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Visibility(
              visible: preguntaActiva,
              child:Container(
                alignment: Alignment.centerLeft,
                child: const Padding(
                  padding: EdgeInsets.only(left: 205, bottom: 140),
                  child: Text(
                    '¿De qué color es el caballo blanco de Santiago?',
                    style: TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontFamily: "Baskerville",
                    ),
                  ),
                ),
              ),
            ),
            
            Visibility(
              visible: preguntaActiva,
              child: Padding(
                padding: const EdgeInsets.only(top: 130, left: 205),
                child: Container(
                  width: 390,
                  height: 35,
                  decoration: BoxDecoration(
                    color: Blanco,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: InkWell(
                    onTap: () {
                      print("respuesta 1");
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(top: 10, left: 10),
                      child: Text(
                        'Blanco nieve',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontFamily: "Baskerville",
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            
            Visibility(
              visible: preguntaActiva,
              child: Padding(
                padding: const EdgeInsets.only(top: 170, left: 205),
                child: Container(
                  width: 390,
                  height: 35,
                  decoration: BoxDecoration(
                    color: Blanco,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: InkWell(
                    onTap: () {
                      print("respuesta 2");
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(top: 10, left: 10),
                      child: Text(
                        'Blanco titanio',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontFamily: "Baskerville",
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Visibility(
              visible: preguntaActiva,
              child: Padding(
                padding: const EdgeInsets.only(top: 210, left: 205),
                child: Container(
                  width: 390,
                  height: 35,
                  decoration: BoxDecoration(
                    color: Blanco,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: InkWell(
                    onTap: () {
                      print("respuesta 3");
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(top: 10, left: 10),
                      child: Text(
                        'Blanco farlopa',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontFamily: "Baskerville",
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Visibility(
              visible: preguntaActiva,
              child: Padding(
                padding: const EdgeInsets.only(top: 250, left: 205),
                child: Container(
                  width: 390,
                  height: 35,
                  decoration: BoxDecoration(
                    color: Blanco,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: InkWell(
                    onTap: () {
                      print("respuesta 4");
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(top: 10, left: 10),
                      child: Text(
                        'Los colores solo son luz reflejada por el material (es Verde)',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontFamily: "Baskerville",
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            

          ],
        ),
      ),
    );
  }
}

class _HexagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final double w = size.width;
    final double h = size.height;
    // path.moveTo(size.width * 0.5, 0); //centro arriba (linea arriba izquierda)
    // path.lineTo(size.width * 0.5, 0); //centro arriba (linea arriba derecha)
    // path.lineTo(size.width, size.height * 0.4); //punto derecho
    // path.lineTo(size.width * 0.8, size.height); //abajo derecha
    // path.lineTo(size.width * 0.2, size.height); //abajo izquierda 
    // path.lineTo(size.width * 0, size.height * 0.4); //punto izquierdo


    path.moveTo(w * 0.5, 0);
    path.lineTo(w, h * 0.25);
    path.lineTo(w, h * 0.75);
    path.lineTo(w * 0.5, h);
    path.lineTo(0, h * 0.75);
    path.lineTo(0, h * 0.25);


    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class _RectangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final double w = size.width;
    final double h = size.height;

    path.moveTo(0, 0);
    path.lineTo(w * 0.56, 0);
    path.lineTo(w * 0.56, h * 0.3);
    path.lineTo(0, h * 0.3);


    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class _EsquinaClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final double w = size.width;
    final double h = size.height;

    path.moveTo(0.25 * w, 0);
    path.lineTo(0.75 * w, 0);
    // path.lineTo(w, 0.5 * h);
    // path.lineTo(w, 0.7 * h);
    path.lineTo(0.55 * w, h);
    // path.lineTo(0.25 * w, h);
    path.lineTo(28, h);
    path.lineTo(-28, -50);  //arriba izq
    path.close();

    // path.moveTo(10,20);
    // path.lineTo(size.width * 0.2, 0);
    // path.lineTo(size.width * 0.8, 0);
    // path.lineTo(size.width, size.height);
    // path.lineTo(0, size.height);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class _Esquina2Clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final double w = size.width;
    final double h = size.height;

    path.moveTo(0.25 * w, 0);
    path.lineTo(1 * w, -300);
    path.lineTo(0.55 * w, h);
    path.lineTo(30, h +8);
    path.lineTo(-19, -60);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class _Esquina3Clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final double w = size.width;
    final double h = size.height;

    path.moveTo(0.25 * w, 0);
    path.lineTo(w, -130);
    path.lineTo(0.55 * w, h);
    path.lineTo(35, h + 8);
    path.lineTo(-19, -200);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
/////////////////////////////////////////////////////////
class HexagonButton extends StatelessWidget {
  final Color color;
  final VoidCallback onPressed;

  const HexagonButton({
    Key? key,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: ClipPath(
        clipper: _HexagonClipper(),
        child: Container(
          width: 70,
          height: 70,
          color: color,
        ),
      ),
    );
  }
}

class RectangleButton extends StatelessWidget {
  final Color color;
  final VoidCallback onPressed;

  const RectangleButton({
    Key? key,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: ClipPath(
        clipper: _RectangleClipper(),
        child: Container(
          width: 70,
          height: 70,
          color: color,
        ),
      ),
    );
  }
}

class EsquinaButton extends StatelessWidget {
  final Color color;
  final VoidCallback onPressed;

  const EsquinaButton({
    Key? key,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: ClipPath(
        clipper: _EsquinaClipper(),
        child: Container(
          width: 120,
          height: 48,
          color: color,
        ),
      ),
    );
  }
}

class Esquina2Button extends StatelessWidget {
  final Color color;
  final VoidCallback onPressed;

  const Esquina2Button({
    Key? key,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: ClipPath(
        clipper: _Esquina2Clipper(),
        child: Container(
          width: 120,
          height: 55,
          color: color,
        ),
      ),
    );
  }
}

class Esquina3Button extends StatelessWidget {
  final Color color;
  final VoidCallback onPressed;

  const Esquina3Button({
    Key? key,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: ClipPath(
        clipper: _Esquina3Clipper(),
        child: Container(
          width: 120,
          height: 60,
          color: color,
        ),
      ),
    );
  }


}
/////////////////////////////////////////////////////////

class BotonDado extends StatelessWidget {
  final String textContrasenya;
  final VoidCallback onPressed;
  final int turno;
 const BotonDado(String t, {Key? key, required this.onPressed, required this.turno})
      : textContrasenya = t,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: dead_code
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[Color(0xFFdee8eb), Color(0xFFb0c7d0)],
                  stops: [0.4, 1.0],
                ),
              ),
            ),
          ),
          TextButton(
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFF004461),
            padding: const EdgeInsets.only(top: 4, bottom: 4, left: 15, right: 15),
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              fontFamily: "Georgia"),
          ),
          onPressed: turno == 1 ? onPressed : null,
          child: Text(textContrasenya),
          ),
        ],
      ),
    );
  }
}


class TrianglePainter extends CustomPainter {
  final Color color;

  TrianglePainter({this.color = Colors.black});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width / 2, 0);
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class TriangleWidget extends StatelessWidget {
  final Color color;

  TriangleWidget({this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: CustomPaint(
        painter: TrianglePainter(color: color),
        size: Size(30, 30),
      ),
    );
  }
}

class BotonHome extends StatelessWidget {
  final String textContrasenya;
  final VoidCallback onPressed;
  const BotonHome(String t, {Key? key, required this.onPressed})
      : textContrasenya = t,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: dead_code
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[Color(0xFFdee8eb), Color(0xFFb0c7d0)],
                  stops: [0.4, 1.0],
                ),
              ),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF004461),
              // padding: const EdgeInsets.all(16.0),
              padding:
                  const EdgeInsets.only(top: 4, bottom: 4, left: 10, right: 10),
              textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontFamily: "Georgia"),
            ),
            onPressed: onPressed,
            child: Text(textContrasenya),
          ),
        ],
      ),
    );
  }
}













// import 'dart:io';
// import 'dart:math';
// import 'dart:async';
// import 'dart:ui';
// import 'dart:convert';

// import 'package:flutter/material.dart';

// import 'package:flutter_application_1/Interfaz/Menu/home.dart';
// import 'package:flutter/services.dart';
// import 'package:web_socket_channel/io.dart';

// class JuegoCopia extends StatelessWidget {
//   const JuegoCopia({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: _Juego(),
//     );
//   }
// }

// class _Juego extends StatefulWidget {
//   @override
//   __JuegoState createState() => __JuegoState();
// }

// class __JuegoState extends State<_Juego> {
//    @override
//   Widget build(BuildContext context) {
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
//     final Size screenSize = MediaQuery.of(context).size;
//     return Scaffold(
//       body: Container(
//         width: screenSize.width, 
//         height: screenSize.height,
//         child: Stack(
//           children: [
//             Center(
//               child: Stack(
//                 children: [
//                   //C1
//                   Transform.translate(
//                     offset: Offset(0, 0),
//                     child: Transform.rotate(
//                       angle: -90 * pi / 180,
//                       child: GestureDetector(
//                         onTap: () {
//                           print('pulsado');
//                         },
//                         child: Container(
//                           width: 200,
//                           height: 100,
//                           color: Colors.blue,
//                         ),
//                       ),
//                     ),
//                   ),

//                   Padding(
//                     padding: EdgeInsets.only(top: 190, left: 300), // ajusta los valores según tus necesidades
//                     child: Transform.rotate(
//                       angle: -90 * pi / 180,
//                       child: ElevatedButton(
//                         onPressed: () {
//                           print('1');
//                         }, child: null,
//                       ),
//                     ),
//                   ),

//                   // CustomPaint(
//                   //   size: Size(20, 10),
//                   //   painter: TrapezoidPainter(),
//                   //   child: Center(
//                   //     child: Text(
//                   //       'Botón',
//                   //       style: TextStyle(color: Color.fromARGB(255, 252, 7, 7)),
//                   //     ),
//                   //   ),
//                   // ),

//                 ],
//               ),

//             ),

            

//           ],
//         ),
//       ),
//     );
//   }
// }

// class TrapezoidPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     var paint = Paint()..color = Colors.blue;
//     var path = Path();

//     path.moveTo(size.width * 0.2, 0);
//     path.lineTo(size.width * 0.8, 0);
//     path.lineTo(size.width, size.height);
//     path.lineTo(0, size.height);
//     path.close();

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(TrapezoidPainter oldDelegate) => false;
// }




// class _RectangleClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     final path = Path();
//     final double w = size.width;
//     final double h = size.height;

//     path.moveTo(0, 0);
//     path.lineTo(w * 0.56, 0);
//     path.lineTo(w * 0.56, h * 0.3);
//     path.lineTo(0, h * 0.3);


//     path.close();
//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }

// class RectangleButton extends StatelessWidget {
//   final Color color;
//   final VoidCallback onPressed;

//   const RectangleButton({
//     Key? key,
//     required this.color,
//     required this.onPressed,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onPressed,
//       child: ClipPath(
//         clipper: _RectangleClipper(),
//         child: Container(
//           width: 70,
//           height: 70,
//           color: color,
//         ),
//       ),
//     );
//   }
// }
