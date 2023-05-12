// ignore: file_names
// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Interfaz/Menu/index.dart';
import 'package:flutter_application_1/Interfaz/Menu/Estilo/index.dart';

import '../../../../Data_types/index.dart';

import '../../../../API/index.dart';

//ignore: must_be_immutable
class Partidas extends StatefulWidget {
  Partidas(this._s);
  final Sesion _s;
  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _PartidasState createState() => _PartidasState(_s);
}

class _PartidasState extends State<Partidas> {
  _PartidasState(this._s);
  final Sesion _s;
  List<DatosSalaPartida> _sP = <DatosSalaPartida>[];
  List<InvitacionPartida> _i = <InvitacionPartida>[];
  int contador = 0;
  String _sInvitaciones = "0";
  bool _verInvitaciones = false;

  late Timer _timer;

  _obtenerSalasPartidas(BuildContext context) async {
    Future<ObtenerSalasResponse> f = obtenerSalas(
        ObtenerSalasPetition(), _s.getField(SesionFieldsCodes.token));
    ObtenerSalasResponse r = await f;
    if (r.OK) {
      _sP = r.salas;
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BuscarPartida(_s, _sP)),
      );
    }
  }

  Future<void> _obtenerInvitacionesPartidas() async {
    Stopwatch stopwatch = Stopwatch()..start();
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
      setState(() {});
    }
    stopwatch.stop();
    print('Time elapsed: ${stopwatch.elapsed.inMilliseconds}');
  }

  @override
  void initState() {
    _obtenerInvitacionesPartidas();
    _timer = Timer.periodic(const Duration(milliseconds: 2000), (timer) {
      _obtenerInvitacionesPartidas();
    });
    super.initState();
  }

  @override
  void dispose() {
    print("dispose");
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
            builder: (BuildContext context, BoxConstraints constraints) {
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
                          padding: const EdgeInsets.only(bottom: 50),
                          child: Boton1(
                            "MENU",
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Menu(_s)),
                (Route<dynamic> route) => false);
                            },
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 60),
                          child: SizedBox(
                            width: constraints.maxWidth / 1.1,
                            height: constraints.maxHeight / 1.7,
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 0),
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
                                    padding: EdgeInsets.only(top: 10),
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
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Stack(
                                        children: [
                                          SizedBox(
                                            width: constraints.maxWidth / 1.7,
                                            height: constraints.maxHeight / 1.8,
                                            child: ListView.separated(
                                              padding: const EdgeInsets.only(
                                                  top: 5, bottom: 5),
                                              itemCount: _i.length,
                                              separatorBuilder:
                                                  (context, index) =>
                                                      const Divider(
                                                color: Colors.grey,
                                                thickness: 1.5,
                                              ),
                                              itemBuilder: (context, index) {
                                                return ListTile(
                                                  title: Text(_i[index].getField(
                                                      InvitacionPartidaFieldsCodes
                                                          .nombreSala)),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
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
