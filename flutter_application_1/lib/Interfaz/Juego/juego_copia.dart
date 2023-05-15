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
  Color Amarillo = const Color.fromARGB(255, 219, 205, 0);
  Color Blanco = const Color.fromARGB(255, 255, 255, 255);

  Color Fallo = const Color.fromARGB(160, 240, 44, 19);
  Color Acierto = const Color.fromARGB(160, 53, 224, 18);

  late Color colorPregunta;
  Color Gris = Colors.grey;
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
      ACCION_FINPARTIDA = 'Fin_partida';
  //--------------------------------

  static const String TRUE = 'true', FALSE = 'false';

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
  String _preguntaTema = "adada";
  bool _preguntaQuesito = false;
  String _pregunta = "adadddaadadad";
  String _respuesta1 = "ada";
  String _respuesta2 = "adaa";
  String _respuesta3 = "adada";
  String _respuesta4 = "a";
  String _respuestaContestada = "";
  String _respuestaCorrecta = "";
  String _respuestaNoContestada = "";
  bool _esCorrecta = false, _contestada = false;
  int _contadorPregunta = 99, _contadorPausa = 0, _contadorDado = 0;

  late Color _colorR1, _colorR2, _colorR3, _colorR4;
  Timer? _timerPregunta = null, _timerRespuesta = null, _timerPausar = null, _timerDado = null;

  bool _partidaPausada = false,
      _timerDadoDesactivado = false,
      _mostrandoCasillas = false;

  bool _mensajeInicial = true;
  bool _socketActivo = false;

  final FocusNode f = FocusNode();
  final TextEditingController c = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    print(_wS);
    

    try {
      _socket = IOWebSocketChannel.connect(_wS);
      _socketActivo = true;
    } catch (error) {
      print(error);
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
      }, onDone: () {
        print("sokcet hasta luego");
        _socket.sink.close();

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Menu(_s)),
            (Route<dynamic> route) => false);
      });
      _yo = _s.getField(SesionFieldsCodes.usuario);
      print(_yo);
    }
  }

  @override
  void dispose() {
    print("dipose");
    if (_socketActivo) {
      _socket.sink.close();
    }

    f.dispose();
    c.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _ejecutarAccion(String accion) {
    print("Accion $accion");
    switch (accion) {
      /* Acciones turno */
      //--------------------------------
      case ACCION_CAMBIOTURNO:
        _contadorDado = 10;
        if (_turno == _yo) {
          _esperandoDado = true;
        }
        _timerDado = Timer.periodic(const Duration(seconds: 1), (timer) {
          if (_contadorDado > 0) {
            _contadorDado--;
            setState(() {});
          } else {
            if (_esperandoDado) {
              _ejecutarAccion(ACCION_PULSARDADO);
            }
            _timerDado.cancel();
          }
        });
        setState(() {});
        break;

      //--------------------------------

      /* Acciones dado */
      //--------------------------------
      case ACCION_PULSARDADO:
        _esperandoDado = false;
        if (_timerDado.isActive) {
          _timerDado.cancel();
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
        _mostrandoCasillas = true;
        setState(() {});
        break;

      case ACCION_MOVERFICHA:
        _mostrandoCasillas = false;

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
        switch (_preguntaTema) {
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
          if (_contadorPregunta > 0) {
            _contadorPregunta--;
            setState(() {});
          } else {
            _timerPregunta.cancel();
            if (_turno == _yo && !_contestada) {
              _ejecutarAccion(ACCION_NOCONTESTAR);
            }
          }
        });

        break;
      case ACCION_MOSTRARRESPUESTA:
        if (_timerPregunta.isActive) {
          _timerPregunta.cancel();
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
          if (!_quesitos[index2][index1]) {
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
          if (_contadorPregunta > 0) {
            _contadorPregunta--;
            setState(() {});
          } else {
            _timerRespuesta.cancel();
            print("ocultarpregunta");
            if (_yo == _turno) {
              _enviarMensaje((Mensaje_FinPregunta));
            }
            _ejecutarAccion(ACCION_OCULTARPREGUNTA);
          }
        });

        setState(() {});

        break;

      case ACCION_CONTESTARPREGUNTA:
        _contestada = true;
        _timerPregunta.cancel();
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
        if (_timerDado.isActive) {
          _timerDado.cancel();
          _timerDadoDesactivado = true;
        }

        _contadorPausa = 30;
        _timerPausar = Timer.periodic(const Duration(seconds: 1), (timer) {
          if (_contadorPausa > 0) {
            _contadorPausa--;
            setState(() {});
          } else {
            _timerPausar.cancel();
            if (_turno == _yo) {
              _ejecutarAccion(ACCION_CONTINUARPARTIDA);
            }
          }
        });
        if(_turno == _yo){
          _enviarMensaje(Mensaje_PausarPartida);
        }

        setState(() {});
        break;

      case ACCION_CONTINUARPARTIDA:
        _partidaPausada = false;
        if (_turno == _yo) {
          _enviarMensaje(Mensaje_ContinuarPartida);
        }
        if (_timerPausar.isActive) {
          _timerPausar.cancel();
        }
        if (_timerDadoDesactivado) {
          _timerDadoDesactivado = false;
          _timerDado = Timer.periodic(const Duration(seconds: 1), (timer) {
            if (_contadorDado > 0) {
              _contadorDado--;
              setState(() {});
            } else {
              _timerDado.cancel();
              _ejecutarAccion(ACCION_PULSARDADO);
            }
          });
        }
        setState(() {});
        break;

      case ACCION_FINPARTIDA:
        print("fin");
        _socket.sink.close();

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Menu(_s)),
            (Route<dynamic> route) => false);
        break;

      case ACCION_ABANDONARPARTIDA:
        if(_timerPausar != null){
          _timerPausar.cancel();
        }
        if(_timerPregunta.isActive){
          _timerPregunta.cancel();
        }
        if(_timerRespuesta.isActive){
          _timerRespuesta.cancel();
        }
        if(_timerDado.isActive){
          _timerDado.cancel();
        }
        _timerDado.cancel();
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
    print('Enviar mensaje : $m');
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
    print("Mensaje enviado $mensaje");
    _socket.sink.add(mensaje);
  }

  void _leerMensaje(String mensaje) {
    Map<String, dynamic> mensajeDecodificado = json.decode(mensaje);
    print(mensajeDecodificado);
    if (_mensajeInicial) {
      _mensajeInicial = false;
      _tiempoPregunta = mensajeDecodificado[TIEMPOP_KEY];
      _tiempoElegirCasilla = mensajeDecodificado[TIEMPOC_KEY];
      _error = mensajeDecodificado[ERROR_KEY];
      for (var datosJugador in mensajeDecodificado[JUGADORES_KEY]) {
        _jugadores++;
        if (datosJugador[JUGADOR_KEY] ==
            _s.getField(SesionFieldsCodes.usuario)) {
          _fondoTablero = datosJugador[TABLERO_KEY];
        }
        if (datosJugador[TURNO_KEY] == "1") {
          _turno = datosJugador[JUGADOR_KEY];
        }
        _nombresJugadores.add(datosJugador[JUGADOR_KEY]);
        _posiciones.add(datosJugador[POSICION_KEY]);
        _quesitos.add(List.generate(6, (_) => false));
        _fichas.add(datosJugador[FICHA_KEY]);
      }

      _ejecutarAccion(ACCION_CAMBIOTURNO);
      setState(() {});
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
              if (_timerDado!= null && _timerDado!.isActive) {
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
          print("chat");
          _chat.add(Mensaje(mensajeDecodificado[CHATMENSAJE_KEY], false,
              mensajeDecodificado[JUGADOR_KEY]));
          print("chat_leido");
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
                print("ocultarpregunta");
                _ejecutarAccion(ACCION_OCULTARPREGUNTA);
              }
              break;
          }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    final Size screenSize = MediaQuery.of(context).size;
    print("Turno de : $_turno");
    return Scaffold(
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
        child: LayoutBuilder(
          builder: (context, constraints) {
            return _mensajeInicial
                ? const SizedBox.shrink()
                : Stack(
                    children: [
                      _preguntaActiva
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
                                    child: Center(
                                      child: Container(
                                        width: 400,
                                        height: 280,
                                        decoration: BoxDecoration(
                                          color: colorPregunta,
                                          borderRadius:
                                              BorderRadius.circular(20),
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
                                                _preguntaTema,
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
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 205, bottom: 140),
                                    child: Text(
                                      _pregunta,
                                      style: const TextStyle(
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontFamily: "Baskerville",
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
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        if (!_contestada) {
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
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        if (!_contestada) {
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
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        if (!_contestada) {
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
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        if (!_contestada) {
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
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 60, bottom: 40),
                          child: Container(
                            child: Text(
                              'Turno de $_turno',
                              style: const TextStyle(fontSize: 24),
                            ),
                          ),
                        ),
                      ),
                      _mostrandoCasillas
                          ? Container(
                              width: constraints.maxWidth,
                              height: constraints.maxHeight,
                              decoration:
                                  const BoxDecoration(color: Color(0x60444444)),
                              child: Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 0),
                                  child: Container(
                                    width: constraints.maxWidth / 2.0,
                                    height: constraints.maxHeight / 1.2,
                                    decoration: BoxDecoration(
                                        color: Colors.black12,
                                        border:
                                            Border.all(color: Colors.black)),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: ListView.builder(
                                            itemCount: _nuevasCasillas.length,
                                            itemBuilder: (context, index) =>
                                                Align(
                                              child: Card(
                                                elevation: 8,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(12),
                                                  child: TextButton(
                                                      onPressed: () {
                                                        if (_turno == _yo) {
                                                          _casillaElegida =
                                                              _nuevasCasillas[
                                                                  index];
                                                          _ejecutarAccion(
                                                              ACCION_MOVERFICHA);
                                                        }
                                                      },
                                                      child: Text(
                                                        _nuevasCasillas[index],
                                                      )),
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
                          offset: const Offset(375, -125),
                          child: GestureDetector(
                              child: Container(
                                width: 80,
                                height: 50,
                                decoration: const BoxDecoration(
                                    color:
                                        Colors.black // image: DecorationImage(
                                    //   image: AssetImage('assets/Chat.png'),
                                    //   fit: BoxFit.fill,
                                    // ),
                                    ),
                              ),
                              onTap: () {
                                _ejecutarAccion(ACCION_ABRIRCHAT);
                              }),
                        ),
                      ),
                      _partidaPausada && _turno == _yo ? Align(
                        alignment: Alignment.center,
                        child: Transform.translate(
                          offset: const Offset(375, 125),
                          child: GestureDetector(
                              child: Container(
                                width: 80,
                                height: 50,
                                decoration: const BoxDecoration(
                                    color:
                                        Colors.black // image: DecorationImage(
                                    //   image: AssetImage('assets/Chat.png'),
                                    //   fit: BoxFit.fill,
                                    // ),
                                    ),
                              ),
                              onTap: () {
                               _ejecutarAccion(ACCION_PAUSARPARTIDA);
                              }),
                        ),
                      ) : const SizedBox.shrink(),
                      _mostrarChat
                          ? Container(
                              width: constraints.maxWidth,
                              height: constraints.maxHeight,
                              decoration:
                                  const BoxDecoration(color: Color(0x60444444)),
                              child: Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 0),
                                  child: Container(
                                    width: constraints.maxWidth / 2.0,
                                    height: constraints.maxHeight / 1.2,
                                    decoration: BoxDecoration(
                                        color: Colors.black12,
                                        border:
                                            Border.all(color: Colors.black)),
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
                                                  suffixIcon: IconButton(
                                                    icon: const Icon(
                                                      // Based on passwordVisible state choose the icon
                                                      Icons.send,
                                                      color: Colors.white,
                                                    ),
                                                    onPressed: () {
                                                      if (c.text != "") {
                                                        _enviarChat = c.text;
                                                        c.clear();
                                                        f.unfocus();
                                                        _ejecutarAccion(
                                                            ACCION_ENVIARCHAT);
                                                      }
                                                    },
                                                  ),
                                                  contentPadding:
                                                      const EdgeInsets.all(12),
                                                  hintStyle: const TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Color(0xFFf7f6f6),
                                                    fontFamily: "Bona Nova",
                                                  ),
                                                  hintText: "Mensaje",
                                                ),
                                                style: const TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
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
                                              alignment:
                                                  _chat[index].enviadoPorMi
                                                      ? Alignment.centerRight
                                                      : Alignment.centerLeft,
                                              child: Card(
                                                elevation: 8,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(12),
                                                  child:
                                                      Text(_chat[index].text),
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
                      _mostrarChat
                          ? Align(
                              alignment: Alignment.center,
                              child: Transform.translate(
                                offset: const Offset(375, -125),
                                child: GestureDetector(
                                    child: Container(
                                      width: 80,
                                      height: 50,
                                      decoration: const BoxDecoration(
                                          color: Colors
                                              .black // image: DecorationImage(
                                          //   image: AssetImage('assets/Chat.png'),
                                          //   fit: BoxFit.fill,
                                          // ),
                                          ),
                                    ),
                                    onTap: () {
                                      _ejecutarAccion(ACCION_CERRARCHAT);
                                    }),
                              ),
                            )
                          : const SizedBox.shrink(),
                      Stack(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 100, top: 20),
                              child: Container(
                                width: 60,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Text(
                                    '$_contadorDado',
                                    style: const TextStyle(fontSize: 24),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              print("pulsarDado boton");
                              if (_esperandoDado) {
                                print("pulsarDado boton");
                                _ejecutarAccion(ACCION_PULSARDADO);
                              }
                            },
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 40, top: 20),
                                child: Container(
                                  //ImagenDadoS
                                  child: Image.asset(
                                    'assets/cara$_valorDado.png',
                                    height: 50,
                                  ),
                                  //BotonDado
                                ),
                              ),
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
                                          child: Container(
                                            width: 400,
                                            height: 280,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Expanded(
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
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      '$_contadorPausa',
                                                      style: const TextStyle(
                                                          fontSize: 24),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        (_turno == _yo)
                                            ? Center(
                                                child: TextButton(
                                                    onPressed: () {
                                                      _ejecutarAccion(
                                                          ACCION_CONTINUARPARTIDA);
                                                    },
                                                    child: Text("Continuar")),
                                              )
                                            : const SizedBox.shrink()
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox.shrink(),

                          _turno == _yo ? const SizedBox.shrink() : Align(
                        alignment: Alignment.center,
                        child: Transform.translate(
                          offset: const Offset(375, 0),
                          child: GestureDetector(
                              child: Container(
                                width: 80,
                                height: 50,
                                decoration: const BoxDecoration(
                                    color:
                                        Colors.black // image: DecorationImage(
                                    //   image: AssetImage('assets/Chat.png'),
                                    //   fit: BoxFit.fill,
                                    // ),
                                    ),
                              ),
                              onTap: () {
                                _ejecutarAccion(ACCION_ABANDONARPARTIDA);
                              }),
                        ),
                      ),
                          
                    ],
                  );
          },
        ),
      ),
    );
  }
}

class BotonDado extends StatelessWidget {
  final String textContrasenya;
  final VoidCallback onPressed;
  final int turno;
  const BotonDado(String t,
      {Key? key, required this.onPressed, required this.turno})
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
              padding:
                  const EdgeInsets.only(top: 4, bottom: 4, left: 15, right: 15),
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
