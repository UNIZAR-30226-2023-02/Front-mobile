// ignore: file_names
// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/API/rechazarAmigo.dart';
import 'package:flutter_application_1/Data_types/amigosUsuario.dart';
import 'package:flutter_application_1/Data_types/datosUsuario.dart';
import 'package:flutter_application_1/API/index.dart';
import 'package:flutter_application_1/Interfaz/Menu/Estilo/index.dart';
import 'package:flutter_application_1/Interfaz/Menu/index.dart';

import '../../../../Data_types/sesion.dart';
import '../../../Data_types/index.dart';
import '../home.dart';

//ignore: must_be_immutable
class Amigos extends StatefulWidget {
  Amigos(this._s, this._a, {Key? key}) : super(key: key);
  final Sesion _s;
  AmigosUsuario _a;

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _AmigosState createState() => _AmigosState(_s, _a);
}

class _AmigosState extends State<Amigos> {
  Sesion _s;
  late DatosUsuario _dA = DatosUsuario();
  AmigosUsuario _a;
  _AmigosState(this._s, this._a);
  List<String> _aP = <String>[];
  EstadisticasUsuario _eA =
      EstadisticasUsuario("", <String>[], <String>[], <String>[], <String>[]);

  String _sErrorAnadirAmigo = "", _sErrorEliminarAmigo = "";
  bool _errorAnadirAmigo = false, _errorEliminarAmigo = false;
  bool _amigoEliminado = false;
  bool _amigoAnadido = false;
  bool _datosAmigo = false;
  bool _estadisticasAmigo = false;
  bool _anadirAmigo = false;
  bool _verPeticiones = false,
      _solicitudEnviada = false,
      _errorSolicitud = false,
      _errorAceptarAmigo = false,
      _errorRechazarAmigo = false,
      _amigoAceptado = false;
  String _amigo = "",
      _sPeticiones = "0",
      _sErrorSolicitud = "",
      _sErrorAceptarAmigo = "",
      _sErrorRechazarAmigo = "";

  late Timer _timer;

  final TextEditingController _friendSearchController = TextEditingController();

  @override
  void initState() {
    _obtenerPeticionesAmistad();
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      _obtenerPeticionesAmistad();
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    _friendSearchController.dispose();
    super.dispose();
  }

  void conseguirDatosAmigo(int index) async {
    Future<DatosAmigoResponse> f =
        obtenerDatosAmigo(DatosAmigoPetition(_a.amigos[index]));
    DatosAmigoResponse r = await f;
    _dA.setField(DatosUsuarioFieldsCodes.usuario, r.username);
    _dA.setField(DatosUsuarioFieldsCodes.correoElectronico, r.correo);
    _dA.setField(DatosUsuarioFieldsCodes.telefonoMovil, r.telefono);
    _dA.setField(DatosUsuarioFieldsCodes.fechaNacimiento, r.fecha);
    _datosAmigo = true;
    setState(() {});
  }

  _enviarSolicitudAmistad() async {
    String amigo = _friendSearchController.text;
    if (amigo == "") {
      _errorSolicitud = true;
      _sErrorSolicitud = "El nombre de usuario está vacío.";
    } else {
      Future<AnadirAmigoResponse> f = anadirAmigo(
          AnadirAmigoPetition(_s.getField(SesionFieldsCodes.token), amigo));
      AnadirAmigoResponse r = await f;
      if (r.OK) {
        _solicitudEnviada = true;
      } else {
        _sErrorSolicitud = r.error;
        _errorSolicitud = true;
      }
    }
    setState(() {});
  }

  _aceptarSolicitud(int index) async {
    _amigo = _aP[index];
    Future<AceptarAmigoResponse> f = aceptarAmigo(
        AceptarAmigoPetition(_amigo), _s.getField(SesionFieldsCodes.token));
    AceptarAmigoResponse r = await f;
    if (r.OK) {
      _aP.remove(_amigo);
      _a.amigos.add(_amigo);
      _amigoAceptado = true;
      if (_aP.length < 100) {
        _sPeticiones = "${_aP.length}";
      } else {
        _sPeticiones = "+99";
      }
    } else {
      _errorAceptarAmigo = true;
      _sErrorAceptarAmigo = r.error;
    }
    setState(() {});
  }

  _rechazarSolicitud(int index) async {
    String amigo = _aP[index];
    Future<RechazarAmigoResponse> f = rechazarAmigo(
        RechazarAmigoPetition(amigo), _s.getField(SesionFieldsCodes.token));
    RechazarAmigoResponse r = await f;
    if (r.OK) {
      _aP.remove(amigo);
      if (_aP.length < 100) {
        _sPeticiones = "${_aP.length}";
      } else {
        _sPeticiones = "+99";
      }
    } else {
      _errorRechazarAmigo = true;
      _sErrorRechazarAmigo = r.error;
    }
    setState(() {});
  }

  _obtenerAmigos() async {
    Future<DatosUsuarioResponse> f = obtenerDatosUsuario(
        DatosUsuarioPetition(_s.getField(SesionFieldsCodes.token)));
    DatosUsuarioResponse r = await f;
    if (r.OK) {
      _a = AmigosUsuario(r.amigos);
    }
  }

  _obtenerPeticionesAmistad() async {
    _obtenerAmigos();
    Future<ObtenerPeticionesResponse> f = obtenerPeticionesAmistad(
        ObtenerPeticionesPetition(), _s.getField(SesionFieldsCodes.token));
    ObtenerPeticionesResponse r = await f;
    if (r.OK) {
      _aP = r.peticiones;
      if (_aP.length < 100) {
        _sPeticiones = "${_aP.length}";
      } else {
        _sPeticiones = "+99";
      }
    }
    setState(() {});
  }

  eliminarAmigoUsuario() async {
    String amigo = _dA.getField(DatosUsuarioFieldsCodes.usuario);

    Future<EliminarAmigoResponse> f = eliminarAmigo(
        EliminarAmigoPetition(_s.getField(SesionFieldsCodes.token), amigo));
    EliminarAmigoResponse r = await f;
    if (r.OK) {
      _a.amigos.remove(amigo);
      _amigoEliminado = true;
      _datosAmigo = false;
    } else {
      _sErrorEliminarAmigo = r.error;
      _errorEliminarAmigo = true;
    }
    setState(() {});
  }

  verEstadisticasAmigo(int index) async {
    _amigo = _a.amigos[index];
    _estadisticasAmigo = true;
    Future<EstadisticasAmigoResponse> f =
        obtenerEstadisticasAmigo(EstadisticasAmigoPetition(_amigo));
    EstadisticasAmigoResponse r = await f;
    if (r.OK) {
      _eA = EstadisticasUsuario(
          r.quesitos, r.preguntas, r.incorrectas, r.correctas, r.aciertos);
      // ignore: use_build_context_synchronously
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_verPeticiones) {
          if (_amigoAceptado) {
            _amigoAceptado = false;
          } else if (_errorAceptarAmigo) {
            _errorAceptarAmigo = true;
          } else if (_errorRechazarAmigo) {
            _errorRechazarAmigo = true;
          } else {
            _verPeticiones = false;
          }
          setState(() {});
        } else if (_anadirAmigo) {
          if (_solicitudEnviada) {
            _solicitudEnviada = false;
            _friendSearchController.text = "";
          } else if (_errorSolicitud) {
            _errorSolicitud = false;
          } else {
            _anadirAmigo = false;
          }
          setState(() {});
        } else if (_datosAmigo) {
          if (_amigoEliminado) {
            _amigoEliminado = false;
            _datosAmigo = false;
          } else if (_errorEliminarAmigo) {
            _errorEliminarAmigo = false;
          } else {
            _datosAmigo = false;
          }
          setState(() {});
        } else if (_estadisticasAmigo) {
          _estadisticasAmigo = false;
          setState(() {});
        } else {
          if (_amigoEliminado) {
            _amigoEliminado = false;

            setState(() {});
          } else {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Menu(_s)),
                (Route<dynamic> route) => false);
          }
        }
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        // body: SingleChildScrollView (  //SOLUCION FONDO DE PANTALLA SE ESTRECHA AL SACAR TECLADO
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/tapete.png'),
              fit: BoxFit.fill,
              // contentMode = .ScaleAspectFill,
              // alignment: Alignment.topCenter,
            ),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  alignment: Alignment.topCenter,
                  child: const Text(
                    "Amigos",
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFc9c154),
                      fontFamily: "Baskerville",
                    ),
                  ),
                ),
              ),
              LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return Stack(
                    children: [
                      Stack(
                        children: [
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: constraints.maxWidth / 5,
                                  bottom: constraints.maxHeight / 10),
                              child: Boton1("MENU", onPressed: () {
                                Navigator.of(context, rootNavigator: true)
                                    .pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) => Menu(_s)),
                                        (Route<dynamic> route) => false);
                              }),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  right: constraints.maxWidth / 9,
                                  bottom: constraints.maxHeight / 10),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 300),
                                child: Boton1(
                                  "AÑADIR AMIGO",
                                  onPressed: () {
                                    _anadirAmigo = true;
                                    _friendSearchController.text = "";
                                    setState(() {});
                                  },
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 40),
                          child: Stack(
                            children: [
                              GestureDetector(
                                behavior: HitTestBehavior.deferToChild,
                                onTap: () {
                                  _verPeticiones = true;
                                  setState(() {});
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 50.0),
                                  child: Container(
                                    width: constraints.maxWidth / 8,
                                    height: constraints.maxHeight / 8,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: const Color(0xFF164966),
                                      border: Border.all(
                                          color: Colors.white, width: 2),
                                    ),
                                    child: const Icon(
                                      Icons.person_add,
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
                                    height: constraints.maxHeight / 12,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: const Color(0xFF164966),
                                      border: Border.all(
                                          color: Colors.white, width: 2),
                                    ),
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5.0),
                                        child: Text(
                                          _sPeticiones,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.white),
                                        )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Text(
                            "Solicitudes Amistad",
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
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 60),
                          child: Stack(
                            children: [
                              Container(
                                width: constraints.maxWidth / 1.3,
                                height: constraints.maxHeight / 1.8,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: const Color(0xFFc9c154),
                                    width: 10,
                                  ),
                                ),
                                child: ListView.separated(
                                  padding:
                                      const EdgeInsets.only(top: 5, bottom: 5),
                                  itemCount: _a.amigos.length,
                                  separatorBuilder: (context, index) =>
                                      const Divider(
                                    color: Colors.grey,
                                    thickness: 1.5,
                                  ),
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      leading: IconButton(
                                        icon: const Icon(
                                          Icons.person,
                                          color: Colors.black,
                                          size: 40,
                                        ),
                                        onPressed: () async {
                                          conseguirDatosAmigo(index);
                                        },
                                      ),
                                      title: Text(_a.amigos[index]),
                                      trailing: IconButton(
                                        icon: const Icon(
                                          Icons.analytics,
                                          color: Colors.black,
                                          size: 40,
                                        ),
                                        onPressed: () async {
                                          verEstadisticasAmigo(index);
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      _anadirAmigo
                          ? Container(
                              height: constraints.maxHeight,
                              width: constraints.maxWidth,
                              decoration:
                                  const BoxDecoration(color: Color(0x80444444)),
                              margin: const EdgeInsets.only(top: 0),
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 65),
                                      child: Container(
                                        width: constraints.maxWidth / 1.55,
                                        height: constraints.maxHeight / 1.8,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF164966),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 2,
                                          ),
                                        ),
                                        child: Stack(
                                          children: [
                                            Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 30),
                                                child: Boton1(
                                                  "ENVIAR SOLICITUD DE AMISTAD",
                                                  onPressed: () {
                                                    _enviarSolicitudAmistad();
                                                  },
                                                ),
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
                                                    _anadirAmigo = false;
                                                    setState(() {});
                                                  }),
                                            ),
                                            Align(
                                              alignment: Alignment.topCenter,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 50),
                                                child: Container(
                                                  height: 50,
                                                  width: 370,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    border: Border.all(
                                                      color: Colors.white,
                                                      width: 2,
                                                    ),
                                                  ),
                                                  child: TextFormField(
                                                    controller:
                                                        _friendSearchController,
                                                    keyboardType: TextInputType
                                                        .visiblePassword,
                                                    decoration:
                                                        const InputDecoration(
                                                      border: InputBorder.none,
                                                      hintText:
                                                          'Introduzca el nombre del usuario a añadir',
                                                      hintStyle: TextStyle(
                                                          fontFamily:
                                                              "Baskerville",
                                                          fontSize: 16.0,
                                                          color: Colors.white),
                                                    ),
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                      _errorSolicitud
                          ? Container(
                              height: constraints.maxHeight,
                              width: constraints.maxWidth,
                              decoration:
                                  const BoxDecoration(color: Color(0x80444444)),
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
                                          borderRadius:
                                              BorderRadius.circular(20),
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
                                                      constraints.maxHeight /
                                                          4.5,
                                                  width: constraints.maxWidth /
                                                      2.3,
                                                  child: Text(
                                                    _sErrorSolicitud,
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xFFb13636),
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
                                                                    .circular(
                                                                        30),
                                                            color: Colors.black,
                                                            border: Border.all(
                                                                color: Colors
                                                                    .white,
                                                                width: 2),
                                                          ),
                                                        ),
                                                      ),
                                                      TextButton(
                                                        style: TextButton
                                                            .styleFrom(
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
                                                          _errorSolicitud =
                                                              false;
                                                          setState(() {});
                                                        },
                                                        child: const Text(
                                                            "ACEPTAR"),
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
                      _datosAmigo
                          ? Container(
                              height: constraints.maxHeight,
                              width: constraints.maxWidth,
                              decoration:
                                  const BoxDecoration(color: Color(0x80444444)),
                              margin: const EdgeInsets.only(top: 0),
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 30),
                                      child: Container(
                                        width: constraints.maxWidth / 1.75,
                                        height: constraints.maxHeight / 1.2,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF164966),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 2,
                                          ),
                                        ),
                                        child: Stack(
                                          children: [
                                            Align(
                                              alignment: Alignment.topCenter,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      width:
                                                          constraints.maxWidth /
                                                              2,
                                                      child: Text(
                                                        "Datos de ${_dA.getField(DatosUsuarioFieldsCodes.usuario)}",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white,
                                                            fontSize: 18,
                                                            fontFamily:
                                                                "Georgia"),
                                                      ),
                                                    ),
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 5),
                                                      child: Divider(
                                                        color: Colors.white,
                                                        thickness: 1.5,
                                                      ),
                                                    ),
                                                  ],
                                                ),
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
                                                    _datosAmigo = false;
                                                    setState(() {});
                                                  }),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 60),
                                              child: SizedBox(
                                                height:
                                                    constraints.maxHeight / 2.3,
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 0,
                                                                left: 30),
                                                        child:
                                                            ContainerDatosRegistro(
                                                          "Correo electrónico: ",
                                                          _dA.getField(
                                                              DatosUsuarioFieldsCodes
                                                                  .correoElectronico),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 30,
                                                                top: 40),
                                                        child:
                                                            ContainerDatosRegistro(
                                                          "Fecha de nacimiento :",
                                                          _dA.getField(
                                                              DatosUsuarioFieldsCodes
                                                                  .fechaNacimiento),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 30,
                                                                top: 40),
                                                        child:
                                                            ContainerDatosRegistro(
                                                          "Número de teléfono :",
                                                          _dA.getField(
                                                              DatosUsuarioFieldsCodes
                                                                  .telefonoMovil),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const Padding(
                                              padding:
                                                  EdgeInsets.only(top: 225),
                                              child: Divider(
                                                color: Colors.white,
                                                thickness: 1.5,
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 7),
                                                child: Boton1(
                                                  "ELIMINAR DE AMIGOS",
                                                  onPressed: () {
                                                    eliminarAmigoUsuario();
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                      _estadisticasAmigo
                          ? Container(
                              height: constraints.maxHeight,
                              width: constraints.maxWidth,
                              decoration:
                                  const BoxDecoration(color: Color(0x80444444)),
                              margin: const EdgeInsets.only(top: 0),
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 30),
                                      child: Container(
                                        width: constraints.maxWidth / 1.5,
                                        height: constraints.maxHeight / 1.2,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF164966),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 2,
                                          ),
                                        ),
                                        child: Stack(
                                          children: [
                                            Align(
                                              alignment: Alignment.topCenter,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      width:
                                                          constraints.maxWidth /
                                                              2,
                                                      child: Text(
                                                        "Estadisticas de $_amigo",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white,
                                                            fontSize: 18,
                                                            fontFamily:
                                                                "Georgia"),
                                                      ),
                                                    ),
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 5),
                                                      child: Divider(
                                                        color: Colors.white,
                                                        thickness: 1.5,
                                                      ),
                                                    ),
                                                  ],
                                                ),
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
                                                    _estadisticasAmigo = false;
                                                    setState(() {});
                                                  }),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 55),
                                              child: SizedBox(
                                                  width: constraints.maxWidth /
                                                      1.5,
                                                  child:
                                                      EstadisticasAmigos(_eA)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                      _errorEliminarAmigo
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
                                              padding: const EdgeInsets.only(
                                                  top: 30),
                                              child: SizedBox(
                                                height:
                                                    constraints.maxHeight / 4.5,
                                                width:
                                                    constraints.maxWidth / 2.3,
                                                child: Text(
                                                  _sErrorEliminarAmigo,
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
                                                  bottom: 20),
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
                                                        _errorEliminarAmigo =
                                                            false;
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
                      _solicitudEnviada
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
                                              padding: const EdgeInsets.only(
                                                  top: 30),
                                              child: SizedBox(
                                                height:
                                                    constraints.maxHeight / 4.5,
                                                width:
                                                    constraints.maxWidth / 2.3,
                                                child: Text(
                                                  "Se ha enviado una solicitud a ${_friendSearchController.text}",
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      color: Color(0xFF3dce00),
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
                                                        _friendSearchController
                                                            .text = "";
                                                        _solicitudEnviada =
                                                            false;
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
                      _amigoEliminado
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
                                              padding: const EdgeInsets.only(
                                                  top: 30),
                                              child: SizedBox(
                                                height:
                                                    constraints.maxHeight / 4.5,
                                                width:
                                                    constraints.maxWidth / 2.3,
                                                child: Text(
                                                  "${_dA.getField(DatosUsuarioFieldsCodes.usuario)} ya no es tu amigo",
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      color: Color(0xFF3dce00),
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
                                                  bottom: 20),
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
                                                        _amigoEliminado = false;
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
                      _verPeticiones
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
                                                  itemCount: _aP.length,
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
                                                              title: Text(
                                                                  _aP[index])),
                                                          Align(
                                                            alignment: Alignment
                                                                .centerRight,
                                                            child: Padding(
                                                              padding: EdgeInsets.only(
                                                                  top: 5,
                                                                  bottom: 5,
                                                                  right: constraints
                                                                          .maxWidth /
                                                                      6),
                                                              child: Boton1(
                                                                "Rechazar",
                                                                onPressed: () {
                                                                  _rechazarSolicitud(
                                                                      index);
                                                                },
                                                              ),
                                                            ),
                                                          ),
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
                                                                  _aceptarSolicitud(
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
                                                _verPeticiones = false;
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
                      _errorAceptarAmigo
                          ? Container(
                              height: constraints.maxHeight,
                              width: constraints.maxWidth,
                              decoration:
                                  const BoxDecoration(color: Color(0x80444444)),
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
                                          borderRadius:
                                              BorderRadius.circular(20),
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
                                                      constraints.maxHeight /
                                                          4.5,
                                                  width: constraints.maxWidth /
                                                      2.3,
                                                  child: Text(
                                                    _sErrorAceptarAmigo,
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xFFb13636),
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
                                                                    .circular(
                                                                        30),
                                                            color: Colors.black,
                                                            border: Border.all(
                                                                color: Colors
                                                                    .white,
                                                                width: 2),
                                                          ),
                                                        ),
                                                      ),
                                                      TextButton(
                                                        style: TextButton
                                                            .styleFrom(
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
                                                          _errorAceptarAmigo =
                                                              false;
                                                          setState(() {});
                                                        },
                                                        child: const Text(
                                                            "ACEPTAR"),
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
                      _errorRechazarAmigo
                          ? Container(
                              height: constraints.maxHeight,
                              width: constraints.maxWidth,
                              decoration:
                                  const BoxDecoration(color: Color(0x80444444)),
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
                                          borderRadius:
                                              BorderRadius.circular(20),
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
                                                      constraints.maxHeight /
                                                          4.5,
                                                  width: constraints.maxWidth /
                                                      2.3,
                                                  child: Text(
                                                    _sErrorRechazarAmigo,
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xFFb13636),
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
                                                                    .circular(
                                                                        30),
                                                            color: Colors.black,
                                                            border: Border.all(
                                                                color: Colors
                                                                    .white,
                                                                width: 2),
                                                          ),
                                                        ),
                                                      ),
                                                      TextButton(
                                                        style: TextButton
                                                            .styleFrom(
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
                                                          _errorRechazarAmigo =
                                                              false;
                                                          setState(() {});
                                                        },
                                                        child: const Text(
                                                            "ACEPTAR"),
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
                      _amigoAceptado
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
                                              padding: const EdgeInsets.only(
                                                  top: 30),
                                              child: SizedBox(
                                                height:
                                                    constraints.maxHeight / 4.5,
                                                width:
                                                    constraints.maxWidth / 2.3,
                                                child: Text(
                                                  "$_amigo y tú ahora sois amigos",
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      color: Color(0xFF3dce00),
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
                                                  bottom: 20),
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
                                                        _amigoAceptado = false;
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
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
