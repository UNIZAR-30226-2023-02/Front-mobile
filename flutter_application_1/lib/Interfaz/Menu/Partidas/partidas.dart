// ignore: file_names
// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Interfaz/Juego/salaEspera.dart';
import 'package:flutter_application_1/Interfaz/Menu/index.dart';
import 'package:flutter_application_1/Interfaz/Menu/Estilo/index.dart';

import '../../../../Data_types/index.dart';

import '../../../../API/index.dart';
import '../../Juego/juego_copia.dart';

//ignore: must_be_immutable
class Partidas extends StatefulWidget {
  const Partidas(this._s, {Key? key}) : super(key: key);
  final Sesion _s;
  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _PartidasState createState() => _PartidasState(_s);
}

class _PartidasState extends State<Partidas> {
  _PartidasState(this._s);
  final Sesion _s;

  List<InvitacionPartida> _i = <InvitacionPartida>[];
  int contador = 0;
  String _sInvitaciones = "0", _webSocket = "", _tipoPartida = "";
  bool _verInvitaciones = false, _partidaActiva = false;

  late Timer _timer;

  _obtenerSalasPartidas(BuildContext context) async {
    Future<ObtenerSalasResponse> f = obtenerSalas(
        ObtenerSalasPetition(), _s.getField(SesionFieldsCodes.token));
    ObtenerSalasResponse r = await f;
    if (r.OK) {
      List<DatosSalaPartida> _sP = r.salas;
      List<String> _sN = r.nombreSalas;
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BuscarPartida(_s, _sP, _sN)),
      );
    }
  }

  _obtenerInvitacionesPartidas() async {
    _mirarPartidaActiva();
    Future<ObtenerInvitacionesResponse> f = obtenerInvitaciones(
        ObtenerInvitacionesPetition(), _s.getField(SesionFieldsCodes.token));
    ObtenerInvitacionesResponse r = await f;
    if (r.OK) {
      _i = r.invitaciones;
      if (_i.length < 100) {
        _sInvitaciones = "${_i.length}";
      } else {
        _sInvitaciones = "+99";
      }
    }
    setState(() {});
  }

  _mirarPartidaActiva() async {
    Future<PartidaActivaResponse> f = partidaActiva(
        PartidaActivaPetition(), _s.getField(SesionFieldsCodes.token));
    PartidaActivaResponse r = await f;
    if (r.OK) {
      _partidaActiva = true;
      _webSocket = r.ws;
      _tipoPartida = r.tipo;

    } else {
      _partidaActiva = false;
    }
  }

  _unirseSalaActiva() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => Juego(_s, '$wsDir$_webSocket?username=${_s.getField(SesionFieldsCodes.usuario)}', _tipoPartida)),
        (Route<dynamic> route) => false);
  }

  _aceptarPeticion(int index) {
    InvitacionPartida i = _i[index];
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => SalaEspera(
                _s,
                '$wsDir${i.getField(InvitacionPartidaFieldsCodes.webSocket)}',
                i.getField(InvitacionPartidaFieldsCodes.tipoPartida))),
        (Route<dynamic> route) => false);
  }

  @override
  void initState() {
    _obtenerInvitacionesPartidas();
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      _obtenerInvitacionesPartidas();
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WillPopScope(
        onWillPop: () async {
          if (_verInvitaciones) {
            _verInvitaciones = false;
            setState(() {});
          } else {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Menu(_s)),
                (Route<dynamic> route) => false);
          }
          return false;
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          // body: SingleChildScrollView (  //SOLUCION FONDO DE PANTALLA SE ESTRECHA AL SACAR TECLADO
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
                child: Align(
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 40),
                          child: ClipRRect(
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
                                        colors: <Color>[
                                          Color(0xFFdee8eb),
                                          Color(0xFFb0c7d0)
                                        ],
                                        stops: [0.4, 1.0],
                                      ),
                                    ),
                                  ),
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    foregroundColor: const Color(0xFF004461),
                                    // padding: const EdgeInsets.all(16.0),
                                    padding: const EdgeInsets.only(
                                        top: 4, bottom: 4, left: 15, right: 15),
                                    textStyle: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        fontFamily: "Georgia"),
                                  ),
                                  onPressed: () async {
                                    Navigator.of(context, rootNavigator: true)
                                        .pushAndRemoveUntil(
                                            MaterialPageRoute(
                                                builder: (context) => Menu(_s)),
                                            (Route<dynamic> route) => false);
                                  },
                                  child: const Text("MENU"),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 70),
                          child: SizedBox(
                            width: constraints.maxWidth / 1.1,
                            height: constraints.maxHeight / 1.7,
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Stack(
                                      children: [
                                        GestureDetector(
                                          behavior:
                                              HitTestBehavior.deferToChild,
                                          onTap: () {
                                            _verInvitaciones = true;
                                            setState(() {});
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 50.0),
                                            child: Container(
                                              width: constraints.maxWidth / 8,
                                              height: constraints.maxHeight / 8,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: const Color(0xFF164966),
                                                border: Border.all(
                                                    color: Colors.white,
                                                    width: 2),
                                              ),
                                              child: const Icon(
                                                Icons.mail,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        IgnorePointer(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 38.0, left: 35.0),
                                            child: Container(
                                              width: constraints.maxWidth / 12,
                                              height:
                                                  constraints.maxHeight / 12,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: const Color(0xFF164966),
                                                border: Border.all(
                                                    color: Colors.white,
                                                    width: 2),
                                              ),
                                              child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 5.0),
                                                  child: Text(
                                                    _sInvitaciones,
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  )),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 40),
                                    child: Text(
                                      "Invitaciones",
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontFamily: "Baskerville",
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 20, left: 40),
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.deferToChild,
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CrearPartida(_s)),
                                        );
                                      },
                                      child: Container(
                                        width: constraints.maxWidth / 3.2,
                                        height: constraints.maxHeight / 3.2,
                                        decoration: BoxDecoration(
                                          image: const DecorationImage(
                                            image: AssetImage('assets/mas.png'),
                                            fit: BoxFit.scaleDown,
                                          ),
                                          shape: BoxShape.circle,
                                          color: const Color(0xFF164966),
                                          border: Border.all(
                                              color: Colors.white, width: 2),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(top: 160, left: 80),
                                    child: Text(
                                      "CREAR PARTIDA",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontFamily: "Baskerville",
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 20, right: 40),
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.deferToChild,
                                      onTap: () async {
                                        _obtenerSalasPartidas(context);
                                      },
                                      child: Container(
                                        width: constraints.maxWidth / 3.2,
                                        height: constraints.maxHeight / 3.2,
                                        decoration: BoxDecoration(
                                          image: const DecorationImage(
                                            image:
                                                AssetImage('assets/lupa.png'),
                                            fit: BoxFit.scaleDown,
                                          ),
                                          shape: BoxShape.circle,
                                          color: const Color(0xFF164966),
                                          border: Border.all(
                                              color: Colors.white, width: 2),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(top: 160, right: 50),
                                    child: Text(
                                      "BUSCAR PARTIDAS",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontFamily: "Baskerville",
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      _partidaActiva
                          ? Align(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 25),
                                child: Container(
                                    height: constraints.maxHeight / 6,
                                    width: constraints.maxWidth / 2,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.white),
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.transparent),
                                    child: Stack(
                                      children: [
                                        const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 20),
                                            child: Text(
                                              "Tienes una partida activa",
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontFamily: "Baskerville",
                                              ),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 20),
                                            child: GestureDetector(
                                              onTap: () {
                                                _unirseSalaActiva();
                                              },
                                              child: Container(
                                                height:
                                                    constraints.maxHeight / 10,
                                                width: constraints.maxWidth / 8,
                                                decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xFF164966),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    border: Border.all(
                                                        color: Colors.white)),
                                                child: const Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    "Unirse",
                                                    style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                      fontFamily: "Baskerville",
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            )
                          : const SizedBox.shrink(),
                      _verInvitaciones
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
                                                width:
                                                    constraints.maxWidth / 1.7,
                                                height:
                                                    constraints.maxHeight / 1.8,
                                                child: ListView.separated(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5, bottom: 5),
                                                  itemCount: _i.length,
                                                  separatorBuilder:
                                                      (context, index) =>
                                                          const Divider(
                                                    color: Colors.transparent,
                                                    thickness: 1.5,
                                                  ),
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Container(
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          border: Border.all(
                                                              color:
                                                                  Colors.white),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20)),
                                                      child: Stack(
                                                        children: [
                                                          ListTile(
                                                              title: Text(_i[
                                                                      index]
                                                                  .getField(
                                                                      InvitacionPartidaFieldsCodes
                                                                          .nombreSala))),
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
                                                                "Aceptar",
                                                                onPressed: () {
                                                                  _aceptarPeticion(
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
                                                _verInvitaciones = false;
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
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
