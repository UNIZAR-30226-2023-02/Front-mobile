// ignore: file_names
// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Data_types/index.dart';
import 'package:flutter_application_1/API/index.dart';
import 'package:flutter_application_1/Interfaz/Juego/juego.dart';
import 'package:flutter_application_1/Interfaz/Juego/salaEspera.dart';
import 'package:flutter_application_1/Interfaz/Menu/Estilo/index.dart';

import '../../Juego/juego_copia.dart';
import '../home.dart';

//ignore: must_be_immutable
class BuscarPartida extends StatefulWidget {
  BuscarPartida(this._s, this._sP, this._sN, {Key? key}) : super(key: key);
  final Sesion _s;
  // ignore: non_constant_identifier_names
  List<DatosSalaPartida> _sP;
  List<String> _sN;

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _BuscarPartidaState createState() => _BuscarPartidaState(_s, _sP, _sN);
}

class _BuscarPartidaState extends State<BuscarPartida>
    with WidgetsBindingObserver {
  final _formKey = GlobalKey<FormState>();
  late Timer _timer;
  final Sesion _s;
  List<DatosSalaPartida> _sP;
  List<String> _sN;
  late List<String> _sF = <String>[];
  _BuscarPartidaState(this._s, this._sP, this._sN);

  bool _teclado = false, _datosSala = false, _errorUnirse = false;

  final TextEditingController _gameSearchController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late ValueNotifier _cambios;
  final FocusNode _focusNode = FocusNode(), _focusNode2 = FocusNode();

  String _filtro = "", _sErrorUnirse = "";
  DatosSalaPartida _sala = DatosSalaPartida();

  @override
  void initState() {
    _filtrarSalas();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _buscarSalas();
    });
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _teclado = false;
        _focusNode.unfocus();
        setState(() {});
      }
    });

    _cambios = ValueNotifier<String>(_gameSearchController.text);
    _cambios.addListener(() {
      _filtro = _cambios.value;
      _filtrarSalas();
      setState(() {});
    });

    _gameSearchController.addListener(() {
      _cambios.value = _gameSearchController.text;
    });
    super.initState();
  }

  @override
  void dispose() {
    _gameSearchController.dispose();
    _passwordController.dispose();
    _focusNode2.dispose();
    _focusNode.dispose();
    _cambios.dispose();
    _timer.cancel();
    super.dispose();
  }

  _mostrarDatosSala(String sala) {
    _sala = _sP.firstWhere(
        (element) =>
            element.getField(DatosSalaPartidaFieldsCodes.nombre) == sala,
        orElse: () => DatosSalaPartida());
    if (_sala.getField(DatosSalaPartidaFieldsCodes.nombre) != "") {
      _datosSala = true;
      setState(() {});
    }
  }

  _filtrarSalas() {
    _sF = _sN.where((element) => element.contains(_filtro)).toList();
  }

  _buscarSalas() async {
    Future<ObtenerSalasResponse> f = obtenerSalas(
        ObtenerSalasPetition(), _s.getField(SesionFieldsCodes.token));
    ObtenerSalasResponse r = await f;
    if (r.OK) {
      _sP = r.salas;
      _sN = r.nombreSalas;
      _filtrarSalas();
      setState(() {});
    }
  }

  _unirseSala() async {
    String contrasena = "";
    if (_sala.getField(DatosSalaPartidaFieldsCodes.tipoSala) == "Privado") {
      contrasena = _passwordController.text;
    }
    Future<ValidarSalaResponse> f = validarSalaPartida(
        ValidarSalaPetition(
            _sala.getField(DatosSalaPartidaFieldsCodes.nombre), contrasena),
        _s.getField(SesionFieldsCodes.token));
    ValidarSalaResponse r = await f;
    if (r.OK) {
      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => SalaEspera(_s, '$wsDir${r.ws}',
                  _sala.getField(DatosSalaPartidaFieldsCodes.tipoPartida))),
          (Route<dynamic> route) => false);
    } else {
      _sErrorUnirse = r.errorSala;
      _errorUnirse = true;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_errorUnirse) {
          _errorUnirse = false;
          setState(() {});
        } else if (_datosSala) {
          _datosSala = false;
          _passwordController.text = "";
          setState(() {});
        } else {
          Navigator.pop(context);
        }
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/tapete.png'),
              fit: BoxFit.fill,
              // contentMode = .ScaleAspectFill,
              // alignment: Alignment.topCenter,
            ),
          ),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Form(
                key: _formKey,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: _teclado
                          ? Align(
                              alignment: Alignment.topCenter,
                              child: SizedBox(
                                width: constraints.maxWidth / 4,
                                height: constraints.maxHeight / 9,
                                child: TextFormField(
                                  controller: _gameSearchController,
                                  focusNode: _focusNode,
                                  keyboardType: TextInputType.visiblePassword,
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                  ),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                          : Container(
                              alignment: Alignment.topCenter,
                              padding: const EdgeInsets.only(top: 10),
                              child: const Text(
                                "Buscar Partidas",
                                style: TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFc9c154),
                                  fontFamily: "Baskerville",
                                ),
                              ),
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30, left: 500),
                      child: GestureDetector(
                        onTap: () {
                          _teclado = true;
                          _focusNode.requestFocus();
                          setState(() {});
                        },
                        behavior: HitTestBehavior.deferToChild,
                        child: Container(
                          width: constraints.maxWidth / 14,
                          height: constraints.maxHeight / 14,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/lupa.png'),
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 30, left: 50),
                        child: Boton1(
                          "VOLVER",
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                    Stack(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 70),
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
                                    padding: const EdgeInsets.only(
                                        top: 5, bottom: 5),
                                    itemCount: _sF.length,
                                    separatorBuilder: (context, index) =>
                                        const Divider(
                                      color: Colors.grey,
                                      thickness: 1.5,
                                    ),
                                    itemBuilder: (context, index) {
                                      String nombresala = _sF[index];
                                      return ListTile(
                                        title: Text("Sala:\t $nombresala"),
                                        onTap: () {
                                          _mostrarDatosSala(nombresala);
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    _datosSala
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
                                        borderRadius: BorderRadius.circular(20),
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
                                                      (_sala.getField(
                                                                  DatosSalaPartidaFieldsCodes
                                                                      .tipoSala) ==
                                                              "Publico")
                                                          ? "Sala Publica: ${_sala.getField(DatosSalaPartidaFieldsCodes.nombre)}"
                                                          : "Sala Privada: ${_sala.getField(DatosSalaPartidaFieldsCodes.nombre)}",
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
                                                    padding:
                                                        EdgeInsets.only(top: 5),
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
                                                  _passwordController.text = "";
                                                  _datosSala = false;
                                                  setState(() {});
                                                }),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(top: 100),
                                            child: Divider(
                                              color: Colors.white,
                                              thickness: 1.5,
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topCenter,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                top: 50,
                                              ),
                                              child: Stack(
                                                children: [
                                                  (_sala.getField(
                                                              DatosSalaPartidaFieldsCodes
                                                                  .tipoSala) ==
                                                          "Publico")
                                                      ? const SizedBox.shrink()
                                                      : Container(
                                                          height: 45,
                                                          width: 200,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                              color:
                                                                  Colors.white,
                                                              width: 2,
                                                            ),
                                                            color: Colors.white
                                                                .withOpacity(0),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                          ),
                                                          child: TextFormField(
                                                            controller:
                                                                _passwordController,
                                                            keyboardType:
                                                                TextInputType
                                                                    .visiblePassword,
                                                            focusNode:
                                                                _focusNode2,
                                                            decoration:
                                                                const InputDecoration(
                                                              hintText:
                                                                  "<Contraseña sala>",
                                                              hintStyle: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                            ),
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                  Padding(
                                                    padding: (_sala.getField(
                                                                DatosSalaPartidaFieldsCodes
                                                                    .tipoSala) ==
                                                            "Publico")
                                                        ? const EdgeInsets.only(
                                                            top: 0,
                                                          )
                                                        : const EdgeInsets.only(
                                                            top: 0, left: 220),
                                                    child: Boton1(
                                                      "Unirse a la sala",
                                                      onPressed: () {
                                                        _focusNode2.unfocus();
                                                        _unirseSala();
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 120),
                                            child: SizedBox(
                                              height:
                                                  constraints.maxHeight / 2.3,
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 0, left: 30),
                                                      child:
                                                          ContainerDatosRegistro(
                                                        "Modo de juego: ",
                                                        _sala.getField(
                                                            DatosSalaPartidaFieldsCodes
                                                                .tipoPartida),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 40,
                                                              left: 30),
                                                      child:
                                                          ContainerDatosRegistro(
                                                        "Creador: ",
                                                        _sala.getField(
                                                            DatosSalaPartidaFieldsCodes
                                                                .creador),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 30,
                                                              top: 40),
                                                      child:
                                                          ContainerDatosRegistro(
                                                        "Número de jugadores :",
                                                        _sala.getField(
                                                            DatosSalaPartidaFieldsCodes
                                                                .numeroJugadores),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 30,
                                                              top: 40),
                                                      child:
                                                          ContainerDatosRegistro(
                                                        "Tiempo de respuesta : ",
                                                        _sala.getField(
                                                            DatosSalaPartidaFieldsCodes
                                                                .tiempoRespuesta),
                                                      ),
                                                    ),
                                                  ],
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
                    _errorUnirse
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
                                    height: constraints.maxHeight / 2.3,
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
                                                _sErrorUnirse,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    color: Color(0xFFb13636),
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
                                                      _errorUnirse = false;
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
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
