// ignore: file_names
// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Data_types/datosUsuario.dart';
import 'package:flutter_application_1/API/index.dart';
import 'package:flutter_application_1/Interfaz/InicioSesion_Registro/Estilo/index.dart';
import 'package:flutter_application_1/Interfaz/Menu/homeMenu.dart';

import '../../../Data_types/sesion.dart';
import '../Menu/home.dart';

//ignore: must_be_immutable
class Perfil extends StatefulWidget {
  Perfil(this._s, this._dU, {Key? key}) : super(key: key);
  final Sesion _s;
  DatosUsuario _dU;

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _PerfilState createState() => _PerfilState(_s, _dU);
}

class _PerfilState extends State<Perfil> with WidgetsBindingObserver {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  Sesion _s;
  DatosUsuario _dU;
  _PerfilState(this._s, this._dU);
  bool _errorCampos = false;
  bool _cambioDatos = false;

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
      _focusNode5 = FocusNode();

  @override
  void initState() {
    print("initstate");
    WidgetsBinding.instance.addObserver(this);
    conseguirDatosUsuario();
    _focusNode1.addListener(_handleFocus1Change);
    _focusNode2.addListener(_handleFocus2Change);
    _focusNode3.addListener(_handleFocus3Change);
    _focusNode4.addListener(_handleFocus4Change);
    _focusNode5.addListener(_handleFocus5Change);
    super.initState();
  }

  void conseguirDatosUsuario() async {
    Future<DatosUsuarioResponse> f = obtenerDatosUsuario(
        DatosUsuarioPetition(_s.getField(SesionFieldsCodes.token)));
    DatosUsuarioResponse r = await f;
    if (r.OK) {
      print("hol1");
      _dU = DatosUsuario(
          usuario: r.username,
          correoElectronico: r.correo,
          telefonoMovil: r.telefono,
          fechaNacimiento: r.fecha);
    }
    _userController.text = _dU.getField(DatosUsuarioFieldsCodes.usuario);
    _mailController.text =
        _dU.getField(DatosUsuarioFieldsCodes.correoElectronico);
    _phoneNumberController.text =
        _dU.getField(DatosUsuarioFieldsCodes.telefonoMovil);
    _birthDateController.text =
        _dU.getField(DatosUsuarioFieldsCodes.fechaNacimiento);
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
    _userController.dispose();
    _mailController.dispose();
    _phoneNumberController.dispose();
    _birthDateController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    _focusNode1.removeListener(_handleFocus1Change);
    _focusNode1.dispose();
    _focusNode2.removeListener(_handleFocus2Change);
    _focusNode2.dispose();
    _focusNode3.removeListener(_handleFocus3Change);
    _focusNode3.dispose();
    _focusNode4.removeListener(_handleFocus4Change);
    _focusNode4.dispose();
    super.dispose();
  }

  void _comprobarDatos(BuildContext context) async {
    Future<CambioDatosUsuarioResponse> f = CambiarDatosUsuario(
        CambioDatosUsuarioPetition(
            _s.getField(SesionFieldsCodes.token),
            _birthDateController.text,
            _mailController.text,
            _phoneNumberController.text));
    CambioDatosUsuarioResponse r = await f;
    if (r.OK) {
      // ignore: use_build_context_synchronously
      _formKey.currentState!.save();
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_cambioDatos) {
          _cambioDatos = false;
          _mailController.text =
              _dU.getField(DatosUsuarioFieldsCodes.correoElectronico);
          _birthDateController.text =
              _dU.getField(DatosUsuarioFieldsCodes.fechaNacimiento);
          _phoneNumberController.text =
              _dU.getField(DatosUsuarioFieldsCodes.telefonoMovil);

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
                  padding: const EdgeInsets.only(top: 30),
                  child: Container(
                    alignment: Alignment.topCenter,
                    child: const Text(
                      "Perfil",
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
                  padding: const EdgeInsets.only(top: 80, left: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const ContainerLabelForm('USUARIO'),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                              height: 45,
                              width: 290,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                                color: Colors.white.withOpacity(0),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: TextFormField(
                                controller: _userController,
                                readOnly: true,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 200,
                  left: 40,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ContainerLabelForm('CORREO ELECTRONICO'),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          height: 45,
                          width: 290,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                            color: Colors.white.withOpacity(0),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: TextFormField(
                            controller: _mailController,
                            focusNode: _focusNode1,
                            readOnly: !_cambioDatos,
                            keyboardType: TextInputType.visiblePassword,
                            onSaved: (value) {
                              _dU.setField(
                                  DatosUsuarioFieldsCodes.correoElectronico,
                                  value!);
                            },
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 80, left: 350),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const ContainerLabelForm('FECHA NACIMIENTO'),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                              height: 45,
                              width: 290,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                                color: Colors.white.withOpacity(0),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: TextFormField(
                                controller: _birthDateController,
                                readOnly: !_cambioDatos,
                                keyboardType: TextInputType.datetime,
                                focusNode: _focusNode5,
                                onSaved: (value) {
                                  _dU.setField(
                                      DatosUsuarioFieldsCodes.fechaNacimiento,
                                      value!);
                                },
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 200,
                  left: 350,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ContainerLabelForm('TELEFONO MOVIL'),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          height: 45,
                          width: 290,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                            color: Colors.white.withOpacity(0),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: TextFormField(
                            controller: _phoneNumberController,
                            focusNode: _focusNode3,
                            readOnly: !_cambioDatos,
                            keyboardType: TextInputType.number,
                            onSaved: (value) {
                              _dU.setField(
                                  DatosUsuarioFieldsCodes.telefonoMovil,
                                  value!);
                            },
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: _isVisible1,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 160),
                    child: Container(
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                      ),
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        controller: _mailController,
                        focusNode: _focusNode2,
                        keyboardType: TextInputType.visiblePassword,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: _isVisible2,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 200),
                    child: Container(
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                      ),
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        controller: _phoneNumberController,
                        focusNode: _focusNode4,
                        keyboardType: TextInputType.number,
                        decoration:
                            const InputDecoration(border: InputBorder.none),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 320,
                  left: 130,
                  child: Visibility(
                    visible: !_cambioDatos,
                    child: Container(
                      margin: const EdgeInsets.only(top: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Boton1(
                            "VOLVER",
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Menu(_s)),
                                  (Route<dynamic> route) => false);
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 200),
                            child: Boton1(
                              "CAMBIAR DATOS",
                              onPressed: () {
                                _cambioDatos = true;
                                setState(() {});
                                _isFocus1 = false;
                                _isFocus2 = false;
                                _isFocus3 = false;
                                _isFocus4 = false;
                                _focusNode1.unfocus();
                                _focusNode2.unfocus();
                                _focusNode3.unfocus();
                                _focusNode4.unfocus();
                                _focusNode5.unfocus();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 320,
                  left: 130,
                  child: Visibility(
                    visible: _cambioDatos,
                    child: Container(
                      margin: const EdgeInsets.only(top: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Boton1(
                            "CANCELAR",
                            onPressed: () {
                              _cambioDatos = false;
                              _mailController.text = _dU.getField(
                                  DatosUsuarioFieldsCodes.correoElectronico);
                              _birthDateController.text = _dU.getField(
                                  DatosUsuarioFieldsCodes.fechaNacimiento);
                              _phoneNumberController.text = _dU.getField(
                                  DatosUsuarioFieldsCodes.telefonoMovil);

                              setState(() {});
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 200),
                            child: Boton1(
                              "CONFIRMAR",
                              onPressed: () {
                                _comprobarDatos(context);
                              },
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
      ),
    );
  }
}
