// ignore: file_names
// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Data_types/index.dart';
import 'package:flutter_application_1/API/index.dart';
import 'package:flutter_application_1/Interfaz/Menu/Estilo/index.dart';

import '../../../../Data_types/sesion.dart';
import '../../Juego/juego.dart';
import '../home.dart';

//ignore: must_be_immutable
class CrearPartida extends StatefulWidget {
  const CrearPartida(this._s, {Key? key}) : super(key: key);
  final Sesion _s;

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _CrearPartidaState createState() => _CrearPartidaState(_s);
}

class _CrearPartidaState extends State<CrearPartida> {
  final _formKey = GlobalKey<FormState>();
  final Sesion _s;
  DatosSalaPartida _dSP = DatosSalaPartida();
  _CrearPartidaState(this._s);
  static const List<String> _opcionesJugadores = ['2', '4', '6'],
      _opcionesTiempo = ['10', '15', '20', '25', '30'];

  bool _modoClasico = false, _modoEquipos = false, _modoTematica = false;

  final TextEditingController _field1Controller = TextEditingController();
  final TextEditingController _field2Controller = TextEditingController();
  final TextEditingController _field3Controller = TextEditingController();
  final TextEditingController _field4Controller = TextEditingController();

  String _errorCambioDatos = "",
      _contrasena = "",
      _opcionJugador = _opcionesJugadores[0],
      _opcionTiempo = _opcionesTiempo[0];
  bool _errorCampos = false;

  bool _passwordVisible = false;
  bool _partidaPublica = true;

  @override
  void dispose() {
    _field1Controller.dispose();
    _field2Controller.dispose();
    _field3Controller.dispose();
    _field4Controller.dispose();
    super.dispose();
  }

  void crearPartida() async {
    _formKey.currentState!.save();
    String aux = "";
    String tipoPartida;
    if (!_partidaPublica) {
      aux = _contrasena;
    }

    if (_modoClasico) {
      tipoPartida = "Clasico";
    } else if (_modoEquipos) {
      tipoPartida = "Equipo";
    } else {
      tipoPartida = "Tematico";
    }
    Future<CrearSalaResponse> f = crearSalaPartida(
        CrearSalaPetition(_dSP.getField(DatosSalaPartidaFieldsCodes.nombre),
            _opcionTiempo, aux, _opcionJugador, tipoPartida, ""),
        _s.getField(SesionFieldsCodes.token));
    CrearSalaResponse r = await f;
    if (r.OK) {
      // ignore: use_build_context_synchronously
      Future<ValidarSalaResponse> f = validarSalaPartida(
          ValidarSalaPetition(
              _dSP.getField(DatosSalaPartidaFieldsCodes.nombre), aux),
          _s.getField(SesionFieldsCodes.token));
      ValidarSalaResponse r = await f;
      if (r.OK) {
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => Juego(_s, r.ws, tipoPartida)),
            (Route<dynamic> route) => false);
      }
    } else {
      _errorCampos = true;
      if (r.errorNombreSala != "") {
        _errorCambioDatos = r.errorNombreSala;
      } else if (r.errorNJugadores != "") {
        _errorCambioDatos = r.errorNJugadores;
      } else if (r.errorTiempoRespuesta != "") {
        _errorCambioDatos = r.errorTiempoRespuesta;
      } else if (r.errorTipoPartida != "") {
        _errorCambioDatos = r.errorTipoPartida;
      } else if (r.errorTematica != "") {
        _errorCambioDatos = r.errorTematica;
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_modoClasico) {
          if (_errorCampos) {
            _errorCampos = false;
          } else {
            _modoClasico = false;
            _field1Controller.text = "";
            _field2Controller.text = "";
            _field3Controller.text = "";
            _field4Controller.text = "";
          }
          setState(() {});
        } else if (_modoEquipos) {
          if (_errorCampos) {
            _errorCampos = false;
          } else {
            _modoEquipos = false;
            _field1Controller.text = "";
            _field2Controller.text = "";
            _field3Controller.text = "";
            _field4Controller.text = "";
          }
          setState(() {});
        } else if (_modoTematica) {
          if (_errorCampos) {
            _errorCampos = false;
          } else {
            _modoTematica = false;
            _field1Controller.text = "";
            _field2Controller.text = "";
            _field3Controller.text = "";
            _field4Controller.text = "";
          }
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
          child: Form(
            key: _formKey,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Container(
                    alignment: Alignment.topCenter,
                    child: const Text(
                      "Crear Partida",
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFc9c154),
                        fontFamily: "Baskerville",
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 40, left: 50),
                    child: Boton1(
                      "VOLVER",
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _modoClasico = true;
                            _partidaPublica = true;
                            setState(() {});
                          },
                          child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 380),
                              child: Container(
                                width: constraints.maxWidth / 5,
                                height: constraints.maxHeight / 2.8,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(color: Colors.white)),
                                child: Stack(
                                  children: [
                                    const Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Padding(
                                        padding: EdgeInsets.only(bottom: 10),
                                        child: Text(
                                          "Modo Clásico",
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
                                        padding: const EdgeInsets.only(top: 15),
                                        child: SizedBox(
                                          height: 75,
                                          width: 75,
                                          child: Image.asset(
                                            "assets/Clasico.png",
                                            color: Colors.white,
                                            fit: BoxFit.fill,
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
                        GestureDetector(
                          onTap: () {
                            _modoEquipos = true;
                            _partidaPublica = true;
                            setState(() {});
                          },
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: constraints.maxWidth / 5,
                              height: constraints.maxHeight / 2.8,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(color: Colors.white)),
                              child: Stack(
                                children: [
                                  const Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Padding(
                                      padding: EdgeInsets.only(bottom: 10),
                                      child: Text(
                                        "Modo Equipos",
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
                                      padding: const EdgeInsets.only(top: 15),
                                      child: SizedBox(
                                        height: 75,
                                        width: 75,
                                        child: Image.asset(
                                          "assets/Clasico.png",
                                          color: Colors.white,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _modoTematica = true;
                            _partidaPublica = true;
                            setState(() {});
                          },
                          child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 380),
                              child: Container(
                                width: constraints.maxWidth / 5,
                                height: constraints.maxHeight / 2.8,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(color: Colors.white)),
                                child: Stack(
                                  children: [
                                    const Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Padding(
                                        padding: EdgeInsets.only(bottom: 10),
                                        child: Text(
                                          "Modo Temática",
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
                                        padding: const EdgeInsets.only(top: 15),
                                        child: SizedBox(
                                          height: 75,
                                          width: 75,
                                          child: Image.asset(
                                            "assets/Clasico.png",
                                            color: Colors.white,
                                            fit: BoxFit.fill,
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
                        _modoClasico
                            ? Container(
                                height: constraints.maxHeight,
                                width: constraints.maxWidth,
                                decoration: const BoxDecoration(
                                    color: Color(0x80444444)),
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: Container(
                                      width: constraints.maxWidth / 1.10,
                                      height: constraints.maxHeight / 1.1,
                                      decoration: BoxDecoration(
                                          color: const Color(0xFF164966),
                                          border:
                                              Border.all(color: Colors.white)),
                                      child: Stack(
                                        children: [
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
                                                  _modoClasico = false;
                                                  setState(() {});
                                                }),
                                          ),
                                          Stack(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 15),
                                                child: Container(
                                                  alignment:
                                                      Alignment.topCenter,
                                                  child: const Text(
                                                    "Creación de sala modo clásico",
                                                    style: TextStyle(
                                                      fontSize: 22.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color(0xFFc9c154),
                                                      fontFamily: "Baskerville",
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 60, left: 30),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const ContainerLabelForm(
                                                            'NOMBRE DE LA SALA'),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 10),
                                                          child: Container(
                                                            height: 45,
                                                            width: 290,
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        10),
                                                            decoration:
                                                                BoxDecoration(
                                                              border:
                                                                  Border.all(
                                                                color: Colors
                                                                    .white,
                                                                width: 2,
                                                              ),
                                                              color: Colors
                                                                  .white
                                                                  .withOpacity(
                                                                      0),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15),
                                                            ),
                                                            child:
                                                                TextFormField(
                                                              controller:
                                                                  _field1Controller,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .visiblePassword,
                                                              onSaved: (value) {
                                                                _dSP.setField(
                                                                    DatosSalaPartidaFieldsCodes
                                                                        .nombre,
                                                                    value);
                                                              },
                                                              decoration:
                                                                  const InputDecoration(
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                hintText:
                                                                    'Ingrese el nombre de la sala',
                                                                hintStyle: TextStyle(
                                                                    fontFamily:
                                                                        "Baskerville",
                                                                    fontSize:
                                                                        15.0,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 160, left: 30),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const ContainerLabelForm(
                                                        'NÚMERO JUGADORES'),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10),
                                                      child: Container(
                                                        height: 45,
                                                        width: 290,
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 10),
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                            color: Colors.white,
                                                            width: 2,
                                                          ),
                                                          color: Colors
                                                              .transparent,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                        ),
                                                        child:
                                                            DropdownButtonFormField(
                                                          decoration:
                                                              const InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none),
                                                          value: _opcionJugador,
                                                          iconEnabledColor:
                                                              Colors.white,
                                                          dropdownColor:
                                                              const Color(
                                                                  0xFF164966),
                                                          onChanged: (value) {
                                                            _opcionJugador =
                                                                value as String;
                                                          },
                                                          style: const TextStyle(
                                                              fontFamily:
                                                                  "Baskerville",
                                                              fontSize: 15.0,
                                                              color:
                                                                  Colors.white),
                                                          items:
                                                              _opcionesJugadores
                                                                  .map((String
                                                                      option) {
                                                            return DropdownMenuItem(
                                                              value: option,
                                                              child: Text(
                                                                "$option jugadores",
                                                                style: const TextStyle(
                                                                    fontFamily:
                                                                        "Baskerville",
                                                                    fontSize:
                                                                        15.0,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            );
                                                          }).toList(),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 160, left: 350),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const ContainerLabelForm(
                                                            'TIEMPO DE RESPUESTA'),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 10),
                                                          child: Container(
                                                            height: 45,
                                                            width: 290,
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        10),
                                                            decoration:
                                                                BoxDecoration(
                                                              border:
                                                                  Border.all(
                                                                color: Colors
                                                                    .white,
                                                                width: 2,
                                                              ),
                                                              color: Colors
                                                                  .white
                                                                  .withOpacity(
                                                                      0),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15),
                                                            ),
                                                            child:
                                                                DropdownButtonFormField(
                                                              decoration: const InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none),
                                                              value:
                                                                  _opcionTiempo,
                                                              iconEnabledColor:
                                                                  Colors.white,
                                                              dropdownColor:
                                                                  const Color(
                                                                      0xFF164966),
                                                              onChanged:
                                                                  (value) {
                                                                _opcionTiempo =
                                                                    value
                                                                        as String;
                                                              },
                                                              style: const TextStyle(
                                                                  fontFamily:
                                                                      "Baskerville",
                                                                  fontSize:
                                                                      15.0,
                                                                  color: Colors
                                                                      .white),
                                                              items: _opcionesTiempo
                                                                  .map((String
                                                                      option) {
                                                                return DropdownMenuItem(
                                                                  value: option,
                                                                  child: Text(
                                                                    "$option segundos",
                                                                    style: const TextStyle(
                                                                        fontFamily:
                                                                            "Baskerville",
                                                                        fontSize:
                                                                            15.0,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                );
                                                              }).toList(),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Visibility(
                                                visible: !_partidaPublica,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 60, left: 350),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const ContainerLabelForm(
                                                          'CONTRASEÑA'),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 10),
                                                        child: Container(
                                                          height: 45,
                                                          width: 290,
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      10),
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
                                                            obscureText:
                                                                !_passwordVisible,
                                                            controller:
                                                                _field4Controller,
                                                            keyboardType:
                                                                TextInputType
                                                                    .visiblePassword,
                                                            onSaved: (value) {
                                                              _contrasena =
                                                                  value!;
                                                            },
                                                            decoration:
                                                                InputDecoration(
                                                              suffixIcon:
                                                                  IconButton(
                                                                icon: Icon(
                                                                  // Based on passwordVisible state choose the icon
                                                                  !_passwordVisible
                                                                      ? Icons
                                                                          .visibility
                                                                      : Icons
                                                                          .visibility_off,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                onPressed: () {
                                                                  // Update the state i.e. toogle the state of passwordVisible variable
                                                                  setState(() {
                                                                    _passwordVisible =
                                                                        !_passwordVisible;
                                                                  });
                                                                },
                                                              ),
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              hintText:
                                                                  'Ingrese la contraseña de sala',
                                                              hintStyle: const TextStyle(
                                                                  fontFamily:
                                                                      "Baskerville",
                                                                  fontSize:
                                                                      15.0,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.bottomLeft,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 420,
                                                          bottom: 20),
                                                  child: Boton1(
                                                    "CREAR SALA",
                                                    onPressed: () {
                                                      crearPartida();
                                                      setState(() {});
                                                    },
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 260, left: 60),
                                                child: TwoOptionsField(
                                                  option1Text: "Publica",
                                                  option2Text: "Privada",
                                                  onOptionChanged:
                                                      (partidaPublica) {
                                                    _partidaPublica =
                                                        partidaPublica;
                                                    _field4Controller.text = "";
                                                    setState(() {});
                                                  },
                                                ),
                                              ),
                                              _errorCampos
                                                  ? Container(
                                                      height:
                                                          constraints.maxHeight,
                                                      width:
                                                          constraints.maxWidth,
                                                      decoration:
                                                          const BoxDecoration(
                                                              color: Color(
                                                                  0x80444444)),
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: 0),
                                                      child: Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Stack(
                                                          children: [
                                                            Container(
                                                              width: constraints
                                                                      .maxWidth /
                                                                  2,
                                                              height: constraints
                                                                      .maxHeight /
                                                                  2.3,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .black,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                                border:
                                                                    Border.all(
                                                                  color: Colors
                                                                      .black,
                                                                  width: 2,
                                                                ),
                                                              ),
                                                              child: Stack(
                                                                children: [
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topCenter,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          top:
                                                                              30),
                                                                      child:
                                                                          SizedBox(
                                                                        height: constraints.maxHeight /
                                                                            4.5,
                                                                        width: constraints.maxWidth /
                                                                            2.3,
                                                                        child:
                                                                            Text(
                                                                          _errorCambioDatos,
                                                                          textAlign:
                                                                              TextAlign.center,
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
                                                                    alignment:
                                                                        Alignment
                                                                            .bottomCenter,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          bottom:
                                                                              20),
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(4),
                                                                        child:
                                                                            Stack(
                                                                          children: <
                                                                              Widget>[
                                                                            Positioned.fill(
                                                                              child: Container(
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(30),
                                                                                  color: Colors.black,
                                                                                  border: Border.all(color: Colors.white, width: 2),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            TextButton(
                                                                              style: TextButton.styleFrom(
                                                                                foregroundColor: Colors.white,
                                                                                // padding: const EdgeInsets.all(16.0),
                                                                                padding: const EdgeInsets.only(top: 4, bottom: 4, left: 15, right: 15),
                                                                                textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, fontFamily: "Georgia"),
                                                                              ),
                                                                              onPressed: () {
                                                                                _errorCampos = false;
                                                                                setState(() {});
                                                                              },
                                                                              child: const Text("ACEPTAR"),
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
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                      ],
                    );
                  },
                ),
                LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return Visibility(
                      visible: _modoEquipos,
                      child: Container(
                        height: constraints.maxHeight,
                        width: constraints.maxWidth,
                        decoration:
                            const BoxDecoration(color: Color(0x80444444)),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: Container(
                              width: constraints.maxWidth / 1.10,
                              height: constraints.maxHeight / 1.2,
                              decoration: BoxDecoration(
                                  color: const Color(0xFF164966),
                                  border: Border.all(color: Colors.white)),
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 7, right: 6),
                                      child: Container(
                                        width: 33,
                                        height: 33,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Colors.white, width: 1),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 573),
                                    child: IconButton(
                                        iconSize: 31,
                                        icon: const Icon(
                                          Icons.close,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          _modoEquipos = false;
                                          setState(() {});
                                        }),
                                  ),
                                  Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 20),
                                        child: Container(
                                          alignment: Alignment.topCenter,
                                          child: const Text(
                                            "Creación de sala modo equipos",
                                            style: TextStyle(
                                              fontSize: 22.0,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFFc9c154),
                                              fontFamily: "Baskerville",
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TwoOptionsField extends StatefulWidget {
  final String option1Text;
  final String option2Text;
  final Function(bool) onOptionChanged;

  const TwoOptionsField({
    Key? key,
    required this.option1Text,
    required this.option2Text,
    required this.onOptionChanged,
  }) : super(key: key);

  @override
  _TwoOptionsFieldState createState() => _TwoOptionsFieldState();
}

class _TwoOptionsFieldState extends State<TwoOptionsField> {
  bool _selectedOption1 = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      height: 50,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.option1Text,
              style: TextStyle(
                color: _selectedOption1 ? Colors.white : Colors.grey,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              widget.option2Text,
              style: TextStyle(
                color: _selectedOption1 ? Colors.grey : Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 80,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white, width: 1.0)),
              child: GestureDetector(
                onTapDown: (details) {
                  final tapPosition = details.localPosition.dx;
                  _selectedOption1 = tapPosition <= 80 / 2;
                  widget.onOptionChanged(_selectedOption1);
                },
                child: SizedBox(
                  width: 80,
                  height: 50,
                  child: CustomPaint(
                    painter: _IndicatorPainter(_selectedOption1),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _IndicatorPainter extends CustomPainter {
  final bool selectedOption1;

  _IndicatorPainter(this.selectedOption1);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white;
    final circleCenter = Offset(
      selectedOption1 ? size.width / 4 : size.width * 3 / 4,
      size.height / 2,
    );
    canvas.drawCircle(circleCenter, 16, paint);
  }

  @override
  bool shouldRepaint(_IndicatorPainter oldDelegate) {
    return oldDelegate.selectedOption1 != selectedOption1;
  }
}
