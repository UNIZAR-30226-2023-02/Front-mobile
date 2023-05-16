import 'dart:io';
import 'dart:math';
import 'dart:async';
import 'dart:ui';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Data_types/mensaje.dart';

import 'package:flutter_application_1/Interfaz/Menu/home.dart';
import 'package:flutter/services.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:web_socket_channel/io.dart';

import '../../API/index.dart';
import '../../Data_types/index.dart';
import '../InicioSesion_Registro/Estilo/botones.dart';

class Juego extends StatefulWidget {
  const Juego(this._s, this._wS, this._tP, {Key? key}) : super(key: key);
  final String _wS, _tP;
  final Sesion _s;
  @override
  _JuegoState createState() => _JuegoState(_s, _wS, _tP);
}

class _JuegoState extends State<Juego> {
  Color Azul = Colors.blue;
  Color Naranja = const Color.fromARGB(255, 240, 143, 17);
  Color Rojo = const Color.fromARGB(255, 230, 44, 19);
  Color Rosa = const Color.fromARGB(255, 230, 32, 187);
  Color Verde = const Color.fromARGB(255, 53, 224, 18);
  Color Amarillo = const Color.fromARGB(180, 219, 205, 0);
  Color Blanco = const Color.fromARGB(255, 255, 255, 255);
  Color colorPregunta = Colors.blue;
  Color Gris = Colors.grey;

  Color Fallo = Color.fromARGB(255, 194, 36, 15);
  Color Acierto = Color.fromARGB(255, 47, 199, 17);

  List<bool> casillaCambia = List.generate(73, (index) => false);

  List<Color> colorVariado = List.generate(73, (index) => Colors.grey);
  List<Color> colorCasillas = [
    const Color.fromARGB(255, 255, 255, 255),
    const Color.fromARGB(255, 240, 143, 17),
    const Color.fromARGB(255, 255, 255, 255),
    const Color.fromARGB(255, 219, 205, 0),
    const Color.fromARGB(255, 230, 44, 19),
    const Color.fromARGB(255, 255, 255, 255),
    Colors.blue,
    const Color.fromARGB(255, 255, 255, 255),
    Colors.blue,
    const Color.fromARGB(255, 255, 255, 255),
    const Color.fromARGB(255, 240, 143, 17),
    const Color.fromARGB(255, 53, 224, 18),
    const Color.fromARGB(255, 255, 255, 255),
    const Color.fromARGB(255, 230, 44, 19),
    const Color.fromARGB(255, 255, 255, 255),
    const Color.fromARGB(255, 230, 44, 19),
    const Color.fromARGB(255, 255, 255, 255),
    Colors.blue,
    const Color.fromARGB(255, 230, 32, 187),
    const Color.fromARGB(255, 255, 255, 255),
    const Color.fromARGB(255, 53, 224, 18),
    const Color.fromARGB(255, 255, 255, 255),
    const Color.fromARGB(255, 53, 224, 18),
    const Color.fromARGB(255, 255, 255, 255),
    const Color.fromARGB(255, 230, 44, 19),
    const Color.fromARGB(255, 219, 205, 0),
    const Color.fromARGB(255, 255, 255, 255),
    const Color.fromARGB(255, 230, 32, 187),
    const Color.fromARGB(255, 255, 255, 255),
    const Color.fromARGB(255, 230, 32, 187),
    const Color.fromARGB(255, 255, 255, 255),
    const Color.fromARGB(255, 53, 224, 18),
    const Color.fromARGB(255, 240, 143, 17),
    const Color.fromARGB(255, 255, 255, 255),
    const Color.fromARGB(255, 219, 205, 0),
    const Color.fromARGB(255, 255, 255, 255),
    const Color.fromARGB(255, 219, 205, 0),
    const Color.fromARGB(255, 255, 255, 255),
    const Color.fromARGB(255, 230, 32, 187),
    Colors.blue,
    const Color.fromARGB(255, 255, 255, 255),
    const Color.fromARGB(255, 240, 143, 17),
    const Color.fromARGB(255, 240, 143, 17),
    const Color.fromARGB(255, 219, 205, 0),
    Colors.blue,
    const Color.fromARGB(255, 230, 44, 19),
    const Color.fromARGB(255, 230, 32, 187),
    Colors.blue,
    const Color.fromARGB(255, 240, 143, 17),
    const Color.fromARGB(255, 230, 44, 19),
    const Color.fromARGB(255, 53, 224, 18),
    const Color.fromARGB(255, 219, 205, 0),
    const Color.fromARGB(255, 230, 44, 19),
    Colors.blue,
    const Color.fromARGB(255, 53, 224, 18),
    const Color.fromARGB(255, 230, 32, 187),
    const Color.fromARGB(255, 240, 143, 17),
    const Color.fromARGB(255, 53, 224, 18),
    const Color.fromARGB(255, 230, 44, 19),
    const Color.fromARGB(255, 230, 32, 187),
    const Color.fromARGB(255, 219, 205, 0),
    Colors.blue,
    const Color.fromARGB(255, 230, 32, 187),
    const Color.fromARGB(255, 53, 224, 18),
    const Color.fromARGB(255, 219, 205, 0),
    const Color.fromARGB(255, 240, 143, 17),
    const Color.fromARGB(255, 230, 44, 19),
    const Color.fromARGB(255, 219, 205, 0),
    const Color.fromARGB(255, 230, 32, 187),
    const Color.fromARGB(255, 240, 143, 17),
    Colors.blue,
    const Color.fromARGB(255, 53, 224, 18),
    const Color.fromARGB(255, 255, 255, 255),
  ];

  List<Offset> coordenadasFichaJ0 = [
    const Offset(-47, 158),
    const Offset(-26, 185),
    const Offset(-6, 185),
    const Offset(14, 185),
    const Offset(34, 185),
    const Offset(54, 185),
    const Offset(74, 185),
    const Offset(90, 170),
    const Offset(123, 150),
    const Offset(133, 140),
    const Offset(143, 120),
    const Offset(153, 100),
    const Offset(163, 80),
    const Offset(173, 67),
    const Offset(173, 47),
    const Offset(179, 0),
    const Offset(169, -16),
    const Offset(159, -36),
    const Offset(149, -50),
    const Offset(140, -67),
    const Offset(132, -83),
    const Offset(112, -88),
    const Offset(75, -110),
    const Offset(65, -110),
    const Offset(45, -110),
    const Offset(25, -110),
    const Offset(5, -110),
    const Offset(-15, -110),
    const Offset(-35, -100),
    const Offset(-70, -85),
    const Offset(-78, -73),
    const Offset(-87, -53),
    const Offset(-97, -37),
    const Offset(-107, -21),
    const Offset(-117, -4),
    const Offset(-117, 20),
    const Offset(-123, 65),
    const Offset(-113, 85),
    const Offset(-103, 105),
    const Offset(-93, 122),
    const Offset(-82, 138),
    const Offset(-70, 155),
    const Offset(-43, 138),
    const Offset(-33, 118),
    const Offset(-25, 100),
    const Offset(-17, 83),
    const Offset(-7, 65),
    const Offset(78, 152),
    const Offset(68, 133),
    const Offset(58, 113),
    const Offset(48, 97),
    const Offset(40, 77),
    const Offset(150, 50),
    const Offset(130, 50),
    const Offset(110, 50),
    const Offset(90, 50),
    const Offset(70, 50),
    const Offset(72, -79),
    const Offset(62, -59),
    const Offset(52, -42),
    const Offset(44, -25),
    const Offset(34, -5),
    const Offset(-40, -65),
    const Offset(-30, -45),
    const Offset(-22, -28),
    const Offset(-14, -10),
    const Offset(-4, 8),
    const Offset(-104, 20),
    const Offset(-80, 20),
    const Offset(-63, 20),
    const Offset(-43, 20),
    const Offset(-23, 20),
    const Offset(10, 20)
  ];

  List<Offset> coordenadasFichaJ1 = [
    const Offset(-37, 158),
    const Offset(-16, 185),
    const Offset(6, 185),
    const Offset(26, 185),
    const Offset(44, 185),
    const Offset(64, 185),
    const Offset(82, 190),
    const Offset(110, 160),
    const Offset(130, 146),
    const Offset(141, 129),
    const Offset(150, 111),
    const Offset(160, 96),
    const Offset(168, 76),
    const Offset(178, 62),
    const Offset(173, 27),
    const Offset(177, -10),
    const Offset(166, -26),
    const Offset(157, -46),
    const Offset(146, -60),
    const Offset(137, -77),
    const Offset(128, -90),
    const Offset(95, -94),
    const Offset(85, -110),
    const Offset(55, -110),
    const Offset(35, -110),
    const Offset(15, -110),
    const Offset(-5, -110),
    const Offset(-23, -113),
    const Offset(-45, -93),
    const Offset(-77, -85),
    const Offset(-80, -65),
    const Offset(-92, -45),
    const Offset(-100, -30),
    const Offset(-112, -11),
    const Offset(-121, 3),
    const Offset(-117, 40),
    const Offset(-120, 75),
    const Offset(-106, 95),
    const Offset(-95, 112),
    const Offset(-86, 129),
    const Offset(-77, 147),
    const Offset(-70, 162),
    const Offset(-39, 128),
    const Offset(-30, 108),
    const Offset(-22, 90),
    const Offset(-15, 73),
    const Offset(-4, 55),
    const Offset(74, 142),
    const Offset(65, 123),
    const Offset(55, 103),
    const Offset(45, 87),
    const Offset(37, 67),
    const Offset(160, 50),
    const Offset(140, 50),
    const Offset(120, 50),
    const Offset(100, 50),
    const Offset(80, 50),
    const Offset(79, -89),
    const Offset(69, -69),
    const Offset(59, -52),
    const Offset(50, -33),
    const Offset(38, -15),
    const Offset(-46, -75),
    const Offset(-35, -55),
    const Offset(-27, -38),
    const Offset(-19, -20),
    const Offset(-9, -2),
    const Offset(-94, 20),
    const Offset(-70, 20),
    const Offset(-53, 20),
    const Offset(-33, 20),
    const Offset(-13, 20),
    const Offset(25, 20)
  ];

  List<Offset> coordenadasFichaJ2 = [
    const Offset(-49, 168),
    const Offset(-26, 195),
    const Offset(-6, 195),
    const Offset(14, 195),
    const Offset(34, 195),
    const Offset(54, 195),
    const Offset(74, 195),
    const Offset(100, 185),
    const Offset(134, 160),
    const Offset(144, 146),
    const Offset(153, 125),
    const Offset(163, 110),
    const Offset(173, 90),
    const Offset(183, 77),
    const Offset(185, 47),
    const Offset(189, -5),
    const Offset(179, -21),
    const Offset(169, -39),
    const Offset(159, -55),
    const Offset(150, -71),
    const Offset(142, -90),
    const Offset(117, -100),
    const Offset(85, -120),
    const Offset(65, -120),
    const Offset(45, -120),
    const Offset(25, -120),
    const Offset(5, -120),
    const Offset(-15, -120),
    const Offset(-45, -110),
    const Offset(-80, -95),
    const Offset(-88, -83),
    const Offset(-97, -63),
    const Offset(-107, -47),
    const Offset(-117, -28),
    const Offset(-126, -12),
    const Offset(-130, 20),
    const Offset(-133, 75),
    const Offset(-123, 92),
    const Offset(-113, 111),
    const Offset(-103, 129),
    const Offset(-92, 145),
    const Offset(-83, 160),
    const Offset(-33, 144),
    const Offset(-23, 124),
    const Offset(-15, 106),
    const Offset(-7, 89),
    const Offset(3, 71),
    const Offset(88, 148),
    const Offset(78, 128),
    const Offset(68, 109),
    const Offset(58, 93),
    const Offset(50, 73),
    const Offset(150, 40),
    const Offset(130, 40),
    const Offset(110, 40),
    const Offset(90, 40),
    const Offset(70, 40),
    const Offset(82, -73),
    const Offset(72, -53),
    const Offset(62, -35),
    const Offset(54, -19),
    const Offset(44, 1),
    const Offset(-30, -70),
    const Offset(-20, -52),
    const Offset(-8, -33),
    const Offset(-4, -13),
    const Offset(6, 3),
    const Offset(-104, 30),
    const Offset(-80, 30),
    const Offset(-63, 30),
    const Offset(-43, 30),
    const Offset(-23, 30),
    const Offset(40, 20)
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

  List<Offset> coordenadasFichaJ4 = [
    const Offset(-39, 178),
    const Offset(-16, 205),
    const Offset(6, 205),
    const Offset(26, 205),
    const Offset(44, 205),
    const Offset(64, 205),
    const Offset(82, 210),
    const Offset(120, 185),
    const Offset(150, 162),
    const Offset(163, 142),
    const Offset(175, 125),
    const Offset(186, 109),
    const Offset(193, 92),
    const Offset(204, 78),
    const Offset(205, 27),
    const Offset(197, -24),
    const Offset(187, -40),
    const Offset(177, -58),
    const Offset(170, -73),
    const Offset(163, -89),
    const Offset(148, -106),
    const Offset(105, -124),
    const Offset(85, -130),
    const Offset(55, -130),
    const Offset(35, -130),
    const Offset(15, -130),
    const Offset(-5, -130),
    const Offset(-23, -130),
    const Offset(-45, -123),
    const Offset(-95, -95),
    const Offset(-99, -83),
    const Offset(-112, -64),
    const Offset(-120, -47),
    const Offset(-132, -30),
    const Offset(-141, -14),
    const Offset(-147, 40),
    const Offset(-145, 78),
    const Offset(-128, 106),
    const Offset(-116, 122),
    const Offset(-107, 140),
    const Offset(-97, 158),
    const Offset(-92, 174),
    const Offset(-10, 139),
    const Offset(0, 123),
    const Offset(5, 104),
    const Offset(15, 83),
    const Offset(20, 65),
    const Offset(94, 132),
    const Offset(85, 113),
    const Offset(78, 93),
    const Offset(70, 74),
    const Offset(59, 55),
    const Offset(160, 30),
    const Offset(140, 30),
    const Offset(120, 30),
    const Offset(100, 30),
    const Offset(80, 30),
    const Offset(102, -75),
    const Offset(92, -58),
    const Offset(83, -40),
    const Offset(74, -17),
    const Offset(62, -3),
    const Offset(-26, -85),
    const Offset(-15, -65),
    const Offset(0, -50),
    const Offset(2, -30),
    const Offset(12, -13),
    const Offset(-94, 40),
    const Offset(-70, 40),
    const Offset(-53, 40),
    const Offset(-33, 40),
    const Offset(-13, 40),
    const Offset(25, 40)
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

  void alternarCasillas() {
    casillaCambia = List.generate(73, (index) => false);
    for (var e in _nuevasCasillas) {
      casillaCambia[int.parse(e)] = true;
    }
  }

  void cambiarColor(String tematica) {
    Color r = Blanco;
    switch (tematica) {
      case GEOGRAFIA:
        r = Azul;
        break;

      case HISTORIA:
        r = Amarillo;
        break;

      case CIENCIA:
        r = Verde;
        break;

      case DEPORTES:
        r = Naranja;
        break;

      case ENTRETENIMIENTO:
        r = Rosa;
        break;

      case ARTE:
        r = Rojo;
        break;
    }

    colorCasillas = List.generate(73, (index) => r);
    List<int> l = <int>[
      0,
      2,
      5,
      7,
      9,
      12,
      14,
      16,
      19,
      21,
      23,
      26,
      28,
      30,
      33,
      35,
      37,
      40,
      44,
      49,
      54,
      59,
      64,
      69,
      72
    ];
    for (var i in l) {
      colorCasillas[i] = Blanco;
    }
  }

  void pulsarCasilla(int index) {
    if (_turno == _yo && casillaCambia[index]) {
      _casillaElegida = index.toString();
      _ejecutarAccion(ACCION_MOVERFICHA);
    }
  }

  late Timer _t;
  Color _getNextColor(int casilla) {
    //Si el color actual es gris se pone de su color y sino se pone gris
    if (colorVariado[casilla] == Colors.grey) {
      return colorCasillas[casilla];
    } else {
      return Colors.grey;
    }
  }

  _JuegoState(this._s, this._wS, this._tP);
  final String _wS, _tP;
  final Sesion _s;
  late IOWebSocketChannel _socket;

  static const String Mensaje_Dado = 'Mensaje_Dado',
      Mensaje_MovimientoCasilla = 'Mensaje_MovimientoCasilla',
      Mensaje_ContestarPregunta = 'Mensaje_ContestarPregunta',
      Mensaje_FinPregunta = 'Mensaje_FinPregunta',
      Mensaje_Chat = 'Mensaje_Chat',
      Mensaje_PausarPartida = 'Mensaje_PausarPartida',
      Mensaje_ContinuarPartida = 'Mensaje_ContinuarPartida';

  static const String DATOS_KEY = 'datos',
      OK_KEY = 'OK',
      JUGADORES_KEY = 'jugadores',
      JUGADOR_KEY = 'jugador',
      FICHA_KEY = 'ficha',
      TABLERO_KEY = 'tablero',
      POSICION_KEY = 'posicion',
      TURNO_KEY = "turno",
      TIEMPOP_KEY = 'tiempo_pregunta',
      TIEMPOC_KEY = 'tiempo_elegir_casilla',
      TYPE_KEY = 'type',
      SUBTYPE_KEY = 'subtype',
      DADO_KEY = 'valor_dado',
      CASILLAE_KEY = 'casilla_elegida',
      CASILLASN_KEY = 'casillas_nuevas',
      ENUNCIADO_KEY = 'enunciado',
      R1_KEY = 'r1',
      R2_KEY = 'r2',
      R3_KEY = 'r3',
      R4_KEY = 'r4',
      RC_KEY = 'rc',
      CORRECTA_KEY = 'esCorrecta',
      QUESITO_KEY = 'quesito',
      TEMATICA_KEY = 'tematica',
      ERROR_KEY = 'error',
      CHATMENSAJE_KEY = 'mensage_chat';

  static const String TYPE_PETICION = 'Peticion',
      TYPE_RESPUESTA = 'Respuesta',
      TYPE_ACCION = 'Accion',
      TYPE_FIN = 'Fin',
      TYPE_ACTUALIZACION = 'Actualizacion',
      TYPE_CHAT = 'Chat';

  static const String SUBTYPE_PAUSARPARTIDA = 'Pausar_partida',
      SUBTYPE_FINPREGUNTA = 'Fin_pregunta',
      SUBTYPE_CONTINUARPARTIDA = 'Continuar_partida',
      SUBTYPE_CONTESTARPREGUNTA = 'Contestar_pregunta',
      SUBTYPE_TIRARDADO = 'Tirar_dado',
      SUBTYPE_DADOCASILLAS = 'Dado_casillas',
      SUBTYPE_MOVIMIENTOCASILLA = 'Movimiento_casilla',
      SUBTYPE_PREGUNTA = 'Pregunta',
      SUBTYPE_DADOS = 'Dados';
  static const String
      /* Acciones turno */
      //--------------------------------
      ACCION_CAMBIOTURNO = 'Cambio_de_turno',
      //--------------------------------
      /* Acciones dado */
      //--------------------------------
      ACCION_PULSARDADO = 'Pulsar_dado',
      ACCION_TIRARDADO = 'Tirar_dado',
      //--------------------------------
      /* Acciones casillas */
      //--------------------------------
      ACCION_MOVERFICHA = 'Mover_casilla',
      ACCION_MOSTRARCASILLAS = 'Mostrar_casillas',
      //--------------------------------
      /* Acciones pregunta */
      //--------------------------------
      ACCION_MOSTRARPREGUNTA = 'Mostrar_pregunta',
      ACCION_MOSTRARRESPUESTA = 'Mostrar_respuesta',
      ACCION_CONTESTARPREGUNTA = 'Contestar_pregunta',
      ACCION_NOCONTESTAR = 'No_contestar',
      ACCION_OCULTARPREGUNTA = 'Ocultar_pregunta',
      //--------------------------------
      /* Acciones chat */
      //--------------------------------
      ACCION_ABRIRCHAT = 'Abrir_chat',
      ACCION_CERRARCHAT = 'Cerrar_chat',
      ACCION_RECARGARCHAT = 'Recargar_chat',
      ACCION_ENVIARCHAT = 'Enviar_chat',
      //--------------------------------
      /* Acciones partida */
      //--------------------------------
      ACCION_ABANDONARPARTIDA = 'Abandonar_partida',
      ACCION_PAUSARPARTIDA = 'Pausar_partida',
      ACCION_CONTINUARPARTIDA = 'Continuar_partida',
      ACCION_FINPARTIDA = 'Fin_partida',
      //--------------------------------
      ACCION_SALIR = 'Salir';

  static const String TRUE = 'true', FALSE = 'false';
  String _tematica = "";
  String _yo = "";
  int _jugadores = 0;
  List<String> _nombresJugadores = <String>[];
  List<String> _posiciones = <String>[];
  List<List<bool>> _quesitos = <List<bool>>[];

  static const String GEOGRAFIA = 'Geografia',
      ARTE = 'Arte',
      HISTORIA = 'Historia',
      ENTRETENIMIENTO = 'Entretenimiento',
      CIENCIA = 'Ciencia',
      DEPORTES = 'Deportes';

  static const List<String> _tematicasQuesitos = [
    GEOGRAFIA,
    ARTE,
    HISTORIA,
    ENTRETENIMIENTO,
    CIENCIA,
    DEPORTES
  ];

  bool _mostrarChat = false;

  List<String> _fichas = <String>[];
  String _tiempoPregunta = "";
  String _tiempoElegirCasilla = "";

  String _fondoTablero = "";
  String _turno = "";
  String _error = "";
  bool _esperandoDado = false;

  List<Mensaje> _chat = <Mensaje>[];
  String _enviarChat = "";

  List<String> _nuevasCasillas = [];
  int _valorDado = 1;
  String _casillaElegida = "";

  static const String NOCONTESTADA = "noContestada";
  bool _preguntaActiva = false;
  String _preguntaTema = "";
  bool _preguntaQuesito = false;
  String _pregunta = "";
  String _respuesta1 = "";
  String _respuesta2 = "";
  String _respuesta3 = "";
  String _respuesta4 = "";
  String _respuestaContestada = "";
  String _respuestaCorrecta = "";
  String _respuestaNoContestada = "";
  bool _esCorrecta = false, _contestada = false;
  int _contadorPregunta = 0, _contadorPausa = 0, _contadorDado = 0;

  late Color _colorR1 = Acierto,
      _colorR2 = Fallo,
      _colorR3 = Blanco,
      _colorR4 = Blanco;
  Timer? _timerPregunta = null,
      _timerRespuesta = null,
      _timerPausar = null,
      _timerDado = null;

  bool _partidaPausada = false,
      _timerDadoDesactivado = false,
      _mostrandoCasillas = false;

  bool _mensajeInicial = true;
  bool _socketActivo = false;
  bool _finPartida = false;

  final FocusNode f = FocusNode();
  final TextEditingController c = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // imagenes

  static const String imagenJugador = 'assets/perfil.png',
      imagenJugadorTurno = "assets/perfil_turno.png",
      quesitosGeneral = "assets/QuesitosGeneral.png",
      quesitoHistoria = "assets/QuesitoHistoria.png",
      quesitoArte = "assets/QuesitoArte.png",
      quesitoDeportes = "assets/QuesitoDeporte.png",
      quesitoCiencia = "assets/QuesitoCiencia.png",
      quesitoEntretenimiento = "assets/QuesitoEntretenimiento.png",
      quesitoGeografia = "assets/QuesitoGeografia.png";

  void _ejecutarAccion(String accion) {
    switch (accion) {
      /* Acciones turno */
      //--------------------------------
      case ACCION_CAMBIOTURNO:
        _contadorDado = 10;
        if (_turno == _yo) {
          _esperandoDado = true;
        }
        _timerDado = Timer.periodic(const Duration(seconds: 1), (timer) {
          if (_finPartida) {
            _timerDado!.cancel();
          } else {
            if (_contadorDado > 0) {
              _contadorDado--;
              setState(() {});
            } else {
              if (_esperandoDado) {
                _ejecutarAccion(ACCION_PULSARDADO);
              }
              _timerDado!.cancel();
            }
          }
        });
        setState(() {});
        break;

      //--------------------------------

      /* Acciones dado */
      //--------------------------------
      case ACCION_PULSARDADO:
        _esperandoDado = false;
        if (_timerDado != null && _timerDado!.isActive) {
          _timerDado!.cancel();
        }
        _enviarMensaje(Mensaje_Dado);
        break;
      case ACCION_TIRARDADO:
        setState(() {});
        break;
      //--------------------------------

      /* Acciones casilla */
      //--------------------------------
      case ACCION_MOSTRARCASILLAS:
        alternarCasillas();
        _mostrandoCasillas = true;
        setState(() {});
        break;

      case ACCION_MOVERFICHA:
        _mostrandoCasillas = false;
        _nuevasCasillas = <String>[];
        alternarCasillas();
        _posiciones[_nombresJugadores.indexOf(_turno)] = _casillaElegida;
        setState(() {});
        if (_turno == _yo) {
          _enviarMensaje(Mensaje_MovimientoCasilla);
        }
        break;

      //--------------------------------

      /* Acciones chat */
      //--------------------------------
      case ACCION_ABRIRCHAT:
        _mostrarChat = true;

        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        });
        setState(() {});
        break;
      case ACCION_CERRARCHAT:
        _mostrarChat = false;
        c.clear();
        setState(() {});
        break;
      case ACCION_ENVIARCHAT:
        _chat.add(Mensaje(_enviarChat, true, _yo));
        _ejecutarAccion(ACCION_RECARGARCHAT);
        _enviarMensaje(Mensaje_Chat);

        break;
      case ACCION_RECARGARCHAT:
        if (_mostrarChat) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _scrollController
                .jumpTo(_scrollController.position.maxScrollExtent);
          });
        }
        setState(() {});

        break;
      //--------------------------------

      /* Acciones pregunta */
      //--------------------------------
      case ACCION_MOSTRARPREGUNTA:
        String s;
        if (_tP == "Tematico") {
          s = _tematica;
        } else {
          s = _preguntaTema;
        }
        switch (s) {
          case GEOGRAFIA:
            colorPregunta = Azul;
            break;
          case HISTORIA:
            colorPregunta = Amarillo;
            break;
          case CIENCIA:
            colorPregunta = Verde;
            break;
          case ENTRETENIMIENTO:
            colorPregunta = Rosa;
            break;
          case ARTE:
            colorPregunta = Rojo;
            break;
          case DEPORTES:
            colorPregunta = Naranja;
            break;
        }

        _colorR1 = Blanco;
        _colorR2 = Blanco;
        _colorR3 = Blanco;
        _colorR4 = Blanco;
        _preguntaActiva = true;
        _contestada = false;
        _contadorPregunta = int.parse(_tiempoPregunta);
        _respuestaNoContestada = "";
        setState(() {});
        _timerPregunta = Timer.periodic(const Duration(seconds: 1), (timer) {
          if (_finPartida) {
            _timerPregunta!.cancel();
          } else {
            if (_contadorPregunta > 0) {
              _contadorPregunta--;
              setState(() {});
            } else {
              _timerPregunta!.cancel();
              if (_turno == _yo && !_contestada) {
                _ejecutarAccion(ACCION_NOCONTESTAR);
              }
            }
          }
        });

        break;
      case ACCION_MOSTRARRESPUESTA:
        if (_timerPregunta != null && _timerPregunta!.isActive) {
          _timerPregunta!.cancel();
        }
        if (_respuestaNoContestada == NOCONTESTADA) {
          switch (_respuestaCorrecta) {
            case '1':
              _colorR1 = Acierto;
              _colorR2 = Fallo;
              _colorR3 = Fallo;
              _colorR4 = Fallo;
              break;

            case '2':
              _colorR1 = Fallo;
              _colorR2 = Acierto;
              _colorR3 = Fallo;
              _colorR4 = Fallo;
              break;

            case '3':
              _colorR1 = Fallo;
              _colorR2 = Fallo;
              _colorR3 = Acierto;
              _colorR4 = Fallo;
              break;
            case '4':
              _colorR1 = Fallo;
              _colorR2 = Fallo;
              _colorR3 = Fallo;
              _colorR4 = Acierto;
              break;
          }
        } else if (_esCorrecta) {
          switch (_respuestaCorrecta) {
            case '1':
              _colorR1 = Acierto;
              break;

            case '2':
              _colorR2 = Acierto;
              break;

            case '3':
              _colorR3 = Acierto;
              break;
            case '4':
              _colorR4 = Acierto;
              break;
          }

          int index1 = _tematicasQuesitos.indexOf(_preguntaTema);
          int index2 = _nombresJugadores.indexOf(_turno);
          if (!_quesitos[index2][index1] && _preguntaQuesito) {
            _quesitos[index2][index1] = true;
          }
        } else {
          switch (_respuestaCorrecta) {
            case '1':
              _colorR1 = Acierto;
              break;
            case '2':
              _colorR2 = Acierto;
              break;

            case '3':
              _colorR3 = Acierto;
              break;
            case '4':
              _colorR4 = Acierto;
              break;
          }

          switch (_respuestaContestada) {
            case '1':
              _colorR1 = Fallo;
              break;

            case '2':
              _colorR2 = Fallo;
              break;

            case '3':
              _colorR3 = Fallo;
              break;
            case '4':
              _colorR4 = Fallo;
              break;
          }
        }

        _contadorPregunta = 3;

        _timerRespuesta = Timer.periodic(const Duration(seconds: 1), (timer) {
          if (_finPartida) {
            _timerRespuesta!.cancel();
          } else {
            if (_contadorPregunta > 0) {
              _contadorPregunta--;
              setState(() {});
            } else {
              _timerRespuesta!.cancel();
              if (_yo == _turno) {
                _enviarMensaje((Mensaje_FinPregunta));
              }
              _ejecutarAccion(ACCION_OCULTARPREGUNTA);
            }
          }
        });

        setState(() {});

        break;

      case ACCION_CONTESTARPREGUNTA:
        _contestada = true;
        _timerPregunta!.cancel();
        _esCorrecta = _respuestaContestada == _respuestaCorrecta;
        _ejecutarAccion(ACCION_MOSTRARRESPUESTA);
        _enviarMensaje(Mensaje_ContestarPregunta);
        break;
      case ACCION_NOCONTESTAR:
        _contestada = true;
        _esCorrecta = false;
        _respuestaNoContestada = NOCONTESTADA;
        _ejecutarAccion(ACCION_MOSTRARRESPUESTA);
        _enviarMensaje(Mensaje_ContestarPregunta);

        break;

      case ACCION_OCULTARPREGUNTA:
        _preguntaActiva = false;
        setState(() {});
        break;

      //--------------------------------

      /* Acciones pausar,reanudar,fin y abandonar_partida */
      //--------------------------------
      case ACCION_PAUSARPARTIDA:
        _partidaPausada = true;
        if (_timerDado != null && _timerDado!.isActive) {
          _timerDado!.cancel();
          _timerDadoDesactivado = true;
        }

        _contadorPausa = 30;
        _timerPausar = Timer.periodic(const Duration(seconds: 1), (timer) {
          if (_finPartida) {
            _timerPausar!.cancel();
          } else {
            if (_contadorPausa > 0) {
              _contadorPausa--;
              setState(() {});
            } else {
              _timerPausar!.cancel();
              if (_turno == _yo) {
                _ejecutarAccion(ACCION_CONTINUARPARTIDA);
              }
            }
          }
        });
        if (_turno == _yo) {
          _enviarMensaje(Mensaje_PausarPartida);
        }

        setState(() {});
        break;

      case ACCION_CONTINUARPARTIDA:
        _partidaPausada = false;
        if (_turno == _yo) {
          _enviarMensaje(Mensaje_ContinuarPartida);
        }
        if (_timerPausar != null && _timerPausar!.isActive) {
          _timerPausar!.cancel();
        }
        if (_timerDadoDesactivado) {
          _timerDadoDesactivado = false;
          _timerDado = Timer.periodic(const Duration(seconds: 1), (timer) {
            if (_finPartida) {
              _timerDado!.cancel();
            } else {
              if (_contadorDado > 0) {
                _contadorDado--;
                setState(() {});
              } else {
                _timerDado!.cancel();
                _ejecutarAccion(ACCION_PULSARDADO);
              }
            }
          });
        }
        setState(() {});
        break;

      case ACCION_FINPARTIDA:
        _finPartida = true;
        if (_timerPausar != null) {
          _timerPausar!.cancel();
        }
        if (_timerPregunta != null) {
          _timerPregunta!.cancel();
        }
        if (_timerRespuesta != null) {
          _timerRespuesta!.cancel();
        }
        if (_timerDado != null) {
          _timerDado!.cancel();
        }
        _preguntaActiva = false;
        _mostrarChat = false;
        setState(() {});
        break;

      case ACCION_ABANDONARPARTIDA:
        _finPartida = true;
        if (_timerPausar != null) {
          _timerPausar!.cancel();
        }
        if (_timerPregunta != null) {
          _timerPregunta!.cancel();
        }
        if (_timerRespuesta != null) {
          _timerRespuesta!.cancel();
        }
        if (_timerDado != null) {
          _timerDado!.cancel();
        }
        _ejecutarAccion(ACCION_SALIR);
        break;

      case ACCION_SALIR:
        _socket.sink.close();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Menu(_s)),
            (Route<dynamic> route) => false);
        break;

      //--------------------------------
    }
  }

  void _enviarMensaje(String m) {
    String mensaje = "";
    switch (m) {
      case Mensaje_Dado:
        mensaje = jsonEncode({
          OK_KEY: TRUE,
          JUGADOR_KEY: _yo,
          TYPE_KEY: TYPE_PETICION,
          SUBTYPE_KEY: SUBTYPE_TIRARDADO
        });
        break;
      case Mensaje_MovimientoCasilla:
        mensaje = jsonEncode({
          OK_KEY: TRUE,
          JUGADOR_KEY: _yo,
          TYPE_KEY: TYPE_PETICION,
          SUBTYPE_KEY: SUBTYPE_MOVIMIENTOCASILLA,
          CASILLAE_KEY: _casillaElegida
        });
        break;

      case Mensaje_ContestarPregunta:
        mensaje = jsonEncode({
          OK_KEY: TRUE,
          JUGADOR_KEY: _yo,
          TYPE_KEY: TYPE_ACTUALIZACION,
          SUBTYPE_KEY: SUBTYPE_CONTESTARPREGUNTA,
          R1_KEY: _respuestaContestada,
          RC_KEY: _respuestaCorrecta,
          ENUNCIADO_KEY: _respuestaNoContestada,
          QUESITO_KEY: _preguntaQuesito ? TRUE : FALSE,
          CORRECTA_KEY: _esCorrecta ? TRUE : FALSE,
          TEMATICA_KEY: _preguntaTema
        });

        break;

      case Mensaje_FinPregunta:
        mensaje = jsonEncode({
          OK_KEY: TRUE,
          JUGADOR_KEY: _yo,
          TYPE_KEY: TYPE_ACTUALIZACION,
          SUBTYPE_KEY: SUBTYPE_FINPREGUNTA,
          QUESITO_KEY: _preguntaQuesito ? TRUE : FALSE,
          CORRECTA_KEY: _esCorrecta ? TRUE : FALSE,
          TEMATICA_KEY: _preguntaTema
        });
        break;

      case Mensaje_Chat:
        mensaje = jsonEncode({
          OK_KEY: TRUE,
          JUGADOR_KEY: _yo,
          TYPE_KEY: TYPE_CHAT,
          CHATMENSAJE_KEY: _enviarChat,
        });
        break;

      case Mensaje_PausarPartida:
        mensaje = jsonEncode({
          OK_KEY: TRUE,
          JUGADOR_KEY: _yo,
          TYPE_KEY: TYPE_ACTUALIZACION,
          SUBTYPE_KEY: SUBTYPE_PAUSARPARTIDA,
        });
        break;

      case Mensaje_ContinuarPartida:
        mensaje = jsonEncode({
          OK_KEY: TRUE,
          JUGADOR_KEY: _yo,
          TYPE_KEY: TYPE_ACTUALIZACION,
          SUBTYPE_KEY: SUBTYPE_CONTINUARPARTIDA,
        });
        break;
    }
    _socket.sink.add(mensaje);
  }

  void _leerMensaje(String mensaje) {
    Map<String, dynamic> mensajeDecodificado = json.decode(mensaje);
    if (_mensajeInicial) {
      _mensajeInicial = false;
      _tiempoPregunta = mensajeDecodificado[TIEMPOP_KEY];
      _tiempoElegirCasilla = mensajeDecodificado[TIEMPOC_KEY];
      _error = mensajeDecodificado[ERROR_KEY];
      _jugadores = 0;
      for (var datosJugador in mensajeDecodificado[JUGADORES_KEY]) {
        _jugadores++;
        if (datosJugador[JUGADOR_KEY] == _yo) {
          _fondoTablero = datosJugador[TABLERO_KEY];
        }
        if (datosJugador[TURNO_KEY] == "1") {
          _turno = datosJugador[JUGADOR_KEY];
        }
        _nombresJugadores.add(datosJugador[JUGADOR_KEY]);
        _posiciones.add(datosJugador[POSICION_KEY]);
        _quesitos.add(List.generate(6, (_) => false));
        _fichas.add(datosJugador[FICHA_KEY]);
        if (_tP == 'Tematico') {
          _tematica = mensajeDecodificado[TEMATICA_KEY];
          cambiarColor(_tematica);
        }
      }

      setState(() {});
      _ejecutarAccion(ACCION_CAMBIOTURNO);
    } else {
      String type = mensajeDecodificado[TYPE_KEY];
      String subtype = "";
      if (type != TYPE_CHAT) {
        subtype = mensajeDecodificado[SUBTYPE_KEY];
      }
      switch (type) {
        case TYPE_PETICION:
          switch (subtype) {
            case SUBTYPE_MOVIMIENTOCASILLA:
              _casillaElegida = mensajeDecodificado[CASILLAE_KEY].toString();
              _ejecutarAccion(ACCION_MOVERFICHA);
              break;
            case SUBTYPE_TIRARDADO:
              if (_timerDado != null && _timerDado!.isActive) {
                _timerDado!.cancel();
              }

              break;
          }
          break;
        case TYPE_RESPUESTA:
          switch (subtype) {
            case SUBTYPE_DADOCASILLAS:
              _valorDado = int.parse(mensajeDecodificado[DADO_KEY]);
              String l = mensajeDecodificado[CASILLASN_KEY];
              _nuevasCasillas = l.split(",");
              _ejecutarAccion(ACCION_MOSTRARCASILLAS);
              break;

            case SUBTYPE_PREGUNTA:
              if (_turno != _yo) {
                _casillaElegida = mensajeDecodificado[CASILLAE_KEY];
              }
              _pregunta = mensajeDecodificado[ENUNCIADO_KEY];
              _respuesta1 = mensajeDecodificado[R1_KEY];
              _respuesta2 = mensajeDecodificado[R2_KEY];
              _respuesta3 = mensajeDecodificado[R3_KEY];
              _respuesta4 = mensajeDecodificado[R4_KEY];
              _respuestaCorrecta = mensajeDecodificado[RC_KEY].toString();
              _preguntaTema = mensajeDecodificado[TEMATICA_KEY];
              _preguntaQuesito = mensajeDecodificado[QUESITO_KEY] == TRUE;
              _ejecutarAccion(ACCION_MOSTRARPREGUNTA);
              break;
          }
          break;

        case TYPE_ACCION:
          switch (subtype) {
            case SUBTYPE_DADOS:
              _turno = mensajeDecodificado[JUGADOR_KEY];
              _ejecutarAccion(ACCION_CAMBIOTURNO);
              break;
          }
          break;

        case TYPE_CHAT:
          _chat.add(Mensaje(mensajeDecodificado[CHATMENSAJE_KEY], false,
              mensajeDecodificado[JUGADOR_KEY]));
          _ejecutarAccion(ACCION_RECARGARCHAT);
          break;

        case TYPE_FIN:
          _ejecutarAccion(ACCION_FINPARTIDA);

          break;

        case TYPE_ACTUALIZACION:
          switch (subtype) {
            case SUBTYPE_PAUSARPARTIDA:
              _ejecutarAccion(ACCION_PAUSARPARTIDA);
              break;

            case SUBTYPE_CONTINUARPARTIDA:
              _ejecutarAccion(ACCION_CONTINUARPARTIDA);
              break;

            case SUBTYPE_CONTESTARPREGUNTA:
              if (_turno != _yo) {
                _respuestaContestada = mensajeDecodificado[R1_KEY].toString();
                _respuestaNoContestada =
                    mensajeDecodificado[ENUNCIADO_KEY].toString();
                _esCorrecta = mensajeDecodificado[CORRECTA_KEY] == TRUE;
                _ejecutarAccion(ACCION_MOSTRARRESPUESTA);
              }
              break;

            case SUBTYPE_FINPREGUNTA:
              if (_timerRespuesta != null && _timerRespuesta!.isActive) {
                _timerRespuesta!.cancel();
                _ejecutarAccion(ACCION_OCULTARPREGUNTA);
              }
              break;
          }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    try {
      _socket = IOWebSocketChannel.connect(_wS);
      _socketActivo = true;
    } catch (error) {
      Timer t = Timer(Duration(seconds: 1), () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Menu(_s)),
            (Route<dynamic> route) => false);
      });
      return;
    }
    if (_socketActivo) {
      _socket.stream.listen((mensaje) {
        _leerMensaje(mensaje);
      });
      _t = Timer.periodic(Duration(milliseconds: 500), (t) {
        setState(() {
          //Habilitar el "parpadeo de seleccion" en todas las casillas
          for (int p = 0; p < 73; p++) {
            colorVariado[p] = _getNextColor(p);
          }
        });
      });
      _yo = _s.getField(SesionFieldsCodes.usuario);
    }
  }

  @override
  void dispose() {
    _t.cancel();
    if (_socketActivo) {
      _socket.sink.close();
    }

    if (_timerPausar != null) {
      _timerPausar!.cancel();
    }
    if (_timerPregunta != null) {
      _timerPregunta!.cancel();
    }
    if (_timerRespuesta != null) {
      _timerRespuesta!.cancel();
    }
    if (_timerDado != null) {
      _timerDado!.cancel();
    }

    f.dispose();
    c.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    final Size screenSize = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: screenSize.width,
          height: screenSize.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/tapete.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: _mensajeInicial
              ? const SizedBox.shrink()
              : SizedBox(
                  width: screenSize.width,
                  height: screenSize.height,
                  child: Stack(
                    children: [
                      Positioned(
                        top: screenSize.height / 2 -
                            50, // ajustar la posición vertical del hexágono
                        left: screenSize.width / 2 -
                            50, // ajustar la posición horizontal del hexágono
                        child: Stack(
                          children: [
                            Transform.translate(
                              offset: const Offset(-145, -129),
                              child: Container(
                                width: 360,
                                height: 360,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                          NetworkImage('$urlDir$_fondoTablero'),
                                      fit: BoxFit.fill),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                // ),
                              ),
                            ),
                            Stack(
                              children: [
                                //C72
                                Transform.translate(
                                  offset: const Offset(0, 0),
                                  child: HexagonButton(
                                    color: casillaCambia[72] == true
                                        ? colorVariado[72]
                                        : colorCasillas[72],
                                    onPressed: () {
                                      //_cambiardecolor2();
                                      // setState(() {
                                      //   _countdownTime = 10;
                                      // });
                                      // startTimer();
                                      // pulsarCasilla(72);
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
                                      color: casillaCambia[51] == true
                                          ? colorVariado[51]
                                          : colorCasillas[51],
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
                                      color: casillaCambia[50] == true
                                          ? colorVariado[50]
                                          : colorCasillas[50],
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
                                      color: casillaCambia[49] == true
                                          ? colorVariado[49]
                                          : colorCasillas[49],
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
                                      color: casillaCambia[48] == true
                                          ? colorVariado[48]
                                          : colorCasillas[48],
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
                                      color: casillaCambia[47] == true
                                          ? colorVariado[47]
                                          : colorCasillas[47],
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
                                      color: casillaCambia[46] == true
                                          ? colorVariado[46]
                                          : colorCasillas[46],
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
                                      color: casillaCambia[45] == true
                                          ? colorVariado[45]
                                          : colorCasillas[45],
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
                                      color: casillaCambia[44] == true
                                          ? colorVariado[44]
                                          : colorCasillas[44],
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
                                      color: casillaCambia[43] == true
                                          ? colorVariado[43]
                                          : colorCasillas[43],
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
                                      color: casillaCambia[42] == true
                                          ? colorVariado[42]
                                          : colorCasillas[42],
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
                                      color: casillaCambia[6] == true
                                          ? colorVariado[6]
                                          : colorCasillas[6],
                                      onPressed: () {
                                        //_cambiarColor2();
                                        // pulsarCasilla(6);
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
                                      color: casillaCambia[5] == true
                                          ? colorVariado[5]
                                          : colorCasillas[5],
                                      onPressed: () {
                                        //_cambiarColor2();
                                        // pulsarCasilla(5);
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
                                      color: casillaCambia[4] == true
                                          ? colorVariado[4]
                                          : colorCasillas[4],
                                      onPressed: () {
                                        //_cambiarColor2();
                                        // pulsarCasilla(4);
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
                                      color: casillaCambia[3] == true
                                          ? colorVariado[3]
                                          : colorCasillas[3],
                                      onPressed: () {
                                        //_cambiarColor2();
                                        // pulsarCasilla(3);
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
                                      color: casillaCambia[2] == true
                                          ? colorVariado[2]
                                          : colorCasillas[2],
                                      onPressed: () {
                                        //_cambiarColor2();
                                        // pulsarCasilla(2);
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
                                      color: casillaCambia[1] == true
                                          ? colorVariado[1]
                                          : colorCasillas[1],
                                      onPressed: () {
                                        //_cambiarColor2();
                                        // pulsarCasilla(1);
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
                                      color: casillaCambia[8] == true
                                          ? colorVariado[8]
                                          : colorCasillas[8],
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
                                      color: casillaCambia[9] == true
                                          ? colorVariado[9]
                                          : colorCasillas[9],
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
                                      color: casillaCambia[10] == true
                                          ? colorVariado[10]
                                          : colorCasillas[10],
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
                                      color: casillaCambia[11] == true
                                          ? colorVariado[11]
                                          : colorCasillas[11],
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
                                      color: casillaCambia[12] == true
                                          ? colorVariado[12]
                                          : colorCasillas[12],
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
                                      color: casillaCambia[13] == true
                                          ? colorVariado[13]
                                          : colorCasillas[13],
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
                                      color: casillaCambia[7] == true
                                          ? colorVariado[7]
                                          : colorCasillas[7],
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
                                      color: casillaCambia[56] == true
                                          ? colorVariado[56]
                                          : colorCasillas[56],
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
                                      color: casillaCambia[55] == true
                                          ? colorVariado[55]
                                          : colorCasillas[55],
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
                                      color: casillaCambia[54] == true
                                          ? colorVariado[54]
                                          : colorCasillas[54],
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
                                      color: casillaCambia[53] == true
                                          ? colorVariado[53]
                                          : colorCasillas[53],
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
                                      color: casillaCambia[52] == true
                                          ? colorVariado[52]
                                          : colorCasillas[52],
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
                                      color: casillaCambia[71] == true
                                          ? colorVariado[71]
                                          : colorCasillas[71],
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
                                      color: casillaCambia[70] == true
                                          ? colorVariado[70]
                                          : colorCasillas[70],
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
                                      color: casillaCambia[69] == true
                                          ? colorVariado[69]
                                          : colorCasillas[69],
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
                                      color: casillaCambia[68] == true
                                          ? colorVariado[68]
                                          : colorCasillas[68],
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
                                      color: casillaCambia[67] == true
                                          ? colorVariado[67]
                                          : colorCasillas[67],
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
                                      color: casillaCambia[41] == true
                                          ? colorVariado[41]
                                          : colorCasillas[41],
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
                                      color: casillaCambia[40] == true
                                          ? colorVariado[40]
                                          : colorCasillas[40],
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
                                      color: casillaCambia[39] == true
                                          ? colorVariado[39]
                                          : colorCasillas[39],
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
                                      color: casillaCambia[38] == true
                                          ? colorVariado[38]
                                          : colorCasillas[38],
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
                                      color: casillaCambia[37] == true
                                          ? colorVariado[37]
                                          : colorCasillas[37],
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
                                      color: casillaCambia[36] == true
                                          ? colorVariado[36]
                                          : colorCasillas[36],
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
                                      color: casillaCambia[0] == true
                                          ? colorVariado[0]
                                          : colorCasillas[0],
                                      onPressed: () {
                                        //_cambiarColor2();
                                        // pulsarCasilla(faslse,);
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
                                      color: casillaCambia[66] == true
                                          ? colorVariado[66]
                                          : colorCasillas[66],
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
                                      color: casillaCambia[65] == true
                                          ? colorVariado[65]
                                          : colorCasillas[65],
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
                                      color: casillaCambia[64] == true
                                          ? colorVariado[64]
                                          : colorCasillas[64],
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
                                      color: casillaCambia[63] == true
                                          ? colorVariado[63]
                                          : colorCasillas[63],
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
                                      color: casillaCambia[62] == true
                                          ? colorVariado[62]
                                          : colorCasillas[62],
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
                                      color: casillaCambia[29] == true
                                          ? colorVariado[29]
                                          : colorCasillas[29],
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
                                      color: casillaCambia[30] == true
                                          ? colorVariado[30]
                                          : colorCasillas[30],
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
                                      color: casillaCambia[31] == true
                                          ? colorVariado[31]
                                          : colorCasillas[31],
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
                                      color: casillaCambia[32] == true
                                          ? colorVariado[32]
                                          : colorCasillas[32],
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
                                      color: casillaCambia[33] == true
                                          ? colorVariado[33]
                                          : colorCasillas[33],
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
                                      color: casillaCambia[34] == true
                                          ? colorVariado[34]
                                          : colorCasillas[34],
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
                                      color: casillaCambia[61] == true
                                          ? colorVariado[61]
                                          : colorCasillas[61],
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
                                      color: casillaCambia[60] == true
                                          ? colorVariado[60]
                                          : colorCasillas[60],
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
                                      color: casillaCambia[59] == true
                                          ? colorVariado[59]
                                          : colorCasillas[59],
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
                                      color: casillaCambia[58] == true
                                          ? colorVariado[58]
                                          : colorCasillas[58],
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
                                      color: casillaCambia[57] == true
                                          ? colorVariado[57]
                                          : colorCasillas[57],
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
                                      color: casillaCambia[27] == true
                                          ? colorVariado[27]
                                          : colorCasillas[27],
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
                                      color: casillaCambia[26] == true
                                          ? colorVariado[26]
                                          : colorCasillas[26],
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
                                      color: casillaCambia[25] == true
                                          ? colorVariado[25]
                                          : colorCasillas[25],
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
                                      color: casillaCambia[24] == true
                                          ? colorVariado[24]
                                          : colorCasillas[24],
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
                                      color: casillaCambia[23] == true
                                          ? colorVariado[23]
                                          : colorCasillas[23],
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
                                      color: casillaCambia[22] == true
                                          ? colorVariado[22]
                                          : colorCasillas[22],
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
                                      color: casillaCambia[20] == true
                                          ? colorVariado[20]
                                          : colorCasillas[20],
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
                                      color: casillaCambia[19] == true
                                          ? colorVariado[19]
                                          : colorCasillas[19],
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
                                      color: casillaCambia[18] == true
                                          ? colorVariado[18]
                                          : colorCasillas[18],
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
                                      color: casillaCambia[17] == true
                                          ? colorVariado[17]
                                          : colorCasillas[17],
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
                                      color: casillaCambia[16] == true
                                          ? colorVariado[16]
                                          : colorCasillas[16],
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
                                      color: casillaCambia[15] == true
                                          ? colorVariado[15]
                                          : colorCasillas[15],
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
                                      color: casillaCambia[35] == true
                                          ? colorVariado[35]
                                          : colorCasillas[35],
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
                                      color: casillaCambia[28] == true
                                          ? colorVariado[28]
                                          : colorCasillas[28],
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
                                      color: casillaCambia[21] == true
                                          ? colorVariado[21]
                                          : colorCasillas[21],
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
                                      color: casillaCambia[14] == true
                                          ? colorVariado[14]
                                          : colorCasillas[14],
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

                                //FICHAS---------------------------------------------------------------------------------------------
                                Stack(children: [
                                  _jugadores > 0
                                      ? Transform.translate(
                                          //Ficha J0
                                          offset: coordenadasFichaJ0[int.parse(
                                              _posiciones[
                                                  0])], //coordenadasFichaJ1[posicionesFichas[0]],
                                          child: Container(
                                            width: 15,
                                            height: 15,
                                            child: Image.network(
                                              '$urlDir${_fichas[0]}',
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                  _jugadores > 1
                                      ? Transform.translate(
                                          //Ficha J1
                                          offset: coordenadasFichaJ1[int.parse(
                                              _posiciones[
                                                  1])], //coordenadasFichaJ1[posicionesFichas[0]],
                                          child: Container(
                                            width: 15,
                                            height: 15,
                                            child: Image.network(
                                              '$urlDir${_fichas[1]}',
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                  _jugadores > 2
                                      ? Transform.translate(
                                          //Ficha J2
                                          offset: coordenadasFichaJ2[int.parse(
                                              _posiciones[
                                                  2])], //coordenadasFichaJ1[posicionesFichas[0]],
                                          child: Container(
                                            width: 15,
                                            height: 15,
                                            child: Image.network(
                                              '$urlDir${_fichas[2]}',
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                  _jugadores > 3
                                      ? Transform.translate(
                                          //Ficha J3
                                          offset: coordenadasFichaJ3[int.parse(
                                              _posiciones[
                                                  3])], //coordenadasFichaJ1[posicionesFichas[0]],
                                          child: Container(
                                            width: 15,
                                            height: 15,
                                            child: Image.network(
                                              '$urlDir${_fichas[3]}',
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                  _jugadores > 4
                                      ? Transform.translate(
                                          //Ficha J4
                                          offset: coordenadasFichaJ4[int.parse(
                                              _posiciones[
                                                  4])], //coordenadasFichaJ1[posicionesFichas[0]],
                                          child: Container(
                                            width: 15,
                                            height: 15,
                                            child: Image.network(
                                              '$urlDir${_fichas[4]}',
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                  _jugadores > 5
                                      ? Transform.translate(
                                          //Ficha J5
                                          offset: coordenadasFichaJ5[int.parse(
                                              _posiciones[
                                                  5])], //coordenadasFichaJ1[posicionesFichas[0]],
                                          child: Container(
                                            width: 15,
                                            height: 15,
                                            child: Image.network(
                                              '$urlDir${_fichas[5]}',
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                ]),
                              ],
                            ),
                            Stack(
                              children: [
                                // J0
                                _jugadores > 0
                                    ? Stack(
                                        children: [
                                          Transform.translate(
                                            //Texto J0
                                            offset: const Offset(-262, -128),
                                            child: Text(
                                              _nombresJugadores[0],
                                              style: const TextStyle(
                                                  fontFamily: "Baskerville",
                                                  fontSize: 12.0,
                                                  //color: Color(0xFFc9c154),
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255),
                                                  fontWeight: FontWeight.bold,
                                                  decoration:
                                                      TextDecoration.none),
                                            ),
                                          ),
                                          Transform.translate(
                                            //Imagen J0
                                            offset: const Offset(-265, -110),
                                            child: Container(
                                              width: 70,
                                              height: 70,
                                              child: const Image(
                                                image: AssetImage(
                                                  imagenJugador,
                                                ),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          _turno == _nombresJugadores[0]
                                              ? Transform.translate(
                                                  //Imagen turno J0
                                                  offset:
                                                      const Offset(-265, -110),
                                                  child: Container(
                                                    width: 70,
                                                    height: 70,
                                                    child: Image(
                                                      image: AssetImage(
                                                          imagenJugadorTurno),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                          Transform.translate(
                                            //Imagen turno J0
                                            offset: const Offset(-285, -52),
                                            child: Container(
                                              width: 30,
                                              height: 30,
                                              child: Image(
                                                image: NetworkImage(
                                                    '$urlDir${_fichas[0]}'),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          Transform.translate(
                                            //Putos J0
                                            offset: const Offset(-205, -60),
                                            child: Container(
                                              width: 40,
                                              height: 40,
                                              decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      quesitosGeneral),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          ),
                                          _quesitos[0][_tematicasQuesitos
                                                  .indexOf(HISTORIA)]
                                              ? Transform.translate(
                                                  //QuesitoHistoria J0
                                                  offset:
                                                      const Offset(-205, -60),
                                                  child: Container(
                                                    width: 40,
                                                    height: 40,
                                                    child: const Image(
                                                      image: AssetImage(
                                                          quesitoHistoria),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                          _quesitos[0][_tematicasQuesitos
                                                  .indexOf(ARTE)]
                                              ? Transform.translate(
                                                  //QuesitoHistoria J0
                                                  offset:
                                                      const Offset(-205, -60),
                                                  child: Container(
                                                    width: 40,
                                                    height: 40,
                                                    child: const Image(
                                                      image: AssetImage(
                                                          quesitoArte),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                          _quesitos[0][_tematicasQuesitos
                                                  .indexOf(DEPORTES)]
                                              ? Transform.translate(
                                                  //QuesitoHistoria J0
                                                  offset:
                                                      const Offset(-205, -60),
                                                  child: Container(
                                                    width: 40,
                                                    height: 40,
                                                    child: const Image(
                                                      image: AssetImage(
                                                          quesitoDeportes),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                          _quesitos[0][_tematicasQuesitos
                                                  .indexOf(CIENCIA)]
                                              ? Transform.translate(
                                                  //QuesitoHistoria J0
                                                  offset:
                                                      const Offset(-205, -60),
                                                  child: Container(
                                                    width: 40,
                                                    height: 40,
                                                    child: Image(
                                                      image: AssetImage(
                                                          quesitoCiencia),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                          _quesitos[0][_tematicasQuesitos
                                                  .indexOf(ENTRETENIMIENTO)]
                                              ? Transform.translate(
                                                  //QuesitoEntretenimiento J0
                                                  offset:
                                                      const Offset(-205, -60),
                                                  child: Container(
                                                    width: 40,
                                                    height: 40,
                                                    child: Image(
                                                      image: AssetImage(
                                                          quesitoEntretenimiento),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                          _quesitos[0][_tematicasQuesitos
                                                  .indexOf(GEOGRAFIA)]
                                              ? Transform.translate(
                                                  //QuesitoGeografia J0
                                                  offset:
                                                      const Offset(-205, -60),
                                                  child: Container(
                                                    width: 40,
                                                    height: 40,
                                                    child: Image(
                                                      image: AssetImage(
                                                          quesitoGeografia),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                        ],
                                      )
                                    : const SizedBox.shrink(),

                                //J1
                                _jugadores > 1
                                    ? Stack(
                                        children: [
                                          Transform.translate(
                                            //Texto J1
                                            offset: const Offset(-262, -8),
                                            child: Text(
                                              _nombresJugadores[1],
                                              style: const TextStyle(
                                                  fontFamily: "Baskerville",
                                                  fontSize: 12.0,
                                                  //color: Color(0xFFc9c154),
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255),
                                                  fontWeight: FontWeight.bold,
                                                  decoration:
                                                      TextDecoration.none),
                                            ),
                                          ),
                                          Transform.translate(
                                            //Imagen J1
                                            offset: const Offset(-265, 10),
                                            child: Container(
                                              width: 70,
                                              height: 70,
                                              child: const Image(
                                                image: AssetImage(
                                                  imagenJugador,
                                                ),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          _turno == _nombresJugadores[1]
                                              ? Transform.translate(
                                                  //Imagen turno J1
                                                  offset:
                                                      const Offset(-265, 10),
                                                  child: Container(
                                                    width: 70,
                                                    height: 70,
                                                    child: Image(
                                                      image: AssetImage(
                                                          imagenJugadorTurno),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                          Transform.translate(
                                            //Imagen turno J0
                                            offset: const Offset(-285, 68),
                                            child: Container(
                                              width: 30,
                                              height: 30,
                                              child: Image(
                                                image: NetworkImage(
                                                    '$urlDir${_fichas[1]}'),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          Transform.translate(
                                            //Putos J1
                                            offset: const Offset(-205, 60),
                                            child: Container(
                                              width: 40,
                                              height: 40,
                                              decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      quesitosGeneral),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          ),
                                          _quesitos[1][_tematicasQuesitos
                                                  .indexOf(HISTORIA)]
                                              ? Transform.translate(
                                                  //QuesitoHistoria J1
                                                  offset:
                                                      const Offset(-205, 60),
                                                  child: Container(
                                                    width: 40,
                                                    height: 40,
                                                    child: const Image(
                                                      image: AssetImage(
                                                          quesitoHistoria),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                          _quesitos[1][_tematicasQuesitos
                                                  .indexOf(ARTE)]
                                              ? Transform.translate(
                                                  //QuesitoHistoria J1
                                                  offset:
                                                      const Offset(-205, 60),
                                                  child: Container(
                                                    width: 40,
                                                    height: 40,
                                                    child: const Image(
                                                      image: AssetImage(
                                                          quesitoArte),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                          _quesitos[1][_tematicasQuesitos
                                                  .indexOf(DEPORTES)]
                                              ? Transform.translate(
                                                  //QuesitoHistoria J1
                                                  offset:
                                                      const Offset(-205, 60),
                                                  child: Container(
                                                    width: 40,
                                                    height: 40,
                                                    child: const Image(
                                                      image: AssetImage(
                                                          quesitoDeportes),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                          _quesitos[1][_tematicasQuesitos
                                                  .indexOf(CIENCIA)]
                                              ? Transform.translate(
                                                  //QuesitoHistoria J1
                                                  offset:
                                                      const Offset(-205, 60),
                                                  child: Container(
                                                    width: 40,
                                                    height: 40,
                                                    child: Image(
                                                      image: AssetImage(
                                                          quesitoCiencia),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                          _quesitos[1][_tematicasQuesitos
                                                  .indexOf(ENTRETENIMIENTO)]
                                              ? Transform.translate(
                                                  //QuesitoEntretenimiento J1
                                                  offset:
                                                      const Offset(-205, 60),
                                                  child: Container(
                                                    width: 40,
                                                    height: 40,
                                                    child: Image(
                                                      image: AssetImage(
                                                          quesitoEntretenimiento),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                          _quesitos[1][_tematicasQuesitos
                                                  .indexOf(GEOGRAFIA)]
                                              ? Transform.translate(
                                                  //QuesitoGeografia J1
                                                  offset:
                                                      const Offset(-205, 60),
                                                  child: Container(
                                                    width: 40,
                                                    height: 40,
                                                    child: Image(
                                                      image: AssetImage(
                                                          quesitoGeografia),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                        ],
                                      )
                                    : const SizedBox.shrink(),

                                // J2
                                _jugadores > 2
                                    ? Stack(
                                        children: [
                                          Transform.translate(
                                            //Texto J2
                                            offset: const Offset(-262, 112),
                                            child: Text(
                                              _nombresJugadores[2],
                                              style: const TextStyle(
                                                  fontFamily: "Baskerville",
                                                  fontSize: 12.0,
                                                  //color: Color(0xFFc9c154),
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255),
                                                  fontWeight: FontWeight.bold,
                                                  decoration:
                                                      TextDecoration.none),
                                            ),
                                          ),
                                          Transform.translate(
                                            //Imagen J2
                                            offset: const Offset(-265, 130),
                                            child: Container(
                                              width: 70,
                                              height: 70,
                                              child: const Image(
                                                image: AssetImage(
                                                  imagenJugador,
                                                ),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          _turno == _nombresJugadores[2]
                                              ? Transform.translate(
                                                  //Imagen turno J2
                                                  offset:
                                                      const Offset(-265, 130),
                                                  child: Container(
                                                    width: 70,
                                                    height: 70,
                                                    child: Image(
                                                      image: AssetImage(
                                                          imagenJugadorTurno),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                          Transform.translate(
                                            //Imagen turno J0
                                            offset: const Offset(-285, 188),
                                            child: Container(
                                              width: 30,
                                              height: 30,
                                              child: Image(
                                                image: NetworkImage(
                                                    '$urlDir${_fichas[2]}'),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          Transform.translate(
                                            //Putos J2
                                            offset: const Offset(-205, 180),
                                            child: Container(
                                              width: 40,
                                              height: 40,
                                              decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      quesitosGeneral),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          ),
                                          _quesitos[2][_tematicasQuesitos
                                                  .indexOf(HISTORIA)]
                                              ? Transform.translate(
                                                  //QuesitoHistoria J2
                                                  offset:
                                                      const Offset(-205, 180),
                                                  child: Container(
                                                    width: 40,
                                                    height: 40,
                                                    child: const Image(
                                                      image: AssetImage(
                                                          quesitoHistoria),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                          _quesitos[2][_tematicasQuesitos
                                                  .indexOf(ARTE)]
                                              ? Transform.translate(
                                                  //QuesitoHistoria J2
                                                  offset:
                                                      const Offset(-205, 180),
                                                  child: Container(
                                                    width: 40,
                                                    height: 40,
                                                    child: const Image(
                                                      image: AssetImage(
                                                          quesitoArte),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                          _quesitos[2][_tematicasQuesitos
                                                  .indexOf(DEPORTES)]
                                              ? Transform.translate(
                                                  //QuesitoHistoria J2
                                                  offset:
                                                      const Offset(-205, 180),
                                                  child: Container(
                                                    width: 40,
                                                    height: 40,
                                                    child: const Image(
                                                      image: AssetImage(
                                                          quesitoDeportes),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                          _quesitos[2][_tematicasQuesitos
                                                  .indexOf(CIENCIA)]
                                              ? Transform.translate(
                                                  //QuesitoHistoria J2
                                                  offset:
                                                      const Offset(-205, 180),
                                                  child: Container(
                                                    width: 40,
                                                    height: 40,
                                                    child: Image(
                                                      image: AssetImage(
                                                          quesitoCiencia),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                          _quesitos[2][_tematicasQuesitos
                                                  .indexOf(ENTRETENIMIENTO)]
                                              ? Transform.translate(
                                                  //QuesitoEntretenimiento J2
                                                  offset:
                                                      const Offset(-205, 180),
                                                  child: Container(
                                                    width: 40,
                                                    height: 40,
                                                    child: Image(
                                                      image: AssetImage(
                                                          quesitoEntretenimiento),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                          _quesitos[2][_tematicasQuesitos
                                                  .indexOf(GEOGRAFIA)]
                                              ? Transform.translate(
                                                  //QuesitoGeografia J2
                                                  offset:
                                                      const Offset(-205, 180),
                                                  child: Container(
                                                    width: 40,
                                                    height: 40,
                                                    child: Image(
                                                      image: AssetImage(
                                                          quesitoGeografia),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                        ],
                                      )
                                    : const SizedBox.shrink(),

                                // J3
                                _jugadores > 3
                                    ? Stack(
                                        children: [
                                          Transform.translate(
                                            //Texto J3
                                            offset: const Offset(293, -128),
                                            child: Text(
                                              _nombresJugadores[3],
                                              style: const TextStyle(
                                                  fontFamily: "Baskerville",
                                                  fontSize: 12.0,
                                                  //color: Color(0xFFc9c154),
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255),
                                                  fontWeight: FontWeight.bold,
                                                  decoration:
                                                      TextDecoration.none),
                                            ),
                                          ),
                                          Transform.translate(
                                            //Imagen J3
                                            offset: const Offset(290, -110),
                                            child: Container(
                                              width: 70,
                                              height: 70,
                                              child: const Image(
                                                image: AssetImage(
                                                  imagenJugador,
                                                ),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          _turno == _nombresJugadores[3]
                                              ? Transform.translate(
                                                  //Imagen turno J3
                                                  offset:
                                                      const Offset(290, -110),
                                                  child: Container(
                                                    width: 70,
                                                    height: 70,
                                                    child: Image(
                                                      image: AssetImage(
                                                          imagenJugadorTurno),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                          Transform.translate(
                                            //Putos J3
                                            offset: const Offset(260, -60),
                                            child: Container(
                                              width: 40,
                                              height: 40,
                                              decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      quesitosGeneral),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Transform.translate(
                                            //Imagen turno J3
                                            offset: const Offset(355, -52),
                                            child: Container(
                                              width: 30,
                                              height: 30,
                                              child: Image(
                                                image: NetworkImage(
                                                    '$urlDir${_fichas[3]}'),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          _quesitos[3][_tematicasQuesitos
                                                  .indexOf(HISTORIA)]
                                              ? Transform.translate(
                                                  //QuesitoHistoria J3
                                                  offset:
                                                      const Offset(260, -60),
                                                  child: Container(
                                                    width: 40,
                                                    height: 40,
                                                    child: const Image(
                                                      image: AssetImage(
                                                          quesitoHistoria),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                          _quesitos[3][_tematicasQuesitos
                                                  .indexOf(ARTE)]
                                              ? Transform.translate(
                                                  //QuesitoHistoria J3
                                                  offset:
                                                      const Offset(260, -60),
                                                  child: Container(
                                                    width: 40,
                                                    height: 40,
                                                    child: const Image(
                                                      image: AssetImage(
                                                          quesitoArte),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                          _quesitos[3][_tematicasQuesitos
                                                  .indexOf(DEPORTES)]
                                              ? Transform.translate(
                                                  //QuesitoHistoria J3
                                                  offset:
                                                      const Offset(260, -60),
                                                  child: Container(
                                                    width: 40,
                                                    height: 40,
                                                    child: const Image(
                                                      image: AssetImage(
                                                          quesitoDeportes),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                          _quesitos[3][_tematicasQuesitos
                                                  .indexOf(CIENCIA)]
                                              ? Transform.translate(
                                                  //QuesitoHistoria J3
                                                  offset:
                                                      const Offset(260, -60),
                                                  child: Container(
                                                    width: 40,
                                                    height: 40,
                                                    child: Image(
                                                      image: AssetImage(
                                                          quesitoCiencia),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                          _quesitos[3][_tematicasQuesitos
                                                  .indexOf(ENTRETENIMIENTO)]
                                              ? Transform.translate(
                                                  //QuesitoEntretenimiento J3
                                                  offset:
                                                      const Offset(260, -60),
                                                  child: Container(
                                                    width: 40,
                                                    height: 40,
                                                    child: Image(
                                                      image: AssetImage(
                                                          quesitoEntretenimiento),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                          _quesitos[3][_tematicasQuesitos
                                                  .indexOf(GEOGRAFIA)]
                                              ? Transform.translate(
                                                  //QuesitoGeografia J3
                                                  offset:
                                                      const Offset(260, -60),
                                                  child: Container(
                                                    width: 40,
                                                    height: 40,
                                                    child: Image(
                                                      image: AssetImage(
                                                          quesitoGeografia),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                        ],
                                      )
                                    : const SizedBox.shrink(),

                                //J4
                                _jugadores > 4
                                    ? Stack(
                                        children: [
                                          Transform.translate(
                                            //Texto J4
                                            offset: const Offset(293, -8),
                                            child: Text(
                                              _nombresJugadores[4],
                                              style: const TextStyle(
                                                  fontFamily: "Baskerville",
                                                  fontSize: 12.0,
                                                  //color: Color(0xFFc9c154),
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255),
                                                  fontWeight: FontWeight.bold,
                                                  decoration:
                                                      TextDecoration.none),
                                            ),
                                          ),
                                          Transform.translate(
                                            //Imagen J4
                                            offset: const Offset(290, 10),
                                            child: Container(
                                              width: 70,
                                              height: 70,
                                              child: const Image(
                                                image: AssetImage(
                                                  imagenJugador,
                                                ),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          _turno == _nombresJugadores[4]
                                              ? Transform.translate(
                                                  //Imagen turno J4
                                                  offset: const Offset(290, 10),
                                                  child: Container(
                                                    width: 70,
                                                    height: 70,
                                                    child: Image(
                                                      image: AssetImage(
                                                          imagenJugadorTurno),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                          Transform.translate(
                                            //Putos J4
                                            offset: const Offset(260, 60),
                                            child: Container(
                                              width: 40,
                                              height: 40,
                                              decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      quesitosGeneral),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Transform.translate(
                                            //Imagen turno J3
                                            offset: const Offset(355, 70),
                                            child: Container(
                                              width: 30,
                                              height: 30,
                                              child: Image(
                                                image: NetworkImage(
                                                    '$urlDir${_fichas[4]}'),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          _quesitos[4][_tematicasQuesitos
                                                  .indexOf(HISTORIA)]
                                              ? Transform.translate(
                                                  //QuesitoHistoria J4
                                                  offset: const Offset(260, 60),
                                                  child: Container(
                                                    width: 40,
                                                    height: 40,
                                                    child: const Image(
                                                      image: AssetImage(
                                                          quesitoHistoria),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                          _quesitos[4][_tematicasQuesitos
                                                  .indexOf(ARTE)]
                                              ? Transform.translate(
                                                  //QuesitoHistoria J4
                                                  offset: const Offset(260, 60),
                                                  child: Container(
                                                    width: 40,
                                                    height: 40,
                                                    child: const Image(
                                                      image: AssetImage(
                                                          quesitoArte),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                          _quesitos[4][_tematicasQuesitos
                                                  .indexOf(DEPORTES)]
                                              ? Transform.translate(
                                                  //QuesitoHistoria J4
                                                  offset: const Offset(260, 60),
                                                  child: Container(
                                                    width: 40,
                                                    height: 40,
                                                    child: const Image(
                                                      image: AssetImage(
                                                          quesitoDeportes),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                          _quesitos[4][_tematicasQuesitos
                                                  .indexOf(CIENCIA)]
                                              ? Transform.translate(
                                                  //QuesitoHistoria J4
                                                  offset: const Offset(260, 60),
                                                  child: Container(
                                                    width: 40,
                                                    height: 40,
                                                    child: Image(
                                                      image: AssetImage(
                                                          quesitoCiencia),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                          _quesitos[4][_tematicasQuesitos
                                                  .indexOf(ENTRETENIMIENTO)]
                                              ? Transform.translate(
                                                  //QuesitoEntretenimiento J4
                                                  offset: const Offset(260, 60),
                                                  child: Container(
                                                    width: 40,
                                                    height: 40,
                                                    child: Image(
                                                      image: AssetImage(
                                                          quesitoEntretenimiento),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                          _quesitos[4][_tematicasQuesitos
                                                  .indexOf(GEOGRAFIA)]
                                              ? Transform.translate(
                                                  //QuesitoGeografia J4
                                                  offset: const Offset(260, 60),
                                                  child: Container(
                                                    width: 40,
                                                    height: 40,
                                                    child: Image(
                                                      image: AssetImage(
                                                          quesitoGeografia),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                        ],
                                      )
                                    : const SizedBox.shrink(),

                                // J5
                                _jugadores > 5
                                    ? Stack(
                                        children: [
                                          Transform.translate(
                                            //Texto J5

                                            offset: const Offset(293, 112),
                                            child: Text(
                                              _nombresJugadores[5],
                                              style: const TextStyle(
                                                  fontFamily: "Baskerville",
                                                  fontSize: 12.0,
                                                  //color: Color(0xFFc9c154),
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255),
                                                  fontWeight: FontWeight.bold,
                                                  decoration:
                                                      TextDecoration.none),
                                            ),
                                          ),
                                          Transform.translate(
                                            //Imagen J5
                                            offset: const Offset(290, 130),
                                            child: Container(
                                              width: 70,
                                              height: 70,
                                              child: const Image(
                                                image: AssetImage(
                                                  imagenJugador,
                                                ),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          _turno == _nombresJugadores[5]
                                              ? Transform.translate(
                                                  //Imagen turno J5
                                                  offset:
                                                      const Offset(290, 130),
                                                  child: Container(
                                                    width: 70,
                                                    height: 70,
                                                    child: Image(
                                                      image: AssetImage(
                                                          imagenJugadorTurno),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                          Transform.translate(
                                            //Putos J5
                                            offset: const Offset(260, 180),
                                            child: Container(
                                              width: 40,
                                              height: 40,
                                              decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      quesitosGeneral),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Transform.translate(
                                            //Imagen turno J5
                                            offset: const Offset(355, 185),
                                            child: Container(
                                              width: 30,
                                              height: 30,
                                              child: Image(
                                                image: NetworkImage(
                                                    '$urlDir${_fichas[5]}'),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          _quesitos[5][_tematicasQuesitos
                                                  .indexOf(HISTORIA)]
                                              ? Transform.translate(
                                                  //QuesitoHistoria J5
                                                  offset:
                                                      const Offset(260, 180),
                                                  child: Container(
                                                    width: 40,
                                                    height: 40,
                                                    child: const Image(
                                                      image: AssetImage(
                                                          quesitoHistoria),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                          _quesitos[5][_tematicasQuesitos
                                                  .indexOf(ARTE)]
                                              ? Transform.translate(
                                                  //QuesitoHistoria J5
                                                  offset:
                                                      const Offset(260, 180),
                                                  child: Container(
                                                    width: 40,
                                                    height: 40,
                                                    child: const Image(
                                                      image: AssetImage(
                                                          quesitoArte),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                          _quesitos[0][_tematicasQuesitos
                                                  .indexOf(DEPORTES)]
                                              ? Transform.translate(
                                                  //QuesitoHistoria J5
                                                  offset:
                                                      const Offset(260, 180),
                                                  child: Container(
                                                    width: 40,
                                                    height: 40,
                                                    child: const Image(
                                                      image: AssetImage(
                                                          quesitoDeportes),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                          _quesitos[5][_tematicasQuesitos
                                                  .indexOf(CIENCIA)]
                                              ? Transform.translate(
                                                  //QuesitoHistoria J5
                                                  offset:
                                                      const Offset(260, 180),
                                                  child: Container(
                                                    width: 40,
                                                    height: 40,
                                                    child: Image(
                                                      image: AssetImage(
                                                          quesitoCiencia),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                          _quesitos[5][_tematicasQuesitos
                                                  .indexOf(ENTRETENIMIENTO)]
                                              ? Transform.translate(
                                                  //QuesitoEntretenimiento J5
                                                  offset:
                                                      const Offset(260, 180),
                                                  child: Container(
                                                    width: 40,
                                                    height: 40,
                                                    child: Image(
                                                      image: AssetImage(
                                                          quesitoEntretenimiento),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                          _quesitos[5][_tematicasQuesitos
                                                  .indexOf(GEOGRAFIA)]
                                              ? Transform.translate(
                                                  //QuesitoGeografia J5
                                                  offset:
                                                      const Offset(260, 180),
                                                  child: Container(
                                                    width: 40,
                                                    height: 40,
                                                    child: Image(
                                                      image: AssetImage(
                                                          quesitoGeografia),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                        ],
                                      )
                                    : const SizedBox.shrink(),
                              ],
                            ),
                            Stack(
                              children: [
                                // Contador
                                Transform.translate(
                                  offset: Offset(-175, -120),
                                  child: Container(
                                    width: 55,
                                    height: 55,
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '$_contadorDado',
                                        style: const TextStyle(fontSize: 40),
                                      ),
                                    ),
                                  ),
                                ),
                                //ImagenDado

                                GestureDetector(
                                  onTap: () {
                                    print("gucci");
                                  },
                                  child: Transform.rotate(
                                    angle: 0 * pi / 180,
                                    child: Transform.translate(
                                      offset: const Offset(190, -120),
                                      child: Ink(
                                        width: 50,
                                        height: 50,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            print("Hola");
                                            if (_esperandoDado) {
                                              _ejecutarAccion(
                                                  ACCION_PULSARDADO);
                                            }
                                          },
                                          child: null,
                                          style: ElevatedButton.styleFrom(
                                            foregroundColor: Colors.transparent,
                                            backgroundColor:
                                                Color.fromARGB(255, 0, 0, 0),
                                            padding: EdgeInsets.zero,
                                            elevation: 0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          print("Hola");
                          if (_esperandoDado) {
                            _ejecutarAccion(ACCION_PULSARDADO);
                          }
                        },
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10, left: 330),
                            child: Image.asset(
                              'assets/cara$_valorDado.png',
                              height: 50,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(bottom: 10, right: 360),
                          child: _turno != _yo
                              ? Boton1(
                                  'Salir',
                                  onPressed: () {
                                    _ejecutarAccion(ACCION_ABANDONARPARTIDA);
                                  },
                                )
                              : const SizedBox.shrink(),
                        ),
                      ),
                      !_preguntaActiva && _turno == _yo
                          ? Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10, left: 330),
                            child:Boton1(
                                'Pausar',
                                onPressed: () {
                                  _ejecutarAccion(ACCION_PAUSARPARTIDA);
                                },
                              ),),
                            )
                          : const SizedBox.shrink(),
                      SizedBox(
                        width: screenSize.width,
                        height: screenSize.height,
                        child: Stack(
                          children: [
                            //BOTONES CASILLAS-------------------------------------------------------------------------------------
                            //c0 boton
                            Transform.rotate(
                              angle: 116 * pi / 180,
                              child: Transform.translate(
                                offset: const Offset(138, -379),
                                child: Ink(
                                  width: 61,
                                  height: 40,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      pulsarCasilla(0);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                      pulsarCasilla(1);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                      pulsarCasilla(2);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                      pulsarCasilla(3);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                      pulsarCasilla(4);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                      pulsarCasilla(5);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                      pulsarCasilla(6);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                      pulsarCasilla(7);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                      pulsarCasilla(8);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                      pulsarCasilla(9);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                      pulsarCasilla(10);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                      pulsarCasilla(11);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                      pulsarCasilla(12);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                      pulsarCasilla(13);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                offset: const Offset(521, 145),
                                child: Ink(
                                  width: 48,
                                  height: 44,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      pulsarCasilla(14);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                      pulsarCasilla(15);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                      pulsarCasilla(16);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                      pulsarCasilla(17);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                      pulsarCasilla(18);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                      pulsarCasilla(19);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                      pulsarCasilla(20);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                offset: const Offset(202, 390),
                                child: Ink(
                                  width: 57,
                                  height: 40,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      pulsarCasilla(21);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                      pulsarCasilla(22);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                      pulsarCasilla(23);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                      pulsarCasilla(24);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                      pulsarCasilla(25);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                      pulsarCasilla(26);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                      pulsarCasilla(27);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                offset: const Offset(135, -245),
                                child: Ink(
                                  width: 57,
                                  height: 40,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      pulsarCasilla(28);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                      pulsarCasilla(29);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                      pulsarCasilla(30);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                      pulsarCasilla(31);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                      pulsarCasilla(32);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                      pulsarCasilla(33);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                      pulsarCasilla(34);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                offset: const Offset(201, 146),
                                child: Ink(
                                  width: 48,
                                  height: 44,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      pulsarCasilla(35);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                      pulsarCasilla(36);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                      pulsarCasilla(37);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                      pulsarCasilla(38);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                      pulsarCasilla(39);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                      pulsarCasilla(40);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                      pulsarCasilla(41);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                      pulsarCasilla(42);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                      pulsarCasilla(43);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                      pulsarCasilla(44);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                      pulsarCasilla(45);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                      pulsarCasilla(46);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                      pulsarCasilla(47);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                      pulsarCasilla(48);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                      pulsarCasilla(49);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                      pulsarCasilla(50);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                      pulsarCasilla(51);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                      pulsarCasilla(52);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                      pulsarCasilla(53);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                      pulsarCasilla(54);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                      pulsarCasilla(55);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                      pulsarCasilla(56);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                      pulsarCasilla(57);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                      pulsarCasilla(58);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                      pulsarCasilla(59);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                      pulsarCasilla(60);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                      pulsarCasilla(61);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                      pulsarCasilla(62);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                      pulsarCasilla(63);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                      pulsarCasilla(64);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                      pulsarCasilla(65);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                      pulsarCasilla(66);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                      pulsarCasilla(67);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                      pulsarCasilla(68);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                      pulsarCasilla(69);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                      pulsarCasilla(70);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                      pulsarCasilla(71);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
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
                                      pulsarCasilla(72);
                                    },
                                    child: null,
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.transparent,
                                      backgroundColor:
                                          Color.fromARGB(0, 0, 0, 0),
                                      padding: EdgeInsets.zero,
                                      elevation:
                                          0, //elimina la sombra del boton
                                      splashFactory: NoSplash
                                          .splashFactory, //elimina la onda que aparece al pulsar el boton
                                      //no consigo quitar la sombra que genera al pulsarse pero si la onda
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      _preguntaActiva
                          ? Stack(
                              children: [
                                Center(
                                  child: BackdropFilter(
                                    filter:
                                        ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                    child: Container(
                                      width: screenSize.width,
                                      height: screenSize.height,
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(68, 0, 0, 0),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Center(
                                        child: Container(
                                          width: 470,
                                          height: 280,
                                          decoration: BoxDecoration(
                                            color: colorPregunta,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border:
                                                Border.all(color: Colors.black),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 20.0,
                                                    left: 160,
                                                    bottom: 240),
                                                child: Text(
                                                  _tP == "Tematico"
                                                      ? _tematica
                                                      : _preguntaTema,
                                                  style: const TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255),
                                                    fontFamily: "Baskerville",
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Align(
                                                  alignment: Alignment.topRight,
                                                  child: Container(
                                                    width: 60,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      border: Border.all(
                                                        width: 4,
                                                        color: colorPregunta,
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        '$_contadorPregunta',
                                                        style: const TextStyle(
                                                            fontSize: 24),
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
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 210, bottom: 120),
                                    child: SizedBox(
                                      width: 380,
                                      height: 40,
                                      child: Text(
                                        _pregunta,
                                        style: const TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontFamily: "Baskerville",
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 150, left: 205),
                                  child: Container(
                                    width: 390,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      color: _colorR1,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Colors.black),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        if (!_contestada && _turno == _yo) {
                                          _respuestaContestada = '1';
                                          _ejecutarAccion(
                                              ACCION_CONTESTARPREGUNTA);
                                        }
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, left: 10),
                                        child: Text(
                                          _respuesta1,
                                          style: const TextStyle(
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
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 190, left: 205),
                                  child: Container(
                                    width: 390,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      color: _colorR2,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Colors.black),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        if (!_contestada  && _turno == _yo) {
                                          _respuestaContestada = '2';
                                          _ejecutarAccion(
                                              ACCION_CONTESTARPREGUNTA);
                                        }
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, left: 10),
                                        child: Text(
                                          _respuesta2,
                                          style: const TextStyle(
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
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 230, left: 205),
                                  child: Container(
                                    width: 390,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      color: _colorR3,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Colors.black),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        if (!_contestada  && _turno == _yo) {
                                          _respuestaContestada = '3';
                                          _ejecutarAccion(
                                              ACCION_CONTESTARPREGUNTA);
                                        }
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, left: 10),
                                        child: Text(
                                          _respuesta3,
                                          style: const TextStyle(
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
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 270, left: 205),
                                  child: Container(
                                    width: 390,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      color: _colorR4,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Colors.black),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        if (!_contestada  && _turno == _yo) {
                                          _respuestaContestada = '4';
                                          _ejecutarAccion(
                                              ACCION_CONTESTARPREGUNTA);
                                        }
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, left: 10),
                                        child: Text(
                                          _respuesta4,
                                          style: const TextStyle(
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
                              ],
                            )
                          : const SizedBox.shrink(),
                      Stack(
                        children: [
                          _mostrarChat
                              ? Container(
                                  width: screenSize.width,
                                  height: screenSize.height,
                                  decoration: const BoxDecoration(
                                      color: Color(0x60444444)),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 0),
                                      child: Container(
                                        width: screenSize.width / 2.0,
                                        height: screenSize.height / 1.2,
                                        decoration: BoxDecoration(
                                            color: Colors.black12,
                                            border: Border.all(
                                                color: Colors.black)),
                                        child: Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.black12,
                                                  border: Border.all(
                                                      color: Colors.black)),
                                              child: Stack(
                                                children: [
                                                  TextFormField(
                                                    focusNode: f,
                                                    controller: c,
                                                    decoration: InputDecoration(
                                                      focusedBorder:
                                                          InputBorder.none,
                                                      suffixIcon: IconButton(
                                                        icon: const Icon(
                                                          // Based on passwordVisible state choose the icon
                                                          Icons.send,
                                                          color: Colors.white,
                                                        ),
                                                        onPressed: () {
                                                          if (c.text != "") {
                                                            _enviarChat =
                                                                c.text;
                                                            c.clear();
                                                            f.unfocus();
                                                            _ejecutarAccion(
                                                                ACCION_ENVIARCHAT);
                                                          }
                                                        },
                                                      ),
                                                      contentPadding:
                                                          const EdgeInsets.all(
                                                              12),
                                                      hintStyle:
                                                          const TextStyle(
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color:
                                                            Color(0xFFf7f6f6),
                                                        fontFamily: "Bona Nova",
                                                      ),
                                                      hintText: "Mensaje",
                                                    ),
                                                    style: const TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color(0xFFf7f6f6),
                                                      fontFamily: "Bona Nova",
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: ListView.builder(
                                                controller: _scrollController,
                                                itemCount: _chat.length,
                                                itemBuilder: (context, index) =>
                                                    Align(
                                                  alignment: _chat[index]
                                                          .enviadoPorMi
                                                      ? Alignment.centerRight
                                                      : Alignment.centerLeft,
                                                  child: Card(
                                                    elevation: 8,
                                                    color: _chat[index]
                                                            .enviadoPorMi
                                                        ? const Color.fromARGB(
                                                            255, 134, 189, 235)
                                                        : Colors.white,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      child: Stack(
                                                        children: [
                                                          _chat[index]
                                                                  .enviadoPorMi
                                                              ? const SizedBox
                                                                  .shrink()
                                                              : Text(
                                                                  _chat[index]
                                                                      .escritor,
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                          Padding(
                                                            padding: _chat[
                                                                        index]
                                                                    .enviadoPorMi
                                                                ? const EdgeInsets
                                                                        .only(
                                                                    top: 0)
                                                                : const EdgeInsets
                                                                        .only(
                                                                    top: 18),
                                                            child: Text(
                                                                _chat[index]
                                                                    .text),
                                                          ),
                                                        ],
                                                      ),
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
                                )
                              : const SizedBox.shrink(),
                          Align(
                            alignment: Alignment.center,
                            child: Transform.translate(
                              offset: const Offset(365, -155),
                              child: GestureDetector(
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
                                  onTap: () {
                                    _mostrarChat
                                        ? _ejecutarAccion(ACCION_CERRARCHAT)
                                        : _ejecutarAccion(ACCION_ABRIRCHAT);
                                  }),
                            ),
                          ),
                        ],
                      ),
                      _partidaPausada
                          ? Stack(
                              children: [
                                Center(
                                  child: Container(
                                    width: screenSize.width,
                                    height: screenSize.height,
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(68, 0, 0, 0),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Stack(
                                      children: [
                                        Center(
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 5, sigmaY: 5),
                                            child: Container(
                                              width: screenSize.width,
                                              height: screenSize.height,
                                              decoration: BoxDecoration(
                                                color:
                                                    Color.fromARGB(68, 0, 0, 0),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Center(
                                                child: Container(
                                                  width: 300,
                                                  height: 280,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    border: Border.all(
                                                        color: Colors.black),
                                                  ),
                                                  child: Stack(
                                                    children: [
                                                      const Align(
                                                        alignment:
                                                            Alignment.topCenter,
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 50),
                                                          child: Text(
                                                            'Partida pausada',
                                                            style: TextStyle(
                                                              fontSize: 20.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Container(
                                                          width: 60,
                                                          height: 50,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            border: Border.all(
                                                              width: 4,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              '$_contadorPausa',
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          24),
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
                                        (_turno == _yo)
                                            ? Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 80),
                                                  child: Boton1('Continuar',
                                                      onPressed: () {
                                                    _ejecutarAccion(
                                                        ACCION_CONTINUARPARTIDA);
                                                  }),
                                                ),
                                              )
                                            : const SizedBox.shrink()
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox.shrink(),
                          _finPartida
                          ? Stack(
                              children: [
                                Center(
                                  child: Container(
                                    width: screenSize.width,
                                    height: screenSize.height,
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(68, 0, 0, 0),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Stack(
                                      children: [
                                        Center(
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 5, sigmaY: 5),
                                            child: Container(
                                              width: screenSize.width,
                                              height: screenSize.height,
                                              decoration: BoxDecoration(
                                                color:
                                                    Color.fromARGB(68, 0, 0, 0),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Center(
                                                child: Container(
                                                  width: 300,
                                                  height: 280,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    border: Border.all(
                                                        color: Colors.black),
                                                  ),
                                                  child: Stack(
                                                    children: [
                                                       Align(
                                                        alignment:
                                                            Alignment.topCenter,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets.only(
                                                                  top: 50),
                                                          child: Text(
                                                            'Ha ganado $_turno',
                                                            style: const TextStyle(
                                                              fontSize: 20.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black,
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
                                        ),Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 80),
                                                  child: Boton1('Volver al menú',
                                                      onPressed: () {
                                                    _ejecutarAccion(
                                                        ACCION_SALIR);
                                                  }),
                                                ),
                                              ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
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
    path.lineTo(-28, -50); //arriba izq
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
    path.lineTo(30, h + 8);
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
