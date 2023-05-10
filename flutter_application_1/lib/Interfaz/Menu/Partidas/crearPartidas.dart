// ignore: file_names
// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Data_types/index.dart';
import 'package:flutter_application_1/API/index.dart';
import 'package:flutter_application_1/Interfaz/Menu/Estilo/index.dart';

import '../../../../Data_types/sesion.dart';
import '../home.dart';

//ignore: must_be_immutable
class CrearPartida extends StatefulWidget {
  const CrearPartida(this._s, {Key? key}) : super(key: key);
  final Sesion _s;

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _CrearPartidaState createState() => _CrearPartidaState(_s);
}

class _CrearPartidaState extends State<CrearPartida>
    with WidgetsBindingObserver {
  final _formKey = GlobalKey<FormState>();
  final Sesion _s;
  DatosSalaPartidaClasica _dSPC = DatosSalaPartidaClasica();
  _CrearPartidaState(this._s);

  bool _datosPartida = false;
  bool _modoClasico = false, _modoEquipos = false, _modoTematica = false;

  final TextEditingController _field1Controller = TextEditingController();
  final TextEditingController _field2Controller = TextEditingController();
  final TextEditingController _field3Controller = TextEditingController();
  final TextEditingController _field4Controller = TextEditingController();

  String _errorCambioDatos = "";
  bool _errorCampos = false;
  bool _cambioRealizado = false;
  bool _cambioDatos = false;

  bool _passwordVisible = false;
  bool _partidaPublica = true;

  bool _isKeyboardVisible = false;
  bool _isVisible1 = false, _isVisible2 = false;
  bool _isFocus1 = false,
      _isFocus2 = false,
      _isFocus3 = false,
      _isFocus4 = false;
  final _focusNode1 = FocusNode(),
      _focusNode2 = FocusNode(),
      _focusNode3 = FocusNode(),
      _focusNode4 = FocusNode(),
      _focusNode5 = FocusNode(),
      _focusNode6 = FocusNode();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _focusNode1.addListener(_handleFocus1Change);
    _focusNode2.addListener(_handleFocus2Change);
    _focusNode3.addListener(_handleFocus3Change);
    _focusNode4.addListener(_handleFocus4Change);
    _focusNode5.addListener(_handleFocus5Change);
    _focusNode6.addListener(_handleFocus6Change);
    super.initState();
  }

  void _handleFocus1Change() {
    if (_focusNode1.hasFocus) {
      // The text form field has focus, so the keyboard is being displayed.
      _isFocus1 = true;
    }
  }

  void _handleFocus2Change() {
    if (_focusNode2.hasFocus) {
      // The text form field has focus, so the keyboard is being displayed.
      _isFocus2 = true;
    }
  }

  void _handleFocus3Change() {
    if (_focusNode3.hasFocus) {
      // The text form field has focus, so the keyboard is being displayed.
      _isFocus3 = true;
    }
  }

  void _handleFocus4Change() {
    if (_focusNode4.hasFocus) {
      // The text form field has focus, so the keyboard is being displayed.
      _isFocus4 = true;
    }
  }

  void _handleFocus5Change() {
    if (_focusNode5.hasFocus) {
      // The text form field has focus, so the keyboard is being displayed.
      _isVisible1 = false;
      _isVisible2 = false;
      _focusNode1.unfocus();
      _focusNode2.unfocus();
      _focusNode3.unfocus();
      _focusNode4.unfocus();
      setState(() {});
    }
  }

  void _handleFocus6Change() {
    if (_focusNode6.hasFocus) {
      // The text form field has focus, so the keyboard is being displayed.
      _isVisible1 = false;
      _isVisible2 = false;
      _focusNode1.unfocus();
      _focusNode2.unfocus();
      _focusNode3.unfocus();
      _focusNode4.unfocus();
      setState(() {});
    }
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    // Check whether the keyboard is currently visible.
    final bottomInset = WidgetsBinding.instance.window.viewInsets.bottom;
    _isKeyboardVisible = bottomInset > 400.0;
    if (_isKeyboardVisible && (_isFocus1 || _isFocus2)) {
      _isVisible1 = true;
      setState(() {});
      if (_isFocus1) {
        _isFocus1 = false;
      } else {
        _isFocus2 = false;
      }
    } else if (_isKeyboardVisible && (_isFocus3 || _isFocus4)) {
      _isVisible2 = true;
      setState(() {});
      if (_isFocus3) {
        _isFocus3 = false;
      } else {
        _isFocus4 = false;
      }
    } else if (!_isKeyboardVisible && _isVisible1 && !_isFocus1 && !_isFocus2) {
      _isVisible1 = false;
      _focusNode1.unfocus();
      _focusNode2.unfocus();
      setState(() {});
    } else if (!_isKeyboardVisible && _isVisible2 && !_isFocus3 && !_isFocus4) {
      _isVisible2 = false;
      _focusNode3.unfocus();
      _focusNode4.unfocus();
      setState(() {});
    }
  }

  @override
  void dispose() {
    _field1Controller.dispose();
    _field2Controller.dispose();
    _field3Controller.dispose();
    _field4Controller.dispose();
    WidgetsBinding.instance.removeObserver(this);
    _focusNode1.removeListener(_handleFocus1Change);
    _focusNode1.dispose();
    _focusNode2.removeListener(_handleFocus2Change);
    _focusNode2.dispose();
    _focusNode3.removeListener(_handleFocus3Change);
    _focusNode3.dispose();
    _focusNode4.removeListener(_handleFocus4Change);
    _focusNode4.dispose();
    _focusNode5.removeListener(_handleFocus5Change);
    _focusNode5.dispose();
    _focusNode6.removeListener(_handleFocus6Change);
    _focusNode6.dispose();
    super.dispose();
  }

  void crearPartida() async {
    _formKey.currentState!.save();
    String aux = "";
    String tipoPartida = "";
    if (!_partidaPublica) {
      aux = _dSPC.getField(DatosSalaPartidaClasicaFieldsCodes.contrasena);
    }

    if (_modoClasico) {
      tipoPartida = "Clasico";
    } else if (_modoEquipos) {
      tipoPartida = "Equipo";
    } else {
      tipoPartida = "Tematico";
    }
    Future<CrearSalaResponse> f = crearSalaPartida(
        CrearSalaPetition(
            _dSPC.getField(DatosSalaPartidaClasicaFieldsCodes.nombre),
            _dSPC.getField(DatosSalaPartidaClasicaFieldsCodes.tiempoRespuesta),
            aux,
            _dSPC.getField(DatosSalaPartidaClasicaFieldsCodes.numeroJugadores),
            tipoPartida),
        _s.getField(SesionFieldsCodes.token));
    CrearSalaResponse r = await f;
    if (r.OK) {
      // ignore: use_build_context_synchronously
      /*Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => IniciandoSesion(
                    Sesion(usuario: _usuario, token: r.token), _contrasena)),
            (Route<dynamic> route) => false);*/
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
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  return GestureDetector(
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
                  );
                },
              ),
              LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return GestureDetector(
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
                  );
                },
              ),
              LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return GestureDetector(
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
                  );
                },
              ),
              LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return Visibility(
                    visible: _modoClasico,
                    child: Container(
                      height: constraints.maxHeight,
                      width: constraints.maxWidth,
                      decoration: const BoxDecoration(color: Color(0x80444444)),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Container(
                            width: constraints.maxWidth / 1.10,
                            height: constraints.maxHeight / 1.1,
                            decoration: BoxDecoration(
                                color: const Color(0xFF164966),
                                border: Border.all(color: Colors.white)),
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(top: 7, right: 7),
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
                                      padding: const EdgeInsets.only(top: 15),
                                      child: Container(
                                        alignment: Alignment.topCenter,
                                        child: const Text(
                                          "Creación de sala modo clásico",
                                          style: TextStyle(
                                            fontSize: 22.0,
                                            fontWeight: FontWeight.bold,
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
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const ContainerLabelForm(
                                                  'NOMBRE DE LA SALA'),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: Container(
                                                  height: 45,
                                                  width: 290,
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.white,
                                                      width: 2,
                                                    ),
                                                    color: Colors.white
                                                        .withOpacity(0),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  child: TextFormField(
                                                    controller:
                                                        _field1Controller,
                                                    focusNode: _focusNode6,
                                                    keyboardType: TextInputType
                                                        .visiblePassword,
                                                    onSaved: (value) {
                                                      _dSPC.setField(
                                                          DatosSalaPartidaClasicaFieldsCodes
                                                              .nombre,
                                                          value);
                                                    },
                                                    decoration:
                                                        const InputDecoration(
                                                      border: InputBorder.none,
                                                      hintText:
                                                          'Ingrese el nombre de la sala',
                                                      hintStyle: TextStyle(
                                                          fontFamily:
                                                              "Baskerville",
                                                          fontSize: 15.0,
                                                          color: Colors.white),
                                                    ),
                                                    style: const TextStyle(
                                                        color: Colors.white),
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
                                                const EdgeInsets.only(top: 10),
                                            child: Container(
                                              height: 45,
                                              width: 290,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.white,
                                                  width: 2,
                                                ),
                                                color:
                                                    Colors.white.withOpacity(0),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: TextFormField(
                                                controller: _field2Controller,
                                                focusNode: _focusNode1,
                                                keyboardType:
                                                    TextInputType.number,
                                                onSaved: (value) {
                                                  _dSPC.setField(
                                                      DatosSalaPartidaClasicaFieldsCodes
                                                          .numeroJugadores,
                                                      value);
                                                },
                                                decoration:
                                                    const InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText:
                                                      'Ingrese el número de jugadores',
                                                  hintStyle: TextStyle(
                                                      fontFamily: "Baskerville",
                                                      fontSize: 15.0,
                                                      color: Colors.white),
                                                ),
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 60, left: 350),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const ContainerLabelForm(
                                                  'TIEMPO DE RESPUESTA'),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: Container(
                                                  height: 45,
                                                  width: 290,
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.white,
                                                      width: 2,
                                                    ),
                                                    color: Colors.white
                                                        .withOpacity(0),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  child: TextFormField(
                                                    controller:
                                                        _field3Controller,
                                                    keyboardType:
                                                        TextInputType.datetime,
                                                    focusNode: _focusNode5,
                                                    onSaved: (value) {
                                                      _dSPC.setField(
                                                          DatosSalaPartidaClasicaFieldsCodes
                                                              .tiempoRespuesta,
                                                          value);
                                                    },
                                                    decoration:
                                                        const InputDecoration(
                                                      border: InputBorder.none,
                                                      hintText:
                                                          'Ingrese el tiempo para responder',
                                                      hintStyle: TextStyle(
                                                          fontFamily:
                                                              "Baskerville",
                                                          fontSize: 15.0,
                                                          color: Colors.white),
                                                    ),
                                                    style: const TextStyle(
                                                        color: Colors.white),
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
                                        padding: const EdgeInsets.only(
                                            top: 160, left: 350),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const ContainerLabelForm(
                                                'CONTRASEÑA'),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: Container(
                                                height: 45,
                                                width: 290,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.white,
                                                    width: 2,
                                                  ),
                                                  color: Colors.white
                                                      .withOpacity(0),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                child: TextFormField(
                                                  obscureText:
                                                      !_passwordVisible,
                                                  controller: _field4Controller,
                                                  focusNode: _focusNode3,
                                                  keyboardType: TextInputType
                                                      .visiblePassword,
                                                  onSaved: (value) {
                                                    _dSPC.setField(
                                                        DatosSalaPartidaClasicaFieldsCodes
                                                            .contrasena,
                                                        value);
                                                  },
                                                  decoration: InputDecoration(
                                                    suffixIcon: IconButton(
                                                      icon: Icon(
                                                        // Based on passwordVisible state choose the icon
                                                        !_passwordVisible
                                                            ? Icons.visibility
                                                            : Icons
                                                                .visibility_off,
                                                        color: Colors.white,
                                                      ),
                                                      onPressed: () {
                                                        // Update the state i.e. toogle the state of passwordVisible variable
                                                        setState(() {
                                                          _passwordVisible =
                                                              !_passwordVisible;
                                                        });
                                                      },
                                                    ),
                                                    border: InputBorder.none,
                                                    hintText:
                                                        'Ingrese la contraseña de sala',
                                                    hintStyle: const TextStyle(
                                                        fontFamily:
                                                            "Baskerville",
                                                        fontSize: 15.0,
                                                        color: Colors.white),
                                                  ),
                                                  style: const TextStyle(
                                                      color: Colors.white),
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
                                        padding: const EdgeInsets.only(
                                            left: 420, bottom: 20),
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
                                        onOptionChanged: (partidaPublica) {
                                          _partidaPublica = partidaPublica;
                                          _field4Controller.text = "";
                                          setState(() {});
                                        },
                                      ),
                                    ),
                                    LayoutBuilder(
                                      builder: (BuildContext context,
                                          BoxConstraints constraints) {
                                        return Visibility(
                                          visible: _errorCampos,
                                          child: Container(
                                            height: constraints.maxHeight,
                                            width: constraints.maxWidth,
                                            decoration: const BoxDecoration(
                                                color: Color(0x80444444)),
                                            margin:
                                                const EdgeInsets.only(top: 0),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    width:
                                                        constraints.maxWidth /
                                                            2,
                                                    height:
                                                        constraints.maxHeight /
                                                            2.3,
                                                    decoration: BoxDecoration(
                                                      color: Colors.black,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      border: Border.all(
                                                        color: Colors.black,
                                                        width: 2,
                                                      ),
                                                    ),
                                                    child: Stack(
                                                      children: [
                                                        Align(
                                                          alignment: Alignment
                                                              .topCenter,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 30),
                                                            child: SizedBox(
                                                              height: constraints
                                                                      .maxHeight /
                                                                  4.5,
                                                              width: constraints
                                                                      .maxWidth /
                                                                  2.3,
                                                              child: Text(
                                                                _errorCambioDatos,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: const TextStyle(
                                                                    color: Color(
                                                                        0xFFb13636),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        18,
                                                                    fontFamily:
                                                                        "Georgia"),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment: Alignment
                                                              .bottomCenter,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    bottom: 20),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4),
                                                              child: Stack(
                                                                children: <Widget>[
                                                                  Positioned
                                                                      .fill(
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(30),
                                                                        color: Colors
                                                                            .black,
                                                                        border: Border.all(
                                                                            color:
                                                                                Colors.white,
                                                                            width: 2),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  TextButton(
                                                                    style: TextButton
                                                                        .styleFrom(
                                                                      foregroundColor:
                                                                          Colors
                                                                              .white,
                                                                      // padding: const EdgeInsets.all(16.0),
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          top:
                                                                              4,
                                                                          bottom:
                                                                              4,
                                                                          left:
                                                                              15,
                                                                          right:
                                                                              15),
                                                                      textStyle: const TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              18,
                                                                          fontFamily:
                                                                              "Georgia"),
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      _errorCampos =
                                                                          false;
                                                                      setState(
                                                                          () {});
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
                                        );
                                      },
                                    ),
                                    LayoutBuilder(
                                      builder: (BuildContext context,
                                          BoxConstraints constraints) {
                                        return Visibility(
                                          visible: _cambioRealizado,
                                          child: Container(
                                            height: constraints.maxHeight,
                                            width: constraints.maxWidth,
                                            decoration: const BoxDecoration(
                                                color: Color(0x80444444)),
                                            margin:
                                                const EdgeInsets.only(top: 0),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    width:
                                                        constraints.maxWidth /
                                                            2,
                                                    height:
                                                        constraints.maxHeight /
                                                            2.5,
                                                    decoration: BoxDecoration(
                                                      color: Colors.black,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      border: Border.all(
                                                        color: Colors.black,
                                                        width: 2,
                                                      ),
                                                    ),
                                                    child: Stack(
                                                      children: [
                                                        Align(
                                                          alignment: Alignment
                                                              .topCenter,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 30),
                                                            child: SizedBox(
                                                              height: constraints
                                                                      .maxHeight /
                                                                  4.5,
                                                              width: constraints
                                                                      .maxWidth /
                                                                  2.3,
                                                              child: const Text(
                                                                "Los datos han sido modificados correctamente",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    color: Color(
                                                                        0xFF3dce00),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        18,
                                                                    fontFamily:
                                                                        "Georgia"),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment: Alignment
                                                              .bottomCenter,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    bottom: 20),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4),
                                                              child: Stack(
                                                                children: <Widget>[
                                                                  Positioned
                                                                      .fill(
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(30),
                                                                        color: Colors
                                                                            .black,
                                                                        border: Border.all(
                                                                            color:
                                                                                Colors.white,
                                                                            width: 2),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  TextButton(
                                                                    style: TextButton
                                                                        .styleFrom(
                                                                      foregroundColor:
                                                                          Colors
                                                                              .white,
                                                                      // padding: const EdgeInsets.all(16.0),
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          top:
                                                                              4,
                                                                          bottom:
                                                                              4,
                                                                          left:
                                                                              15,
                                                                          right:
                                                                              15),
                                                                      textStyle: const TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              18,
                                                                          fontFamily:
                                                                              "Georgia"),
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      _cambioRealizado =
                                                                          false;
                                                                      _cambioDatos =
                                                                          false;
                                                                      setState(
                                                                          () {});
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
                                        );
                                      },
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
              LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return Visibility(
                    visible: _modoEquipos,
                    child: Container(
                      height: constraints.maxHeight,
                      width: constraints.maxWidth,
                      decoration: const BoxDecoration(color: Color(0x80444444)),
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
                                    padding:
                                        const EdgeInsets.only(top: 7, right: 6),
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
              Visibility(
                visible: _isVisible1,
                child: Padding(
                  padding: const EdgeInsets.only(top: 200),
                  child: Container(
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                    ),
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      controller: _field2Controller,
                      focusNode: _focusNode2,
                      keyboardType: TextInputType.number,
                      decoration:
                          const InputDecoration(border: InputBorder.none),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: _isVisible2,
                child: Padding(
                  padding: const EdgeInsets.only(top: 160),
                  child: Container(
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                    ),
                    child: TextFormField(
                      obscureText: !_passwordVisible,
                      textAlign: TextAlign.center,
                      controller: _field4Controller,
                      focusNode: _focusNode4,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                          hintText: 'Ingrese la contraseña de sala',
                          hintStyle: const TextStyle(
                              fontFamily: "Baskerville",
                              fontSize: 15.0,
                              color: Colors.white),
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              !_passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              // Update the state i.e. toogle the state of passwordVisible variable
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                          border: InputBorder.none),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
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
