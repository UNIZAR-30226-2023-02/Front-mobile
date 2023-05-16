import 'dart:io';
import 'dart:math';
import 'dart:async';
import 'dart:ui';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_application_1/Interfaz/Menu/home.dart';
import 'package:flutter/services.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Juego extends StatelessWidget {
  const Juego({Key? key}) : super(key: key);

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
  
  


  // void dispose2() {
  //   _t.cancel(); // Cancela el temporizador al cerrar la pantalla
  //   super.dispose();
  // }

  void alternarCasilla(int casilla){  //esta para probar bien pero tendre que tener una funcion a al que le pasas nbumero de casillas y las alterna
    if(casillaCambia[casilla]){
      casillaCambia[casilla] = false;
    }else{
      casillaCambia[casilla] = true;
    }
  }

  void dalternarCasillas(bool alternar, List<String> casillasRec){
    List<int> casillas = casillasRec.map((numero) => int.parse(numero)).toList(); //convertir la lista de string en int
    //si alternar es true se alternan las casillas indicadas
    //si alternar es false se dejan de alternar todas las casillas
    for(var c in casillas){
      casillaCambia[c] = alternar;  
    }
  }

  //CONTADOR--------------------------------------------------------
  int _countdownTime = 99;
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
    _t.cancel();
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
  List<String> fichasJugadores = [
    //'','','','','',''];
    // 'assets/ficha_embudo_amarilla.png','assets/ficha_embudo_roja.png','assets/ficha_embudo_rosa.png','assets/ficha_embudo_verde.png',
    //                               'assets/ficha_embudo_azul.png','assets/ficha_embudo_naranja.png'];
  'http://51.142.118.71:8000/static/images/objetos/1-amarillo.png','http://51.142.118.71:8000/static/images/objetos/1-rojo.png',
                                  'http://51.142.118.71:8000/static/images/objetos/1-rosa.png','http://51.142.118.71:8000/static/images/objetos/1-verde.png',
                                  'http://51.142.118.71:8000/static/images/objetos/1-azul.png','http://51.142.118.71:8000/static/images/objetos/1-naranja.png'];

  List<Offset> coordenadasFichaJ0 = [const Offset(-47, 158),const Offset(-26, 185),const Offset(-6, 185),const Offset(14, 185),
                                  const Offset(34, 185),const Offset(54, 185),const Offset(74, 185),const Offset(90, 170),
                                  const Offset(123, 150),const Offset(133, 140),const Offset(143, 120),const Offset(153, 100),
                                  const Offset(163, 80),const Offset(173, 67),const Offset(173, 47),const Offset(179, 0),
                                  const Offset(169, -16),const Offset(159, -36),const Offset(149, -50),const Offset(140, -67),
                                  const Offset(132, -83),const Offset(112, -88),const Offset(75, -110), const Offset(65, -110), 
                                  const Offset(45, -110),const Offset(25, -110),const Offset(5, -110),const Offset(-15, -110),
                                  const Offset(-35, -100),
                                  const Offset(-70, -85),const Offset(-78, -73),const Offset(-87, -53),const Offset(-97, -37),
                                  const Offset(-107, -21),const Offset(-117, -4),const Offset(-117, 20),const Offset(-123, 65),
                                  const Offset(-113, 85),const Offset(-103,105),const Offset(-93,122),const Offset(-82,138),
                                  const Offset(-70,155),const Offset(-43,138),const Offset(-33,118),const Offset(-25,100),
                                  const Offset(-17,83),const Offset(-7,65),const Offset(78,152),const Offset(68,133),
                                  const Offset(58,113),const Offset(48,97),const Offset(40,77),const Offset(150,50),
                                  const Offset(130,50),const Offset(110,50),const Offset(90,50),const Offset(70,50),
                                  const Offset(72,-79),const Offset(62,-59),const Offset(52,-42),const Offset(44,-25),
                                  const Offset(34,-5),const Offset(-40,-65),const Offset(-30,-45),const Offset(-22,-28),
                                  const Offset(-14,-10),const Offset(-4,8),const Offset(-104,20),const Offset(-80,20),
                                  const Offset(-63,20),const Offset(-43,20),const Offset(-23,20),const Offset(10,20)];
  
    List<Offset> coordenadasFichaJ1 = [const Offset(-37, 158),const Offset(-16, 185),const Offset(6, 185),const Offset(26, 185),
								const Offset(44, 185),const Offset(64, 185),const Offset(82, 190),const Offset(110, 160),
								const Offset(130, 146), const Offset(141, 129),const Offset(150, 111),const Offset(160, 96),
								const Offset(168, 76),const Offset(178, 62),const Offset(173, 27),const Offset(177, -10),
								const Offset(166, -26),const Offset(157, -46),const Offset(146, -60),const Offset(137, -77),
								const Offset(128, -90),const Offset(95, -94),const Offset(85, -110),const Offset(55, -110),
								const Offset(35, -110),const Offset(15, -110),const Offset(-5, -110),const Offset(-23, -113),
								const Offset(-45, -93),
								const Offset(-77, -85),const Offset(-80, -65),const Offset(-92, -45),const Offset(-100, -30),
								const Offset(-112, -11),const Offset(-121, 3),const Offset(-117, 40),const Offset(-120, 75),
								const Offset(-106, 95),const Offset(-95,112),const Offset(-86,129),const Offset(-77,147),
								const Offset(-70,162),const Offset(-39,128),const Offset(-30,108),const Offset(-22,90),
								const Offset(-15,73),const Offset(-4,55),const Offset(74,142),const Offset(65,123),
								const Offset(55,103),const Offset(45,87),const Offset(37,67),const Offset(160,50),
								const Offset(140,50),const Offset(120,50),const Offset(100,50),const Offset(80,50),
								const Offset(79,-89),const Offset(69,-69),const Offset(59,-52),const Offset(50,-33),
								const Offset(38,-15),const Offset(-46,-75),const Offset(-35,-55),const Offset(-27,-38),
								const Offset(-19,-20),const Offset(-9,-2),const Offset(-94,20),const Offset(-70,20),
								const Offset(-53,20),const Offset(-33,20),const Offset(-13,20),const Offset(25,20)
								];
    
    List<Offset> coordenadasFichaJ2 = [const Offset(-49, 168),const Offset(-26, 195),const Offset(-6, 195),const Offset(14, 195),
									const Offset(34, 195),const Offset(54, 195),const Offset(74, 195),const Offset(100, 185),
									const Offset(134, 160),const Offset(144, 146),const Offset(153, 125),const Offset(163, 110),
									const Offset(173, 90),const Offset(183, 77),const Offset(185, 47),const Offset(189, -5),
									const Offset(179, -21),const Offset(169, -39),const Offset(159, -55),const Offset(150, -71),
									const Offset(142, -90),const Offset(117, -100),const Offset(85, -120),const Offset(65, -120),
									const Offset(45, -120),const Offset(25, -120),const Offset(5, -120),const Offset(-15, -120),
									const Offset(-45, -110),
									const Offset(-80, -95),const Offset(-88, -83),const Offset(-97, -63),const Offset(-107, -47),
									const Offset(-117, -28),const Offset(-126, -12),const Offset(-130, 20),const Offset(-133, 75),
									const Offset(-123, 92),const Offset(-113,111),const Offset(-103,129),const Offset(-92,145),
									const Offset(-83,160),const Offset(-33,144),const Offset(-23,124),const Offset(-15,106),
									const Offset(-7,89),const Offset(3,71),const Offset(88,148),const Offset(78,128),
									const Offset(68,109),const Offset(58,93),const Offset(50,73),const Offset(150,40),
									const Offset(130,40),const Offset(110,40),const Offset(90,40),const Offset(70,40),
									const Offset(82,-73),const Offset(72,-53),const Offset(62,-35),const Offset(54,-19),
									const Offset(44,1),const Offset(-30,-70),const Offset(-20,-52),const Offset(-8,-33),
									const Offset(-4,-13),const Offset(6,3),const Offset(-104,30),const Offset(-80,30),
									const Offset(-63,30),const Offset(-43,30),const Offset(-23,30),const Offset(40,20)
									];
  
  List<Offset> coordenadasFichaJ3 = [
    const Offset(-39, 168),
    const Offset(-16, 195),
    const Offset(6, 195),
    const Offset(26, 195),
    const Offset(44, 195),
    const Offset(64, 195),
    const Offset(82, 200),
    const Offset(110, 175),
    const Offset(141, 156),
    const Offset(152, 135),
    const Offset(160, 116),
    const Offset(170, 106),
    const Offset(178, 86),
    const Offset(188, 72),
    const Offset(185, 27),
    const Offset(187, -15),
    const Offset(176, -31),
    const Offset(167, -49),
    const Offset(153, -65),
    const Offset(147, -81),
    const Offset(138, -97),
    const Offset(110, -106),
    const Offset(75, -120),
    const Offset(55, -120),
    const Offset(35, -120),
    const Offset(15, -120),
    const Offset(-5, -120),
    const Offset(-23, -123),
    const Offset(-55, -103),
    const Offset(-87, -95),
    const Offset(-90, -75),
    const Offset(-102, -55),
    const Offset(-110, -40),
    const Offset(-122, -18),
    const Offset(-130, -5),
    const Offset(-130, 40),
    const Offset(-130, 85),
    const Offset(-117, 102),
    const Offset(-105, 118),
    const Offset(-96, 136),
    const Offset(-85, 154),
    const Offset(-83, 167),
    const Offset(-29, 134),
    const Offset(-20, 114),
    const Offset(-12, 96),
    const Offset(-2, 79),
    const Offset(0, 61),
    const Offset(84, 138),
    const Offset(75, 118),
    const Offset(65, 99),
    const Offset(55, 83),
    const Offset(47, 63),
    const Offset(160, 40),
    const Offset(140, 40),
    const Offset(120, 40),
    const Offset(100, 40),
    const Offset(80, 40),
    const Offset(89, -83),
    const Offset(79, -63),
    const Offset(69, -45),
    const Offset(60, -26),
    const Offset(48, -9),
    const Offset(-36, -80),
    const Offset(-25, -62),
    const Offset(-13, -43),
    const Offset(-9, -23),
    const Offset(1, -7),
    const Offset(-94, 30),
    const Offset(-70, 30),
    const Offset(-53, 30),
    const Offset(-33, 30),
    const Offset(-13, 30),
    const Offset(55, 20)
  ];

  List<Offset> coordenadasDiferencia = [
const Offset(-2, 10),
const Offset(0, 10),
const Offset(0, 10),
const Offset(0, 10),
const Offset(0, 10),
const Offset(0, 10),
const Offset(0, 10),
const Offset(10, 15),
const Offset(11, 10),
const Offset(11, 6),
const Offset(10, 5),
const Offset(10, 10),
const Offset(10, 10),
const Offset(10, 10),
const Offset(12, 0),
const Offset(10, -5),
const Offset(10, -5),
const Offset(10, -3),
const Offset(10, -5),
const Offset(10, -4),
const Offset(10, -7),
const Offset(5, -12),
const Offset(10, -10),
const Offset(0, -10),
const Offset(0, -10),
const Offset(0, -10),
const Offset(0, -10),
const Offset(0, -10),
const Offset(-10, -10),
const Offset(-10, -10),
const Offset(-10, -10),
const Offset(-10, -10),
const Offset(-10, -10),
const Offset(-10, -7),
const Offset(-9, -8),
const Offset(-13, 0),
const Offset(-10, 10),
const Offset(-10, 7),
const Offset(-10, 6),
const Offset(-10, 7),
const Offset(-10, 7),
const Offset(-13, 5),
const Offset(10, 6),
const Offset(10, 6),
const Offset(10, 6),
const Offset(10, 6),
const Offset(10, 6),
const Offset(10, -4),
const Offset(10, -5),
const Offset(10, -4),
const Offset(10, -4),
const Offset(10, -4),
const Offset(0, -10),
const Offset(0, -10),
const Offset(0, -10),
const Offset(0, -10),
const Offset(0, -10),
const Offset(10, 6),
const Offset(10, 6),
const Offset(10, 7),
const Offset(10, 6),
const Offset(10, 6),
const Offset(10, -5),
const Offset(10, -7),
const Offset(14, -5),
const Offset(10, -3),
const Offset(10, -5),
const Offset(0, 10),
const Offset(0, 10),
const Offset(0, 10),
const Offset(0, 10),
const Offset(0, 10),
const Offset(30, 0),
];

void calcularDiferencia(List<Offset> lista1, List<Offset> lista2) {
    assert(lista1.length == lista2.length);
    List<Offset> diferencias = [];
    for (int i = 0; i < lista1.length; i++) {
      Offset coordenada1 = lista1[i];
      Offset coordenada2 = lista2[i];
      Offset diferencia = coordenada2 - coordenada1;
      diferencias.add(diferencia);
    }
    for(var o in diferencias){
      print(o.toString());
    }
  } 

  void calcularSuma(List<Offset> lista1, List<Offset> lista2) {
    assert(lista1.length == lista2.length);
    List<Offset> diferencias = [];
    for (int i = 0; i < lista1.length; i++) {
      Offset coordenada1 = lista1[i];
      Offset coordenada2 = lista2[i];
      Offset diferencia = coordenada1 + coordenada2;
      diferencias.add(diferencia);
    }
    for(var o in diferencias){
      print(o.toString());
    }
  } 
  
  List<Offset> coordenadasFichaJ4 = [const Offset(-39, 178),const Offset(-16, 205),const Offset(6, 205),const Offset(26, 205),
								const Offset(44, 205),const Offset(64, 205),const Offset(82, 210),const Offset(120, 185),
								const Offset(150, 162),const Offset(163, 142),const Offset(175, 125),const Offset(186, 109),
								const Offset(193, 92),const Offset(204, 78),const Offset(205, 27),const Offset(197, -24),
								const Offset(187, -40),const Offset(177, -58),const Offset(170, -73),const Offset(163, -89),
								const Offset(148, -106),
								const Offset(105, -124),const Offset(85, -130),const Offset(55, -130),
								const Offset(35, -130),const Offset(15, -130),const Offset(-5, -130),const Offset(-23, -130),
								const Offset(-45, -123),
								const Offset(-95, -95),const Offset(-99, -83),const Offset(-112, -64),const Offset(-120, -47),
								const Offset(-132, -30),const Offset(-141, -14),const Offset(-147, 40),const Offset(-145, 78),
								const Offset(-128, 106),const Offset(-116,122),const Offset(-107,140),const Offset(-97,158),
								const Offset(-92,174),const Offset(-10,139),const Offset(0,123),const Offset(5,104),
								const Offset(15,83),const Offset(20,65),const Offset(94,132),const Offset(85,113),
								const Offset(78,93),const Offset(70,74),const Offset(59,55),const Offset(160,30),
								const Offset(140,30),const Offset(120,30),const Offset(100,30),const Offset(80,30),
								const Offset(102,-75),const Offset(92,-58),const Offset(83,-40),const Offset(74,-17),
								const Offset(62,-3),const Offset(-26,-85),const Offset(-15,-65),const Offset(0,-50),
								const Offset(2,-30),const Offset(12,-13),const Offset(-94,40),const Offset(-70,40),
								const Offset(-53,40),const Offset(-33,40),const Offset(-13,40),const Offset(25,40)
								];

  List<Offset> coordenadasFichaJ5 = [
const Offset(-51, 178),
const Offset(-26, 205),
const Offset(-6, 205),
const Offset(14, 205),
const Offset(34, 205),
const Offset(54, 205),
const Offset(74, 205),
const Offset(110, 200),
const Offset(145, 170),
const Offset(155, 152),
const Offset(163, 130),
const Offset(173, 120),
const Offset(183, 100),
const Offset(193, 87),
const Offset(197, 47),
const Offset(199, -10),
const Offset(189, -26),
const Offset(179, -42),
const Offset(169, -60),
const Offset(160, -75),
const Offset(152, -97),
const Offset(122, -112),
const Offset(95, -130),
const Offset(65, -130),
const Offset(45, -130),
const Offset(25, -130),
const Offset(5, -130),
const Offset(-15, -130),
const Offset(-55, -120),
const Offset(-90, -105),
const Offset(-98, -93),
const Offset(-107, -73),
const Offset(-117, -57),
const Offset(-127, -35),
const Offset(-135, -20),
const Offset(-143, 20),
const Offset(-143, 85),
const Offset(-133, 99),
const Offset(-123, 117),
const Offset(-113, 136),
const Offset(-102, 152),
const Offset(-96, 165),
const Offset(-23, 150),
const Offset(-13, 130),
const Offset(-5, 112),
const Offset(3, 95),
const Offset(13, 77),
const Offset(98, 144),
const Offset(88, 123),
const Offset(78, 105),
const Offset(68, 89),
const Offset(60, 69),
const Offset(150, 30),
const Offset(130, 30),
const Offset(110, 30),
const Offset(90, 30),
const Offset(70, 30),
const Offset(92, -67),
const Offset(82, -47),
const Offset(72, -28),
const Offset(64, -13),
const Offset(54, 7),
const Offset(-20, -75),
const Offset(-10, -59),
const Offset(6, -38),
const Offset(6, -16),
const Offset(16, -2),
const Offset(-104, 40),
const Offset(-80, 40),
const Offset(-63, 40),
const Offset(-43, 40),
const Offset(-23, 40),
const Offset(40, 40)
];
  List<int> posicionesFichas = [72,72,72,72,72,72];

  //QUESITOS JUGADOR----------------------------------------
  String quesitosGeneral = "assets/QuesitosGeneral.png";
  String quesitoHistoria = "assets/QuesitoHistoria.png";
  String quesitoArte = "assets/QuesitoArte.png";
  String quesitoDeportes = "assets/QuesitoDeporte.png";
  String quesitoCiencia = "assets/QuesitoCiencia.png";
  String quesitoEntretenimiento = "assets/QuesitoEntretenimiento.png";
  String quesitoGeografia = "assets/QuesitoGeografia.png";
  //[Historia,Arte,Deportes,Ciencia,Entretenimiento,Geografia]
  List<List<bool>> quesitosJug = [[false,false,false,false,false,false],[false,false,false,false,false,false],[false,false,false,false,false,false],
                                  [false,false,false,false,false,false],[false,false,false,false,false,false],[false,false,false,false,false,false]];
  void addQuesito(int jugador,String tematica){
    if(tematica == "Historia"){
      quesitosJug[jugador][0] = true;
    }else if (tematica == "Arte"){
      quesitosJug[jugador][1] = true;
    }else if (tematica == "Deportes"){
      quesitosJug[jugador][2] = true;
    }else if (tematica == "Ciencia"){
      quesitosJug[jugador][3] = true;
    }else if (tematica == "Entretenimiento"){
      quesitosJug[jugador][4] = true;
    }else if (tematica == "Geografia"){
      quesitosJug[jugador][5] = true;
    }
  }
  //--------------------------------------------------------

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> WEB SOCKET <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<//
      //ANOTACIONES----------------------------------------------------------------------------------------//
      //-Creo que al meter aqui las opciones de ejecución del socket se comprobaran y repecto a esos datos
      //    hacemos el build del tablero
      //
      //
      //FIN ANOTACIONES-----------------------------------------------------------------------------------//
  // bool msgIni = true;

  String fondoTablero = "assets/desierto.png";
  bool tableroHabilitado = false;
  void cargarEstado_tablerosJug(List<String> r_nombres,List<String> r_tableros){  //pone el tablero correspondiente al jugador
    // int p = 0;
    // for(var n in r_nombres){
    //   if(S.nombre == n){
    //     fondoTablero = r_tableros[p];
    //     tableroHabilitado = true;
    //   }
    // }
    // p++;
  }

  void cargarEstado_quesosJug(List<List<String>> r_quesitos){
    for(int i=0; i < r_quesitos.length; i++){
      for(int j=0; j < r_quesitos[i].length; j++){

      }
    }
  }

  void cargarEstado_nombresJug(List<String> r_nombres){
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

  void cargarEstado_posicionesJug(List<String> r_posiciones){
    List<int> posiciones = r_posiciones.map((numero) => int.parse(numero)).toList();
    int i = 0;
    for(var p in posiciones){
      posicionesFichas[i] = p;
      i++;
    }
  }

  String _turno = "";
  void moverFicha(String Casilla){
    int nCasilla = int.parse(Casilla);
    for(int i = 0; i < nombresJugadores.length; i++){
      if(_turno == nombresJugadores[i]){
        posicionesFichas[i] = nCasilla;
      }
    }
  }

  //hace visibles los nombres, imagenes y quesitos de los jugadores de la partida
  void habilitarJugadores(){
    for(int p=0;p < numJ;p++){
      jVisibles[p] = true;
    }
  }

  int turnoActual = 0;
  String imagenJugadorTurno = "assets/perfil_turno.png";
  void cambioTurno(String nombre){  //Cuando llegue actualizacion se mira el nombre y se le asigna el turno
    int i = 0;
    for(var n in nombresJugadores){
      if(n == nombre){
        turnoActual = i;
      }
      i++;
    }
  }

  //BORRAR ESTA FUNCION, ES SOLO PARA PRUEBAS (cada vez que se preta reiniciar turno pasa de turno)
  void pasoTurno(){
    if(turnoActual == 5){
      turnoActual = 0;
    }else{
      turnoActual++;
    }
  }
  int casillaPru = 72;
  void sumaPruCasilla(){
    if(casillaPru == 72){
      casillaPru = 0;
    }else{
      casillaPru++;
    }
  }

  
  // void ejecutarSocket(){
    // final channel = IOWebSocketChannel.connect('');

    // if(msgIni){
    //   msgIni = false;
    //   channel.stream.listen((message){
    //   Map<String, dynamic> decodedResponse = json.decode(message);
    //   String r_ok = decodedResponse['OK'];
    //   List<dynamic> r_jugadores = decodedResponse['jugadores'];
    //   List<String> r_nombres = [];
    //   List<String> r_posiciones = [];
    //   List<List<String>> r_quesitos = [];
    //   List<String> r_turnos = [];
    //   List<String> r_fichas = [];
    //   List<String> r_tableros = [];
    //   List<bool> r_activos = [];
    //   // String r_type = decodedResponse['type'];
    //   // String r_subtype = decodedResponse['subtype'];
    //   for(var jugador in r_jugadores){
    //     //Esto lo puedo comprimir con lo de abajo
    //     String nombre = jugador['jugador'];
    //     String posicion = jugador['posicion'];
    //     List<String> quesitos = jugador['quesitos'];
    //     String turno = jugador['turno'];
    //     String ficha = jugador['ficha'];
    //     String tablero = jugador['tablero'];
    //     bool activo = jugador['activo'];
        
    //     r_nombres.add(nombre);
    //     r_posiciones.add(posicion);
    //     r_quesitos.add(quesitos);
    //     r_turnos.add(turno);
    //     r_fichas.add(ficha);
    //     r_tableros.add(tablero);
    //     r_activos.add(activo);
    //   }
    //   String r_tiempo_pregunta = decodedResponse['tiempo_pregunta'];
    //   String r_tiempo_elegir_casilla = decodedResponse['tiempo_elegir_casilla'];
    //   String r_error = decodedResponse['error'];

    //   //CARGAR JUGADORES
    //   if(r_ok == "true"){
    //     numJ = r_jugadores.length;
    //     cargarEstado_nombresImagenesJug(r_nombres);
        
    //     cargarEstado_posicionesJug(r_posiciones);
    //     cargarEstado_quesosJug(r_quesitos);

    //     cargarEstado_fichasJug(r_fichas);
        
    //     cargarEstado_tablerosJug(r_nombres,r_tableros); //Tengo que cargar un tablero para cada usuario

    //     int a=0;
    //     List<int> turnos = r_turnos.map((numero) => int.parse(numero)).toList();
    //     for(var t in turnos){
    //       if(t == 1){
    //         turnoActual = a;
    //       }
    //       a++;
    //     }
    //   }



      // });
    
    // }else{

    // }
    
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

    
  // }
  
  
  
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

  bool msgIni = true;
  void initState() {
    super.initState();  
    _t = Timer.periodic(Duration(milliseconds: 500), (t) {
      setState(() { //Habilitar el "parpadeo de seleccion" en todas las casillas
        for(int p = 0; p < 73; p++){
          colorVariado[p] = _getNextColor(p); 
        }
      });
    });

    // final channel = WebSocketChannel.connect(Uri.parse('ws://localhost:1234'));
    // channel.stream.listen((message) {
    //   setState(() { //no se hasta que punto esta bien meter todo en el setstate
    //     if(msgIni){
    //       msgIni = false;
    //       Map<String, dynamic> decodedResponse = json.decode(message);
    //       String r_ok = decodedResponse['OK'];
    //       List<dynamic> r_jugadores = decodedResponse['jugadores'];
    //       List<String> r_nombres = [];
    //       List<String> r_posiciones = [];
    //       List<List<String>> r_quesitos = [];
    //       List<String> r_turnos = [];
    //       List<String> r_fichas = [];
    //       List<String> r_tableros = [];
    //       List<bool> r_activos = [];
    //       // String r_type = decodedResponse['type'];
    //       // String r_subtype = decodedResponse['subtype'];
    //       for(var jugador in r_jugadores){
    //         //Esto lo puedo comprimir con lo de abajo
    //         String nombre = jugador['jugador'];
    //         String posicion = jugador['posicion'];
    //         List<String> quesitos = jugador['quesitos'];
    //         String turno = jugador['turno'];
    //         String ficha = jugador['ficha'];
    //         String tablero = jugador['tablero'];
    //         bool activo = jugador['activo'];
            
    //         r_nombres.add(nombre);
    //         r_posiciones.add(posicion);
    //         r_quesitos.add(quesitos);
    //         r_turnos.add(turno);
    //         r_fichas.add(ficha);
    //         r_tableros.add(tablero);
    //         r_activos.add(activo);
    //       }
    //       String r_tiempo_pregunta = decodedResponse['tiempo_pregunta'];
    //       String r_tiempo_elegir_casilla = decodedResponse['tiempo_elegir_casilla'];
    //       String r_error = decodedResponse['error'];

    //       //CARGAR JUGADORES
    //       if(r_ok == "true"){
    //         numJ = r_jugadores.length;
    //         cargarEstado_nombresImagenesJug(r_nombres);
            
    //         cargarEstado_posicionesJug(r_posiciones);
    //         cargarEstado_quesosJug(r_quesitos);

    //         cargarEstado_fichasJug(r_fichas);
            
    //         cargarEstado_tablerosJug(r_nombres,r_tableros); //Tengo que cargar un tablero para cada usuario

    //         int a=0;
    //         List<int> turnos = r_turnos.map((numero) => int.parse(numero)).toList();
    //         for(var t in turnos){
    //           if(t == 1){
    //             turnoActual = a;
    //           }
    //           a++;
    //         }
    //       }
    //     }
    //   });
    // });
  }




//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> FIN WEB SOCKET <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<//
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    final Size screenSize = MediaQuery.of(context).size;
    // ejecutarSocket();
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
                  Transform.translate(
                    offset: const Offset(-145, -129),
                    child: Container(
                      width: 360,
                      height: 360,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 231, 231, 231),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      // child: Container(
                        child: Image(image: AssetImage(fondoTablero),fit: BoxFit.fill,),
                      // ),
                    ),
                  ),

                  //Contador
                  Transform.translate(offset: const Offset(-170, -120),
                    child: Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '$_countdownTime',
                          style: const TextStyle(fontSize: 40),
                        ),
                      ),
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
                    visible: jVisibles[0] && turnoActual == 0,
                    child: Transform.translate(  //Imagen turno J0
                      offset: const Offset(-265, -110),
                      child: Container(
                        width: 70,
                        height: 70,
                        child: Image(image: AssetImage(imagenJugadorTurno),fit: BoxFit.fill,),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: jVisibles[0],
                    child: Transform.translate(  //QuesitosGeneral J0
                      offset: const Offset(-205, -60),
                      child: Container(
                        width: 40,
                        height: 40,
                        child: Image(image: AssetImage(quesitosGeneral),fit: BoxFit.fill,),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: jVisibles[0] && quesitosJug[0][0],
                    child: Transform.translate(  //QuesitoHistoria J0
                      offset: const Offset(-205, -60),
                      child: Container(
                        width: 40,
                        height: 40,
                        child: Image(image: AssetImage(quesitoHistoria),fit: BoxFit.fill,),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: jVisibles[0] && quesitosJug[0][1],
                    child: Transform.translate(  //QuesitoArte J0
                      offset: const Offset(-205, -60),
                      child: Container(
                        width: 40,
                        height: 40,
                        child: Image(image: AssetImage(quesitoArte),fit: BoxFit.fill,),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: jVisibles[0] && quesitosJug[0][2],
                    child: Transform.translate(  //QuesitoDeportes J0
                      offset: const Offset(-205, -60),
                      child: Container(
                        width: 40,
                        height: 40,
                        child: Image(image: AssetImage(quesitoDeportes),fit: BoxFit.fill,),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: jVisibles[0] && quesitosJug[0][3],
                    child: Transform.translate(  //QuesitoCiencia J0
                      offset: const Offset(-205, -60),
                      child: Container(
                        width: 40,
                        height: 40,
                        child: Image(image: AssetImage(quesitoCiencia),fit: BoxFit.fill,),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: jVisibles[0] && quesitosJug[0][4],
                    child: Transform.translate(  //QuesitoEntretenimiento J0
                      offset: const Offset(-205, -60),
                      child: Container(
                        width: 40,
                        height: 40,
                        child: Image(image: AssetImage(quesitoEntretenimiento),fit: BoxFit.fill,),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: jVisibles[0] && quesitosJug[0][5],
                    child: Transform.translate(  //QuesitoGeografia J0
                      offset: const Offset(-205, -60),
                      child: Container(
                        width: 40,
                        height: 40,
                        child: Image(image: AssetImage(quesitoGeografia),fit: BoxFit.fill,),
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
                    visible: jVisibles[1] && turnoActual == 1,
                    child: Transform.translate(  //Imagen turno J1
                      offset: const Offset(-265, 10),
                      child: Container(
                        width: 70,
                        height: 70,
                        child: Image(image: AssetImage(imagenJugadorTurno),fit: BoxFit.fill,),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: jVisibles[1],
                    child: Transform.translate(  //QuesitosGeneral J1
                      offset: const Offset(-205, 60),
                      child: Container(
                        width: 40,
                        height: 40,
                        child: Image(image: AssetImage(quesitosGeneral),fit: BoxFit.fill,),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: jVisibles[1] && quesitosJug[1][0],
                    child: Transform.translate(  //QuesitoHistoria J1
                      offset: const Offset(-205, 60),
                      child: Container(
                        width: 40,
                        height: 40,
                        child: Image(image: AssetImage(quesitoHistoria),fit: BoxFit.fill,),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: jVisibles[1] && quesitosJug[1][1],
                    child: Transform.translate(  //QuesitoArte J1
                      offset: const Offset(-205, 60),
                      child: Container(
                        width: 40,
                        height: 40,
                        child: Image(image: AssetImage(quesitoArte),fit: BoxFit.fill,),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: jVisibles[1] && quesitosJug[1][2],
                    child: Transform.translate(  //QuesitoDeportes J1
                      offset: const Offset(-205, 60),
                      child: Container(
                        width: 40,
                        height: 40,
                        child: Image(image: AssetImage(quesitoDeportes),fit: BoxFit.fill,),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: jVisibles[1] && quesitosJug[1][3],
                    child: Transform.translate(  //QuesitoCiencia J1
                      offset: const Offset(-205, 60),
                      child: Container(
                        width: 40,
                        height: 40,
                        child: Image(image: AssetImage(quesitoCiencia),fit: BoxFit.fill,),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: jVisibles[1] && quesitosJug[1][4],
                    child: Transform.translate(  //QuesitoEntretenimiento J1
                      offset: const Offset(-205, 60),
                      child: Container(
                        width: 40,
                        height: 40,
                        child: Image(image: AssetImage(quesitoEntretenimiento),fit: BoxFit.fill,),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: jVisibles[1] && quesitosJug[1][5],
                    child: Transform.translate(  //QuesitoGeografia J1
                      offset: const Offset(-205, 60),
                      child: Container(
                        width: 40,
                        height: 40,
                        child: Image(image: AssetImage(quesitoGeografia),fit: BoxFit.fill,),
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
                    visible: jVisibles[2] && turnoActual == 2,
                    child: Transform.translate(  //Imagen turno J2
                      offset: const Offset(-265, 130),
                      child: Container(
                        width: 70,
                        height: 70,
                        child: Image(image: AssetImage(imagenJugadorTurno),fit: BoxFit.fill,),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: jVisibles[2],
                    child: Transform.translate(  //QuesitosGeneral J2
                      offset: const Offset(-205, 180),
                      child: Container(
                        width: 40,
                        height: 40,
                        child: Image(image: AssetImage(quesitosGeneral),fit: BoxFit.fill,),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: jVisibles[2] && quesitosJug[2][0],
                    child: Transform.translate(  //QuesitoHistoria J2
                      offset: const Offset(-205, 180),
                      child: Container(
                        width: 40,
                        height: 40,
                        child: Image(image: AssetImage(quesitoHistoria),fit: BoxFit.fill,),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: jVisibles[2] && quesitosJug[2][1],
                    child: Transform.translate(  //QuesitoArte J2
                      offset: const Offset(-205, 180),
                      child: Container(
                        width: 40,
                        height: 40,
                        child: Image(image: AssetImage(quesitoArte),fit: BoxFit.fill,),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: jVisibles[2] && quesitosJug[2][2],
                    child: Transform.translate(  //QuesitoDeportes J2
                      offset: const Offset(-205, 180),
                      child: Container(
                        width: 40,
                        height: 40,
                        child: Image(image: AssetImage(quesitoDeportes),fit: BoxFit.fill,),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: jVisibles[2] && quesitosJug[2][3],
                    child: Transform.translate(  //QuesitoCiencia J2
                      offset: const Offset(-205, 180),
                      child: Container(
                        width: 40,
                        height: 40,
                        child: Image(image: AssetImage(quesitoCiencia),fit: BoxFit.fill,),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: jVisibles[2] && quesitosJug[2][4],
                    child: Transform.translate(  //QuesitoEntretenimiento J2
                      offset: const Offset(-205, 180),
                      child: Container(
                        width: 40,
                        height: 40,
                        child: Image(image: AssetImage(quesitoEntretenimiento),fit: BoxFit.fill,),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: jVisibles[2] && quesitosJug[2][5],
                    child: Transform.translate(  //QuesitoGeografia J2
                      offset: const Offset(-205, 180),
                      child: Container(
                        width: 40,
                        height: 40,
                        child: Image(image: AssetImage(quesitoGeografia),fit: BoxFit.fill,),
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
                    visible: jVisibles[3] && turnoActual == 3,
                    child: Transform.translate(  //Imagen turno J3
                      offset: const Offset(290, -110),
                      child: Container(
                        width: 70,
                        height: 70,
                        child: Image(image: AssetImage(imagenJugadorTurno),fit: BoxFit.fill,),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: jVisibles[3],
                    child: Transform.translate(  //QuesitosGeneral J3
                      offset: const Offset(260, -60),
                      child: Container(
                        width: 40,
                        height: 40,
                        child: Image(image: AssetImage(quesitosGeneral),fit: BoxFit.fill,),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: jVisibles[3] && quesitosJug[3][0],
                    child: Transform.translate(  //QuesitoHistoria J3
                      offset: const Offset(260, -60),
                      child: Container(
                        width: 40,
                        height: 40,
                        child: Image(image: AssetImage(quesitoHistoria),fit: BoxFit.fill,),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: jVisibles[3] && quesitosJug[3][1],
                    child: Transform.translate(  //QuesitoArte J3
                      offset: const Offset(260, -60),
                      child: Container(
                        width: 40,
                        height: 40,
                        child: Image(image: AssetImage(quesitoArte),fit: BoxFit.fill,),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: jVisibles[3] && quesitosJug[3][2],
                    child: Transform.translate(  //QuesitoDeportes J3
                      offset: const Offset(260, -60),
                      child: Container(
                        width: 40,
                        height: 40,
                        child: Image(image: AssetImage(quesitoDeportes),fit: BoxFit.fill,),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: jVisibles[3] && quesitosJug[3][3],
                    child: Transform.translate(  //QuesitoCiencia J3
                      offset: const Offset(260, -60),
                      child: Container(
                        width: 40,
                        height: 40,
                        child: Image(image: AssetImage(quesitoCiencia),fit: BoxFit.fill,),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: jVisibles[3] && quesitosJug[3][4],
                    child: Transform.translate(  //QuesitoEntretenimiento J3
                      offset: const Offset(260, -60),
                      child: Container(
                        width: 40,
                        height: 40,
                        child: Image(image: AssetImage(quesitoEntretenimiento),fit: BoxFit.fill,),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: jVisibles[3] && quesitosJug[3][5],
                    child: Transform.translate(  //QuesitoGeografia J3
                      offset: const Offset(260, -60),
                      child: Container(
                        width: 40,
                        height: 40,
                        child: Image(image: AssetImage(quesitoGeografia),fit: BoxFit.fill,),
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
                    visible: jVisibles[4] && turnoActual == 4,
                    child: Transform.translate(  //Imagen turno J4
                      offset: const Offset(290, 10),
                      child: Container(
                        width: 70,
                        height: 70,
                        child: Image(image: AssetImage(imagenJugadorTurno),fit: BoxFit.fill,),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: jVisibles[4],
                    child: Transform.translate(  //QuesitosGeneral J4
                      offset: const Offset(260, 60),
                      child: Container(
                        width: 40,
                        height: 40,
                        child: Image(image: AssetImage(quesitosGeneral),fit: BoxFit.fill,),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: jVisibles[4]  && quesitosJug[4][0],
                    child: Transform.translate(  //QuesitoHistoria J4
                      offset: const Offset(260, 60),
                      child: Container(
                        width: 40,
                        height: 40,
                        child: Image(image: AssetImage(quesitoHistoria),fit: BoxFit.fill,),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: jVisibles[4] && quesitosJug[3][1],
                    child: Transform.translate(  //QuesitoArte J4
                      offset: const Offset(260, 60),
                      child: Container(
                        width: 40,
                        height: 40,
                        child: Image(image: AssetImage(quesitoArte),fit: BoxFit.fill,),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: jVisibles[4] && quesitosJug[3][2],
                    child: Transform.translate(  //QuesitoDeportes J4
                      offset: const Offset(260, 60),
                      child: Container(
                        width: 40,
                        height: 40,
                        child: Image(image: AssetImage(quesitoDeportes),fit: BoxFit.fill,),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: jVisibles[4] && quesitosJug[3][3],
                    child: Transform.translate(  //QuesitoCiencia J4
                      offset: const Offset(260, 60),
                      child: Container(
                        width: 40,
                        height: 40,
                        child: Image(image: AssetImage(quesitoCiencia),fit: BoxFit.fill,),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: jVisibles[4] && quesitosJug[3][4],
                    child: Transform.translate(  //QuesitoEntretenimiento J4
                      offset: const Offset(260, 60),
                      child: Container(
                        width: 40,
                        height: 40,
                        child: Image(image: AssetImage(quesitoEntretenimiento),fit: BoxFit.fill,),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: jVisibles[4] && quesitosJug[3][5],
                    child: Transform.translate(  //QuesitoGeografia J4
                      offset: const Offset(260, 60),
                      child: Container(
                        width: 40,
                        height: 40,
                        child: Image(image: AssetImage(quesitoGeografia),fit: BoxFit.fill,),
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
                    visible: jVisibles[5] && turnoActual == 5,
                    child: Transform.translate(  //Imagen turno J5
                      offset: const Offset(290, 130),
                      child: Container(
                        width: 70,
                        height: 70,
                        child: Image(image: AssetImage(imagenJugadorTurno),fit: BoxFit.fill,),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: jVisibles[5],
                    child: Transform.translate(  //QuesitosGeneral J5
                      offset: const Offset(260, 180),
                      child: Container(
                        width: 40,
                        height: 40,
                        child: Image(image: AssetImage(quesitosGeneral),fit: BoxFit.fill,),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: jVisibles[5] && quesitosJug[4][0],
                    child: Transform.translate(  //QuesitoHistoria J5
                      offset: const Offset(260, 180),
                      child: Container(
                        width: 40,
                        height: 40,
                        child: Image(image: AssetImage(quesitoHistoria),fit: BoxFit.fill,),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: jVisibles[5] && quesitosJug[4][1],
                    child: Transform.translate(  //QuesitoArte J5
                      offset: const Offset(260, 180),
                      child: Container(
                        width: 40,
                        height: 40,
                        child: Image(image: AssetImage(quesitoArte),fit: BoxFit.fill,),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: jVisibles[5] && quesitosJug[4][2],
                    child: Transform.translate(  //QuesitoDeportes J5
                      offset: const Offset(260, 180),
                      child: Container(
                        width: 40,
                        height: 40,
                        child: Image(image: AssetImage(quesitoDeportes),fit: BoxFit.fill,),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: jVisibles[5] && quesitosJug[4][3],
                    child: Transform.translate(  //QuesitoCiencia J5
                      offset: const Offset(260, 180),
                      child: Container(
                        width: 40,
                        height: 40,
                        child: Image(image: AssetImage(quesitoCiencia),fit: BoxFit.fill,),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: jVisibles[5] && quesitosJug[4][4],
                    child: Transform.translate(  //QuesitoEntretenimiento J5
                      offset: const Offset(260, 180),
                      child: Container(
                        width: 40,
                        height: 40,
                        child: Image(image: AssetImage(quesitoEntretenimiento),fit: BoxFit.fill,),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: jVisibles[5] && quesitosJug[4][5],
                    child: Transform.translate(  //QuesitoGeografia J5
                      offset: const Offset(260, 180),
                      child: Container(
                        width: 40,
                        height: 40,
                        child: Image(image: AssetImage(quesitoGeografia),fit: BoxFit.fill,),
                      ),
                    ),
                  ),                  


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
                        // startTimer();
                        // alternarCasilla(72);
                        // print("pulsado72");
                      },
                    ),
                  ),
                  //C51
                  Transform.rotate(
                    angle: -27 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(19, 66),
                      child: RectangleButton(
                        color: casillaCambia[51] == true ? colorVariado[51] : colorCasillas[51],
                        onPressed: () {
                          //_cambiarColor2();
                          // print("pulsado51");
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
                        color: casillaCambia[50] == true ? colorVariado[50] : colorCasillas[50],
                        onPressed: () {
                          //_cambiarColor2();
                          // print("pulsado52");
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
                        color: casillaCambia[49] == true ? colorVariado[49] : colorCasillas[49],
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
                        color: casillaCambia[48] == true ? colorVariado[48] : colorCasillas[48],
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
                        color: casillaCambia[47] == true ? colorVariado[47] : colorCasillas[47],
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
                        color: casillaCambia[46] == true ? colorVariado[46] : colorCasillas[46],
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
                        color: casillaCambia[45] == true ? colorVariado[45] : colorCasillas[45],
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
                        color: casillaCambia[44] == true ? colorVariado[44] : colorCasillas[44],
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
                        color: casillaCambia[43] == true ? colorVariado[43] : colorCasillas[43],
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
                        color: casillaCambia[42] == true ? colorVariado[42] : colorCasillas[42],
                        onPressed: () {
                          //_cambiarColor2();
                          // print("pulsado42");
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
                          // alternarCasilla(6);
                          // print("pulsado6");
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
                          // alternarCasilla(5);
                          // print("pulsado5");
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
                          // alternarCasilla(4);
                          // print("pulsado4");
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
                          // alternarCasilla(3);
                          // print("pulsado3");
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
                          // alternarCasilla(2);
                          // print("pulsado2");
                        },
                      ),
                    ),
                  ),
                  //C1
                  Transform.rotate(
                    angle: -90 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-150, -25),
                      child: RectangleButton(
                        color: casillaCambia[1] == true ? colorVariado[1] : colorCasillas[1],
                        onPressed: () {
                          //_cambiarColor2();
                          // alternarCasilla(1);
                          // print("pulsado1");
                        },
                      ),
                    ),
                  ),
                  
                  //C8
                  Transform.rotate(
                    angle: -148 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-142, -23),
                      child: RectangleButton(
                        color: casillaCambia[8] == true ? colorVariado[8] : colorCasillas[8],
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
                        color: casillaCambia[9] == true ? colorVariado[9] : colorCasillas[9],
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
                        color: casillaCambia[10] == true ? colorVariado[10] : colorCasillas[10],
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
                        color: casillaCambia[11] == true ? colorVariado[11] : colorCasillas[11],
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
                        color: casillaCambia[12] == true ? colorVariado[12] : colorCasillas[12],
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
                        color: casillaCambia[13] == true ? colorVariado[13] : colorCasillas[13],
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
                        color: casillaCambia[7] == true ? colorVariado[7] : colorCasillas[7],
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
                        color: casillaCambia[56] == true ? colorVariado[56] : colorCasillas[56],
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
                        color: casillaCambia[55] == true ? colorVariado[55] : colorCasillas[55],
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
                        color: casillaCambia[54] == true ? colorVariado[54] : colorCasillas[54],
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
                        color: casillaCambia[53] == true ? colorVariado[53] : colorCasillas[53],
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
                        color: casillaCambia[52] == true ? colorVariado[52] : colorCasillas[52],
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
                        color: casillaCambia[71] == true ? colorVariado[71] : colorCasillas[71],
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
                        color: casillaCambia[70] == true ? colorVariado[70] : colorCasillas[70],
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
                        color: casillaCambia[69] == true ? colorVariado[69] : colorCasillas[69],
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
                        color: casillaCambia[68] == true ? colorVariado[68] : colorCasillas[68],
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
                        color: casillaCambia[67] == true ? colorVariado[67] : colorCasillas[67],
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
                        color: casillaCambia[41] == true ? colorVariado[41] : colorCasillas[41],
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
                        color: casillaCambia[40] == true ? colorVariado[40] : colorCasillas[40],
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
                        color: casillaCambia[39] == true ? colorVariado[39] : colorCasillas[39],
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
                        color: casillaCambia[38] == true ? colorVariado[38] : colorCasillas[38],
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
                        color: casillaCambia[37] == true ? colorVariado[37] : colorCasillas[37],
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
                        color: casillaCambia[36] == true ? colorVariado[36] : colorCasillas[36],
                        onPressed: () {
                          //_cambiarColor2();
                          // print("pulsado36");
                        },
                      ),
                    ),
                  ),
                  //C0
                  Transform.rotate(
                    angle: 207 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(30, -178),
                      child: Esquina3Button(
                        color: casillaCambia[0] == true ? colorVariado[0] : colorCasillas[0],
                        onPressed: () {
                          //_cambiarColor2();
                          alternarCasilla(0);
                        },
                      ),
                    ),
                  ),

                  //C66
                  Transform.rotate(
                    angle: -207 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(19, 66),
                      child: RectangleButton(
                        color: casillaCambia[66] == true ? colorVariado[66] : colorCasillas[66],
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
                        color: casillaCambia[65] == true ? colorVariado[65] : colorCasillas[65],
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
                        color: casillaCambia[64] == true ? colorVariado[64] : colorCasillas[64],
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
                        color: casillaCambia[63] == true ? colorVariado[63] : colorCasillas[63],
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
                        color: casillaCambia[62] == true ? colorVariado[62] : colorCasillas[62],
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
                        color: casillaCambia[29] == true ? colorVariado[29] : colorCasillas[29],
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
                        color: casillaCambia[30] == true ? colorVariado[30] : colorCasillas[30],
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
                        color: casillaCambia[31] == true ? colorVariado[31] : colorCasillas[31],
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
                        color: casillaCambia[32] == true ? colorVariado[32] : colorCasillas[32],
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
                        color: casillaCambia[33] == true ? colorVariado[33] : colorCasillas[33],
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
                        color: casillaCambia[34] == true ? colorVariado[34] : colorCasillas[34],
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
                        color: casillaCambia[61] == true ? colorVariado[61] : colorCasillas[61],
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
                        color: casillaCambia[60] == true ? colorVariado[60] : colorCasillas[60],
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
                        color: casillaCambia[59] == true ? colorVariado[59] : colorCasillas[59],
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
                        color: casillaCambia[58] == true ? colorVariado[58] : colorCasillas[58],
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
                        color: casillaCambia[57] == true ? colorVariado[57] : colorCasillas[57],
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
                        color: casillaCambia[27] == true ? colorVariado[27] : colorCasillas[27],
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
                        color: casillaCambia[26] == true ? colorVariado[26] : colorCasillas[26],
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
                        color: casillaCambia[25] == true ? colorVariado[25] : colorCasillas[25],
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
                        color: casillaCambia[24] == true ? colorVariado[24] : colorCasillas[24],
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
                        color: casillaCambia[23] == true ? colorVariado[23] : colorCasillas[23],
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
                        color: casillaCambia[22] == true ? colorVariado[22] : colorCasillas[22],
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
                        color: casillaCambia[20] == true ? colorVariado[20] : colorCasillas[20],
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
                        color: casillaCambia[19] == true ? colorVariado[19] : colorCasillas[19],
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
                        color: casillaCambia[18] == true ? colorVariado[18] : colorCasillas[18],
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
                        color: casillaCambia[17] == true ? colorVariado[17] : colorCasillas[17],
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
                        color: casillaCambia[16] == true ? colorVariado[16] : colorCasillas[16],
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
                        color: casillaCambia[15] == true ? colorVariado[15] : colorCasillas[15],
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
                        color: casillaCambia[35] == true ? colorVariado[35] : colorCasillas[35],
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
                        color: casillaCambia[28] == true ? colorVariado[28] : colorCasillas[28],
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
                        color: casillaCambia[21] == true ? colorVariado[21] : colorCasillas[21],
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
                        color: casillaCambia[14] == true ? colorVariado[14] : colorCasillas[14],
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
                  Transform.rotate(
                    angle: -330 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(33, 170),
                      child: TriangleWidget(color: Verde),
                    ),
                  ),

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
                  Transform.translate(
                    offset: const Offset(-240, 0),
                    child: Padding(
                      padding: EdgeInsets.only(top: 180, left: 80), // ajusta los valores según tus necesidades
                      child: BotonHome(
                        "Salir",
                        onPressed: () {
                          // Navigator.push(
                          //   // context,
                          //   // MaterialPageRoute(builder: (context) => const Menu()),
                          // );
                        },
                      ),
                    ),
                  ),

                  //BOTON TEMPORAL REINICIO TURNO
                  Padding(
                    padding: EdgeInsets.only(top: 190, left: 300), // ajusta los valores según tus necesidades
                    child: ElevatedButton(
                      onPressed: () {
                        _resetTurno;
                        pasoTurno();//BORRAR
                        sumaPruCasilla();
                        // calcularDiferencia(coordenadasFichaJ0, coordenadasFichaJ2);
                        // calcularSuma(coordenadasFichaJ2,coordenadasDiferencia);
                      },
                      child: Text('Reiniciar turno'),
                    ),
                  ),

                  //BOTON CHAT
                  Transform.translate(
                    offset: const Offset(375, -125),
                    child: Container(
                      width: 80,
                      height: 50,
                      decoration: const BoxDecoration(
                        // image: DecorationImage(
                        //   image: AssetImage('assets/Chat.png'),
                        //   fit: BoxFit.fill,
                        // ),
                      ),
                    ),
                  ),            

                  
                   
                  //FICHAS---------------------------------------------------------------------------------------------
                  jVisibles[0]?
                    Transform.translate(  //Ficha J0
                      offset: coordenadasFichaJ0[casillaPru],//coordenadasFichaJ1[posicionesFichas[0]],
                      child: Container(
                        width: 15,
                        height: 15,
                        child: Image.network(fichasJugadores[0],fit: BoxFit.fill,),
                      ),
                    ): const SizedBox.shrink(),
                  Visibility(
                    visible: jVisibles[1],
                    child: Transform.translate(  //Ficha J1
                      offset: coordenadasFichaJ1[casillaPru],
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
                      offset: coordenadasFichaJ2[casillaPru],
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
                      offset: coordenadasFichaJ3[casillaPru],
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
                      offset: coordenadasFichaJ4[casillaPru],
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
                      offset: coordenadasFichaJ5[casillaPru],
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

            //BOTONES CASILLAS-------------------------------------------------------------------------------------
            //c0 boton
            Transform.rotate(
              angle: 116 * pi / 180,
              child: Transform.translate(
                offset: const Offset(138,-379), 
                child: Ink(
                  width: 61,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      print('0');
                      alternarCasilla(0);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c1 boton
            Transform.rotate(
              angle: -90 * pi / 180,
              child: Transform.translate(
                offset: const Offset(-320, 316), 
                child: Ink(
                  width: 39,
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      print('1');
                      alternarCasilla(1);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c2 boton
            Transform.rotate(
              angle: -90 * pi / 180,
              child: Transform.translate(
                offset: const Offset(-320, 336), 
                child: Ink(
                  width: 39,
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      print('2');
                      alternarCasilla(2);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c3 boton
            Transform.rotate(
              angle: -90 * pi / 180,
              child: Transform.translate(
                offset: const Offset(-320, 356), 
                child: Ink(
                  width: 39,
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      print('3');
                      alternarCasilla(3);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c4 boton
            Transform.rotate(
              angle: -90 * pi / 180,
              child: Transform.translate(
                offset: const Offset(-320, 376), 
                child: Ink(
                  width: 39,
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      print('4');
                      alternarCasilla(4);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c5 boton
            Transform.rotate(
              angle: -90 * pi / 180,
              child: Transform.translate(
                offset: const Offset(-320, 396), 
                child: Ink(
                  width: 39,
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      print('5');
                      alternarCasilla(5);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c6 boton
            Transform.rotate(
              angle: -90 * pi / 180,
              child: Transform.translate(
                offset: const Offset(-320, 416), 
                child: Ink(
                  width: 39,
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      print('6');
                      alternarCasilla(6);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c7 boton
            Transform.rotate(
              angle: -115 * pi / 180,
              child: Transform.translate(
                offset: const Offset(-446, 273), 
                child: Ink(
                  width: 57,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      print('7');
                      alternarCasilla(7);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c8 boton
            Transform.rotate(
              angle: 33 * pi / 180,
              child: Transform.translate(
                offset: const Offset(549, -22), 
                child: Ink(
                  width: 39,
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      print('8');
                      alternarCasilla(8);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c9 boton
            Transform.rotate(
              angle: 33 * pi / 180,
              child: Transform.translate(
                offset: const Offset(549, -42), 
                child: Ink(
                  width: 39,
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      print('9');
                      alternarCasilla(9);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c10 boton
            Transform.rotate(
              angle: 33 * pi / 180,
              child: Transform.translate(
                offset: const Offset(549, -62), 
                child: Ink(
                  width: 39,
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      print('10');
                      alternarCasilla(10);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c11 boton
            Transform.rotate(
              angle: 33 * pi / 180,
              child: Transform.translate(
                offset: const Offset(549, -82), 
                child: Ink(
                  width: 39,
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      print('11');
                      alternarCasilla(11);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c12 boton
            Transform.rotate(
              angle: 33 * pi / 180,
              child: Transform.translate(
                offset: const Offset(549, -102), 
                child: Ink(
                  width: 39,
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      print('12');
                      alternarCasilla(12);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c13 boton
            Transform.rotate(
              angle: 33 * pi / 180,
              child: Transform.translate(
                offset: const Offset(549, -122), 
                child: Ink(
                  width: 39,
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      print('13');
                      alternarCasilla(13);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c14 boton
            Transform.rotate(
              angle: 0 * pi / 180,
              child: Transform.translate(
                offset: const Offset(521,145), 
                child: Ink(
                  width: 48,
                  height: 44,
                  child: ElevatedButton(
                    onPressed: () {
                      print('14');
                      alternarCasilla(14);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c15 boton
            Transform.rotate(
              angle: -33 * pi / 180,
              child: Transform.translate(
                offset: const Offset(380, 383), 
                child: Ink(
                  width: 39,
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      print('15');
                      alternarCasilla(15);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c16 boton
            Transform.rotate(
              angle: -33 * pi / 180,
              child: Transform.translate(
                offset: const Offset(381, 363), 
                child: Ink(
                  width: 39,
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      print('16');
                      alternarCasilla(16);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c17 boton
            Transform.rotate(
              angle: -33 * pi / 180,
              child: Transform.translate(
                offset: const Offset(382, 343), 
                child: Ink(
                  width: 39,
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      print('17');
                      alternarCasilla(17);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c18 boton
            Transform.rotate(
              angle: -33 * pi / 180,
              child: Transform.translate(
                offset: const Offset(383, 323), 
                child: Ink(
                  width: 39,
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      print('18');
                      alternarCasilla(18);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c19 boton
            Transform.rotate(
              angle: -33 * pi / 180,
              child: Transform.translate(
                offset: const Offset(384, 303), 
                child: Ink(
                  width: 39,
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      print('19');
                      alternarCasilla(19);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c20 boton
            Transform.rotate(
              angle: -33 * pi / 180,
              child: Transform.translate(
                offset: const Offset(384, 283), 
                child: Ink(
                  width: 39,
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      print('20');
                      alternarCasilla(20);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c21 boton
            Transform.rotate(
              angle: -62 * pi / 180,
              child: Transform.translate(
                offset: const Offset(202,390), 
                child: Ink(
                  width: 57,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      print('21');
                      alternarCasilla(21);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c22 boton
            Transform.rotate(
              angle: 90 * pi / 180,
              child: Transform.translate(
                offset: const Offset(0, -418), 
                child: Ink(
                  width: 39,
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      print('22');
                      alternarCasilla(22);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c23 boton
            Transform.rotate(
              angle: 90 * pi / 180,
              child: Transform.translate(
                offset: const Offset(0, -398), 
                child: Ink(
                  width: 39,
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      print('23');
                      alternarCasilla(23);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c24 boton
            Transform.rotate(
              angle: 90 * pi / 180,
              child: Transform.translate(
                offset: const Offset(0, -378), 
                child: Ink(
                  width: 39,
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      print('24');
                      alternarCasilla(24);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c25 boton
            Transform.rotate(
              angle: 90 * pi / 180,
              child: Transform.translate(
                offset: const Offset(0, -358), 
                child: Ink(
                  width: 39,
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      print('25');
                      alternarCasilla(25);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c26 boton
            Transform.rotate(
              angle: 90 * pi / 180,
              child: Transform.translate(
                offset: const Offset(0, -338), 
                child: Ink(
                  width: 39,
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      print('26');
                      alternarCasilla(26);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c27 boton
            Transform.rotate(
              angle: 90 * pi / 180,
              child: Transform.translate(
                offset: const Offset(0, -318), 
                child: Ink(
                  width: 39,
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      print('27');
                      alternarCasilla(27);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c28 boton
            Transform.rotate(
              angle: 62 * pi / 180,
              child: Transform.translate(
                offset: const Offset(135,-245), 
                child: Ink(
                  width: 57,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      print('28');
                      alternarCasilla(28);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c29 boton
            Transform.rotate(
              angle: -150 * pi / 180,
              child: Transform.translate(
                offset: const Offset(-237, 102), 
                child: Ink(
                  width: 39,
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      print('29');
                      alternarCasilla(29);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c30 boton
            Transform.rotate(
              angle: -150 * pi / 180,
              child: Transform.translate(
                offset: const Offset(-237, 82), 
                child: Ink(
                  width: 39,
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      print('30');
                      alternarCasilla(30);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c31 boton
            Transform.rotate(
              angle: -150 * pi / 180,
              child: Transform.translate(
                offset: const Offset(-237, 62), 
                child: Ink(
                  width: 39,
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      print('31');
                      alternarCasilla(31);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c32 boton
            Transform.rotate(
              angle: -150 * pi / 180,
              child: Transform.translate(
                offset: const Offset(-237, 42), 
                child: Ink(
                  width: 39,
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      print('32');
                      alternarCasilla(32);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c33 boton
            Transform.rotate(
              angle: -150 * pi / 180,
              child: Transform.translate(
                offset: const Offset(-236, 22), 
                child: Ink(
                  width: 39,
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      print('33');
                      alternarCasilla(33);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c34 boton
            Transform.rotate(
              angle: -150 * pi / 180,
              child: Transform.translate(
                offset: const Offset(-236, 2), 
                child: Ink(
                  width: 39,
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      print('34');
                      alternarCasilla(34);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c35 boton
            Transform.rotate(
              angle: 0 * pi / 180,
              child: Transform.translate(
                offset: const Offset(201,146), 
                child: Ink(
                  width: 48,
                  height: 44,
                  child: ElevatedButton(
                    onPressed: () {
                      print('35');
                      alternarCasilla(35);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c36 boton
            Transform.rotate(
              angle: 149 * pi / 180,
              child: Transform.translate(
                offset: const Offset(-71, -280), 
                child: Ink(
                  width: 39,
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      print('36');
                      alternarCasilla(36);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c37 boton
            Transform.rotate(
              angle: 149 * pi / 180,
              child: Transform.translate(
                offset: const Offset(-71, -301), 
                child: Ink(
                  width: 39,
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      print('37');
                      alternarCasilla(37);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c38 boton
            Transform.rotate(
              angle: 149 * pi / 180,
              child: Transform.translate(
                offset: const Offset(-71, -322), 
                child: Ink(
                  width: 39,
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      print('38');
                      alternarCasilla(38);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c39 boton
            Transform.rotate(
              angle: 149 * pi / 180,
              child: Transform.translate(
                offset: const Offset(-70, -342), 
                child: Ink(
                  width: 39,
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      print('39');
                      alternarCasilla(39);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c40 boton
            Transform.rotate(
              angle: 149 * pi / 180,
              child: Transform.translate(
                offset: const Offset(-70, -362), 
                child: Ink(
                  width: 39,
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      print('40');
                      alternarCasilla(40);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c41 boton
            Transform.rotate(
              angle: 149 * pi / 180,
              child: Transform.translate(
                offset: const Offset(-70, -382), 
                child: Ink(
                  width: 39,
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      print('41');
                      alternarCasilla(41);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c42 boton
            Transform.rotate(
              angle: 25 * pi / 180,
              child: Transform.translate(
                offset: const Offset(392, 109), 
                child: Ink(
                  width: 39,
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      print('42');
                      alternarCasilla(42);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c43 boton
            Transform.rotate(
              angle: 25 * pi / 180,
              child: Transform.translate(
                offset: const Offset(392, 88), 
                child: Ink(
                  width: 39,
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      print('43');
                      alternarCasilla(43);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c44 boton
            Transform.rotate(
              angle: 25 * pi / 180,
              child: Transform.translate(
                offset: const Offset(392, 68), 
                child: Ink(
                  width: 39,
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      print('44');
                      alternarCasilla(44);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c45 boton
            Transform.rotate(
              angle: 25 * pi / 180,
              child: Transform.translate(
                offset: const Offset(392, 48), 
                child: Ink(
                  width: 39,
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      print('45');
                      alternarCasilla(45);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c46 boton
            Transform.rotate(
              angle: 25 * pi / 180,
              child: Transform.translate(
                offset: const Offset(392, 28), 
                child: Ink(
                  width: 39,
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      print('46');
                      alternarCasilla(46);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c47 boton
            Transform.rotate(
              angle: -28 * pi / 180,
              child: Transform.translate(
                offset: const Offset(251, 435), 
                child: Ink(
                  width: 39,
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      print('47');
                      alternarCasilla(47);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c48 boton
            Transform.rotate(
              angle: -28 * pi / 180,
              child: Transform.translate(
                offset: const Offset(251, 414), 
                child: Ink(
                  width: 39,
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      print('48');
                      alternarCasilla(48);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c49 boton
            Transform.rotate(
              angle: -28 * pi / 180,
              child: Transform.translate(
                offset: const Offset(251, 393), 
                child: Ink(
                  width: 39,
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      print('49');
                      alternarCasilla(49);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c50 boton
            Transform.rotate(
              angle: -28 * pi / 180,
              child: Transform.translate(
                offset: const Offset(252, 372), 
                child: Ink(
                  width: 39,
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      print('50');
                      alternarCasilla(50);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c51 boton
            Transform.rotate(
              angle: -28 * pi / 180,
              child: Transform.translate(
                offset: const Offset(252, 351), 
                child: Ink(
                  width: 39,
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      print('51');
                      alternarCasilla(51);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c52 boton
            Transform.rotate(
              angle: 90 * pi / 180,
              child: Transform.translate(
                offset: const Offset(157, -492), 
                child: Ink(
                  width: 39,
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      print('52');
                      alternarCasilla(52);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c53 boton
            Transform.rotate(
              angle: 90 * pi / 180,
              child: Transform.translate(
                offset: const Offset(157, -472), 
                child: Ink(
                  width: 39,
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      print('53');
                      alternarCasilla(53);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c54 boton
            Transform.rotate(
              angle: 90 * pi / 180,
              child: Transform.translate(
                offset: const Offset(157, -452), 
                child: Ink(
                  width: 39,
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      print('54');
                      alternarCasilla(54);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c55 boton
            Transform.rotate(
              angle: 90 * pi / 180,
              child: Transform.translate(
                offset: const Offset(157, -432), 
                child: Ink(
                  width: 39,
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      print('55');
                      alternarCasilla(55);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c56 boton
            Transform.rotate(
              angle: 90 * pi / 180,
              child: Transform.translate(
                offset: const Offset(157, -412), 
                child: Ink(
                  width: 39,
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      print('56');
                      alternarCasilla(56);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c57 boton
            Transform.rotate(
              angle: 210 * pi / 180,
              child: Transform.translate(
                offset: const Offset(-395, 171), 
                child: Ink(
                  width: 39,
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      print('57');
                      alternarCasilla(57);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c58 boton
            Transform.rotate(
              angle: 210 * pi / 180,
              child: Transform.translate(
                offset: const Offset(-395, 151), 
                child: Ink(
                  width: 39,
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      print('58');
                      alternarCasilla(58);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c59 boton
            Transform.rotate(
              angle: 210 * pi / 180,
              child: Transform.translate(
                offset: const Offset(-395, 131), 
                child: Ink(
                  width: 39,
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      print('59');
                      alternarCasilla(59);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c60 boton
            Transform.rotate(
              angle: 210 * pi / 180,
              child: Transform.translate(
                offset: const Offset(-395, 110), 
                child: Ink(
                  width: 39,
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      print('60');
                      alternarCasilla(60);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c61 boton
            Transform.rotate(
              angle: 210 * pi / 180,
              child: Transform.translate(
                offset: const Offset(-395, 90), 
                child: Ink(
                  width: 39,
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      print('61');
                      alternarCasilla(61);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c62 boton
            Transform.rotate(
              angle: 150 * pi / 180,
              child: Transform.translate(
                offset: const Offset(-242, -195), 
                child: Ink(
                  width: 39,
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      print('62');
                      alternarCasilla(62);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c63 boton
            Transform.rotate(
              angle: 150 * pi / 180,
              child: Transform.translate(
                offset: const Offset(-240, -215), 
                child: Ink(
                  width: 39,
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      print('63');
                      alternarCasilla(63);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c64 boton
            Transform.rotate(
              angle: 150 * pi / 180,
              child: Transform.translate(
                offset: const Offset(-240, -235), 
                child: Ink(
                  width: 39,
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      print('64');
                      alternarCasilla(64);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c65 boton
            Transform.rotate(
              angle: 150 * pi / 180,
              child: Transform.translate(
                offset: const Offset(-239, -255), 
                child: Ink(
                  width: 39,
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      print('65');
                      alternarCasilla(65);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c66 boton
            Transform.rotate(
              angle: 150 * pi / 180,
              child: Transform.translate(
                offset: const Offset(-238, -275), 
                child: Ink(
                  width: 39,
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      print('66');
                      alternarCasilla(66);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c67 boton
            Transform.rotate(
              angle: 90 * pi / 180,
              child: Transform.translate(
                offset: const Offset(157, -241), 
                child: Ink(
                  width: 39,
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      print('67');
                      alternarCasilla(67);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c68 boton
            Transform.rotate(
              angle: 90 * pi / 180,
              child: Transform.translate(
                offset: const Offset(157, -261), 
                child: Ink(
                  width: 39,
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      print('68');
                      alternarCasilla(68);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c69 boton
            Transform.rotate(
              angle: 90 * pi / 180,
              child: Transform.translate(
                offset: const Offset(157, -281), 
                child: Ink(
                  width: 39,
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      print('69');
                      alternarCasilla(69);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c70 boton
            Transform.rotate(
              angle: 90 * pi / 180,
              child: Transform.translate(
                offset: const Offset(157, -301), 
                child: Ink(
                  width: 39,
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      print('70');
                      alternarCasilla(70);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c71 boton
            Transform.rotate(
              angle: 90 * pi / 180,
              child: Transform.translate(
                offset: const Offset(157, -321), 
                child: Ink(
                  width: 39,
                  height: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      print('71');
                      alternarCasilla(71);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0,
                    ),
                  ),
                ),
              ),
            ),

            //c72 boton
            Transform.rotate(
              angle: 90 * pi / 180,
              child: Transform.translate(
                offset: const Offset(130, -364), 
                child: Ink(
                  width: 44,
                  height: 70,
                  child: ElevatedButton(
                    onPressed: () {
                      print('72');
                      alternarCasilla(72);
                    },
                    child: null,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Color.fromARGB(0, 0, 0, 0), 
                      padding: EdgeInsets.zero, 
                      elevation: 0, //elimina la sombra del boton
                      splashFactory: NoSplash.splashFactory, //elimina la onda que aparece al pulsar el boton
                      //no consigo quitar la sombra que genera al pulsarse pero si la onda
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
