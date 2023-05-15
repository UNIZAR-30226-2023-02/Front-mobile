// ignore: file_names
// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/API/enviarInvitacion.dart';
import 'package:flutter_application_1/Interfaz/Menu/index.dart';
import 'package:flutter_application_1/Interfaz/Menu/Estilo/index.dart';
import 'package:web_socket_channel/io.dart';

import '../../../../Data_types/index.dart';

import '../../../../API/index.dart';
import 'juego_copia.dart';

//ignore: must_be_immutable
class SalaEspera extends StatefulWidget {
  const SalaEspera(this._s, this._wS, this._tP, {Key? key}) : super(key: key);
  final String _wS;
  final Sesion _s;
  final String _tP;
  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _SalaEsperaState createState() => _SalaEsperaState(_s, _wS, _tP);
}

class _SalaEsperaState extends State<SalaEspera> {
  _SalaEsperaState(this._s, this._wS, this._tP);
  final Sesion _s;
  final String _wS;
  final String _tP;
  List<String> _jugadores = <String>[];

  List<String> _a = <String>[];

  static const String ACCION_KEY = 'accion',
      ACCION_AL = 'actualizar_lista',
      ACCION_EP = 'empezar_partida',
      USERNAMES_KEY = 'usernames',
      URL_KEY = 'url_partida';
  bool _esperandoJugadores = true,
      _invitarAmigos = false,
      _peticionEnviada = false,
      _errorPeticion = false,
      _salirSala = false;
  String _sErrorPeticion = "", _amigo = "";
  late IOWebSocketChannel _socket;

  @override
  void initState() {
    super.initState();
    try {
      _socket = IOWebSocketChannel.connect(_wS);
    } catch (error) {
      print("error $_wS");
      return;
    }

    _socket.stream.listen((mensaje) {
      _leerMensaje(mensaje);
    });
  }

  _obtenerAmigos() async {
    Future<DatosUsuarioResponse> f = obtenerDatosUsuario(
        DatosUsuarioPetition(_s.getField(SesionFieldsCodes.token)));
    DatosUsuarioResponse r = await f;
    if (r.OK) {
      _a = r.amigos;
      setState(() {});
    }
  }

  _enviarInvitacion(int index) async {
    Future<EnviarInvitacionResponse> f = enviarInvitacion(
        EnviarInvitacionPetition(_a[index]),
        _s.getField(SesionFieldsCodes.token));
    EnviarInvitacionResponse r = await f;
    if (r.OK) {
      _peticionEnviada = true;
      _amigo = _a[index];
    } else {
      _errorPeticion = true;
      _sErrorPeticion = r.error;
    }
    setState(() {});
  }

  void _leerMensaje(String mensaje) {
    Map<String, dynamic> mensajeDecodificado = json.decode(mensaje);
    print(mensajeDecodificado);
    String accion = mensajeDecodificado[ACCION_KEY];
    if (accion == ACCION_AL) {
     if(_esperandoJugadores){ String l = mensajeDecodificado[USERNAMES_KEY];
      _jugadores = l.split(",");
      setState(() {});
     }
    } else if (accion == ACCION_EP) {
      _esperandoJugadores = false;
      _invitarAmigos = false;
      _errorPeticion = false;
      _peticionEnviada = false;
      _salirSala = false;
      setState(() {});

      String url = mensajeDecodificado[URL_KEY];
      
      Timer timer = Timer(const Duration(seconds: 1), () {
        _socket.sink.close();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => Juego(
                    _s,
                    '$wsDir$url?username=${_s.getField(SesionFieldsCodes.usuario)}',
                    _tP)),
            (Route<dynamic> route) => false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WillPopScope(
        onWillPop: () async {
          if (_esperandoJugadores) {
            if (_salirSala) {
              _salirSala = false;
            } else if (_errorPeticion) {
              _errorPeticion = false;
            } else if (_peticionEnviada) {
              _peticionEnviada = false;
            } else if (_invitarAmigos) {
              _invitarAmigos = false;
            } else {
              _salirSala = true;
            }
            setState(() {});
          }
          return false;
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: LayoutBuilder(
            builder: (context, BoxConstraints constraints) {
              return Container(
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/tapete.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 30, right: 70),
                        child: Text(
                          _esperandoJugadores
                              ? "Esperando jugadores..."
                              : "Iniciando partida",
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFf7f6f6),
                            fontFamily: "Bona Nova",
                          ),
                        ),
                      ),
                    ),
                    const Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 25, right: 30),
                        child: SizedBox(
                          width: 32,
                          height: 33,
                          child: AnimacionImagen(),
                        ),
                      ),
                    ),
                    _jugadores.isNotEmpty
                        ? Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: constraints.maxWidth / 15,
                                  top: constraints.maxHeight / 13),
                              child: Container(
                                height: constraints.maxHeight / 2.5,
                                width: constraints.maxWidth / 7,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            bottom: constraints.maxHeight / 25),
                                        child: Text(
                                          _jugadores[0],
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontFamily: "Baskerville",
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: constraints.maxHeight / 40),
                                        child: Icon(
                                          Icons.person,
                                          color: Colors.white,
                                          size: constraints.maxWidth / 10,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                    _jugadores.length > 5
                        ? Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: constraints.maxWidth / 15,
                                  bottom: constraints.maxHeight / 13),
                              child: Container(
                                height: constraints.maxHeight / 2.5,
                                width: constraints.maxWidth / 7,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            bottom: constraints.maxHeight / 25),
                                        child: Text(
                                          _jugadores[5],
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontFamily: "Baskerville",
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: constraints.maxHeight / 40),
                                        child: Icon(
                                          Icons.person,
                                          color: Colors.white,
                                          size: constraints.maxWidth / 10,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                    _jugadores.length > 2
                        ? Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: constraints.maxHeight / 13,
                                  right: constraints.maxWidth / 3),
                              child: Container(
                                height: constraints.maxHeight / 2.5,
                                width: constraints.maxWidth / 7,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            bottom: constraints.maxHeight / 30),
                                        child: Text(
                                          _jugadores[2],
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontFamily: "Baskerville",
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: constraints.maxHeight / 40),
                                        child: Icon(
                                          Icons.person,
                                          color: Colors.white,
                                          size: constraints.maxWidth / 10,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                    _jugadores.length > 4
                        ? Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  right: constraints.maxWidth / 3,
                                  bottom: constraints.maxHeight / 13),
                              child: Container(
                                height: constraints.maxHeight / 2.5,
                                width: constraints.maxWidth / 7,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            bottom: constraints.maxHeight / 25),
                                        child: Text(
                                          _jugadores[1],
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontFamily: "Baskerville",
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: constraints.maxHeight / 40),
                                        child: Icon(
                                          Icons.person,
                                          color: Colors.white,
                                          size: constraints.maxWidth / 10,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                    _jugadores.length > 3
                        ? Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: constraints.maxWidth / 20,
                                  top: constraints.maxHeight / 13),
                              child: Container(
                                height: constraints.maxHeight / 2.5,
                                width: constraints.maxWidth / 7,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            bottom: constraints.maxHeight / 25),
                                        child: Text(
                                          _jugadores[3],
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontFamily: "Baskerville",
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: constraints.maxHeight / 40),
                                        child: Icon(
                                          Icons.person,
                                          color: Colors.white,
                                          size: constraints.maxWidth / 10,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                    _jugadores.length > 1
                        ? Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: constraints.maxWidth / 20,
                                  bottom: constraints.maxHeight / 13),
                              child: Container(
                                height: constraints.maxHeight / 2.5,
                                width: constraints.maxWidth / 7,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            bottom: constraints.maxHeight / 25),
                                        child: Text(
                                          _jugadores[1],
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontFamily: "Baskerville",
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: constraints.maxHeight / 40),
                                        child: Icon(
                                          Icons.person,
                                          color: Colors.white,
                                          size: constraints.maxWidth / 10,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                    _esperandoJugadores
                        ? Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  right: constraints.maxWidth / 12,
                                  top: constraints.maxHeight / 3),
                              child: Boton1(
                                "Invitar Amigos",
                                onPressed: () {
                                  _obtenerAmigos();
                                  _invitarAmigos = true;
                                  setState(() {});
                                },
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                    _esperandoJugadores && _invitarAmigos
                        ? Container(
                            height: constraints.maxHeight,
                            width: constraints.maxWidth,
                            decoration:
                                const BoxDecoration(color: Color(0x60444444)),
                            child: Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 0),
                                child: Container(
                                  width: constraints.maxWidth / 1.3,
                                  height: constraints.maxHeight / 1.3,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF164966),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                  ),
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: Stack(
                                          children: [
                                            SizedBox(
                                              width: constraints.maxWidth / 1.7,
                                              height:
                                                  constraints.maxHeight / 1.8,
                                              child: ListView.separated(
                                                padding: const EdgeInsets.only(
                                                    top: 5, bottom: 5),
                                                itemCount: _a.length,
                                                separatorBuilder:
                                                    (context, index) =>
                                                        const Divider(
                                                  color: Colors.transparent,
                                                  thickness: 1.5,
                                                ),
                                                itemBuilder: (context, index) {
                                                  return Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        border: Border.all(
                                                            color:
                                                                Colors.white),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20)),
                                                    child: Stack(
                                                      children: [
                                                        ListTile(
                                                            title: Text(
                                                                _a[index])),
                                                        Align(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: Padding(
                                                            padding: EdgeInsets.only(
                                                                top: 5,
                                                                bottom: 5,
                                                                right: constraints
                                                                        .maxWidth /
                                                                    50),
                                                            child: Boton1(
                                                              "Enviar invitación",
                                                              onPressed: () {
                                                                _enviarInvitacion(
                                                                    index);
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 7, right: 7),
                                          child: Container(
                                            width: 33,
                                            height: 33,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 1),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: IconButton(
                                            iconSize: 31,
                                            icon: const Icon(
                                              Icons.close,
                                              color: Colors.white,
                                            ),
                                            onPressed: () {
                                              _invitarAmigos = false;
                                              setState(() {});
                                            }),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                    _errorPeticion
                        ? Container(
                            height: constraints.maxHeight,
                            width: constraints.maxWidth,
                            decoration:
                                const BoxDecoration(color: Colors.transparent),
                            margin: const EdgeInsets.only(top: 0),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 85),
                                child: Stack(
                                  children: [
                                    Container(
                                      width: constraints.maxWidth / 2,
                                      height: constraints.maxHeight / 2.5,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 2,
                                        ),
                                      ),
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment: Alignment.topCenter,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 25),
                                              child: SizedBox(
                                                height:
                                                    constraints.maxHeight / 4.5,
                                                width:
                                                    constraints.maxWidth / 2.3,
                                                child: Text(
                                                  _sErrorPeticion,
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      color: Color(0xFFb13636),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                      fontFamily: "Georgia"),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 10),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                child: Stack(
                                                  children: <Widget>[
                                                    Positioned.fill(
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                          color: Colors.black,
                                                          border: Border.all(
                                                              color:
                                                                  Colors.white,
                                                              width: 2),
                                                        ),
                                                      ),
                                                    ),
                                                    TextButton(
                                                      style:
                                                          TextButton.styleFrom(
                                                        foregroundColor:
                                                            Colors.white,
                                                        // padding: const EdgeInsets.all(16.0),
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 4,
                                                                bottom: 4,
                                                                left: 15,
                                                                right: 15),
                                                        textStyle:
                                                            const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 18,
                                                                fontFamily:
                                                                    "Georgia"),
                                                      ),
                                                      onPressed: () {
                                                        _errorPeticion = false;
                                                        setState(() {});
                                                      },
                                                      child:
                                                          const Text("ACEPTAR"),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                    _peticionEnviada
                        ? Container(
                            height: constraints.maxHeight,
                            width: constraints.maxWidth,
                            decoration:
                                const BoxDecoration(color: Color(0x80444444)),
                            margin: const EdgeInsets.only(top: 0),
                            child: Align(
                              alignment: Alignment.center,
                              child: Stack(
                                children: [
                                  Container(
                                    width: constraints.maxWidth / 2,
                                    height: constraints.maxHeight / 2.5,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 2,
                                      ),
                                    ),
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: Alignment.topCenter,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 30),
                                            child: SizedBox(
                                              height:
                                                  constraints.maxHeight / 4.5,
                                              width: constraints.maxWidth / 2.3,
                                              child: Text(
                                                "Invitación enviada a $_amigo",
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    color: Color(0xFF3dce00),
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                    fontFamily: "Georgia"),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 20),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              child: Stack(
                                                children: <Widget>[
                                                  Positioned.fill(
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                        color: Colors.black,
                                                        border: Border.all(
                                                            color: Colors.white,
                                                            width: 2),
                                                      ),
                                                    ),
                                                  ),
                                                  TextButton(
                                                    style: TextButton.styleFrom(
                                                      foregroundColor:
                                                          Colors.white,
                                                      // padding: const EdgeInsets.all(16.0),
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 4,
                                                              bottom: 4,
                                                              left: 15,
                                                              right: 15),
                                                      textStyle:
                                                          const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 18,
                                                              fontFamily:
                                                                  "Georgia"),
                                                    ),
                                                    onPressed: () {
                                                      _peticionEnviada = false;
                                                      setState(() {});
                                                    },
                                                    child:
                                                        const Text("ACEPTAR"),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                    _esperandoJugadores && _salirSala
                        ? Container(
                            height: constraints.maxHeight,
                            width: constraints.maxWidth,
                            decoration:
                                const BoxDecoration(color: Color(0xCF444444)),
                            margin: const EdgeInsets.only(top: 0),
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 140),
                                    child: SizedBox(
                                      height: constraints.maxHeight / 1.5,
                                      width: constraints.maxWidth / 1.5,
                                      child: const Text(
                                        "¿Deseas salir de la sala?",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 28.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontFamily: "Baskerville",
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 0, top: 160),
                                    child: Stack(
                                      children: [
                                        Boton1(
                                          "NO",
                                          onPressed: () {
                                            _salirSala = false;
                                            setState(() {});
                                          },
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 200),
                                          child: Boton1(
                                            "SI",
                                            onPressed: () {
                                              _socket.sink.close();
                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Menu(_s)),
                                                  (Route<dynamic> route) =>
                                                      false);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
