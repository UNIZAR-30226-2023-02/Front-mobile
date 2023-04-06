// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Api/api.dart';
import 'package:flutter_application_1/Interfaz/InicioSesion/registrarse2.dart';
import 'package:flutter_application_1/Interfaz/Menu/homeMenu.dart';
import 'package:flutter_application_1/Data_types/registro.dart';
import 'package:flutter_application_1/Interfaz/InicioSesion/Estilo/index.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class Registrarse4 extends StatefulWidget {
  Registro r;
  Registrarse4(this.r, {Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _Registrarse4State createState() => _Registrarse4State(r);
}

class _Registrarse4State extends State<Registrarse4>
    with WidgetsBindingObserver {
  Registro r;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  String _correoElectronico = "", _telefonoMovil = "";
  String _errorCorreoElectronico = "", _errorTelefonoMovil = "";
  bool _errorCorreoElectronicoVisible = false,
      _errorTelefonoMovilVisible = false;

  _Registrarse4State(this.r);

  bool _isKeyboardVisible = false;
  bool _isVisible = false;
  bool _isFocus1 = false, _isFocus2 = false;
  final _focusNode1 = FocusNode(), _focusNode2 = FocusNode();

  @override
  void initState() {
    super.initState();
    if (r.getField(RegistroFieldsCodes.correoElectronico) != "") {
      _mailController.text = r.getField(RegistroFieldsCodes.correoElectronico);
    }
    if (r.getField(RegistroFieldsCodes.telefonoMovil) != "") {
      _phoneNumberController.text =
          r.getField(RegistroFieldsCodes.telefonoMovil);
    }
    WidgetsBinding.instance.addObserver(this);
    _focusNode1.addListener(_handleFocus1Change);
    _focusNode2.addListener(_handleFocus2Change);
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

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    // Check whether the keyboard is currently visible.
    final bottomInset = WidgetsBinding.instance.window.viewInsets.bottom;
    _isKeyboardVisible = bottomInset > 360.0;
    if (_isKeyboardVisible && (_isFocus1 || _isFocus2)) {
      _isVisible = true;
      setState(() {});
      if (_isFocus1)
        _isFocus1 = false;
      else
        _isFocus2 = false;
    } else if (!_isKeyboardVisible && !_isFocus1 && !_isFocus2) {
      _isVisible = false;
      _focusNode1.unfocus();
      _focusNode2.unfocus();
      setState(() {});
    }
  }

  @override
  void dispose() {
    _mailController.dispose();
    _phoneNumberController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    _focusNode1.removeListener(_handleFocus1Change);
    _focusNode1.dispose();
    _focusNode2.removeListener(_handleFocus2Change);
    _focusNode2.dispose();
    super.dispose();
  }

  void _comprobarDatos(BuildContext context) async {
    _formKey.currentState!.save();
    if (_correoElectronico == "") {
      _errorCorreoElectronicoVisible = true;
      _errorCorreoElectronico =
          "El correo electrónico está vacío.\nPor favor, introduzca el correo.";
    } else {
      _errorCorreoElectronicoVisible = false;
      r.setField(RegistroFieldsCodes.correoElectronico, _correoElectronico);
    }

    if (_telefonoMovil == "") {
      _errorTelefonoMovilVisible = true;
      _errorTelefonoMovil =
          "El número de teléfono móvil está vacío.\nPor favor, introduzca el número.";
      setState(() {});
    } else {
      Future<RegistroUserResponse> f = registroUsuario(
          RegistroUserPetition("", "", "", _telefonoMovil, "", ""));
      RegistroUserResponse re = await f;
      if (re.error_fecha != "") {
        _errorTelefonoMovilVisible = true;
        _errorTelefonoMovil =
            "La fecha de nacimiento no es váida.\nPor favor, introduzca una fecha válida.";
        setState(() {});
      } else {
        _errorTelefonoMovilVisible = false;
        r.setField(RegistroFieldsCodes.fechaNacimiento, _telefonoMovil);
        setState(() {});
        // ignore: use_build_context_synchronously
        r = await Navigator.push(
            context, MaterialPageRoute(builder: (context) => Registrarse4(r)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              ContainerTitle('Registrarse'),
              Padding(
                padding: const EdgeInsets.only(top: 80, left: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ContainerLabelForm('CORREO ELECTRONICO'),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Container(
                            height: 45,
                            width: 250,
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
                              keyboardType: TextInputType.name,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Introduzca su correo',
                                hintStyle: TextStyle(
                                    fontFamily: "Baskerville",
                                    fontSize: 16.0,
                                    color: Colors.white),
                              ),
                              onSaved: (value) {
                                _correoElectronico = value!;
                              },
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
                    ContainerLabelForm('TÉLEFONO MÓVIL'),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        height: 45,
                        width: 300,
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
                          focusNode: _focusNode1,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Introduzca su número de télefono',
                            hintStyle: TextStyle(
                                fontFamily: "Baskerville",
                                fontSize: 16.0,
                                color: Colors.white),
                          ),
                          onSaved: (value) {
                            _telefonoMovil = value!;
                          },
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 360, top: 110),
                child: Stack(
                  children: [
                    Visibility(
                      visible: _errorCorreoElectronicoVisible,
                      child: Stack(
                        children: [
                          const ContainerError2(),
                          Padding(
                            padding: const EdgeInsets.only(),
                            child: SizedBox(
                              width: 300,
                              height: 60,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, top: 15),
                                child: Text(_errorCorreoElectronico,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.0,
                                        fontFamily: "Baskerville",
                                        color: Color(0xFFb13636))),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 360, top: 230),
                child: Stack(
                  children: [
                    Visibility(
                      visible: _errorTelefonoMovilVisible,
                      child: Stack(
                        children: [
                          const ContainerError2(),
                          Padding(
                            padding: const EdgeInsets.only(),
                            child: SizedBox(
                              width: 300,
                              height: 60,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, top: 15),
                                child: Text(_errorTelefonoMovil,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.0,
                                        fontFamily: "Baskerville",
                                        color: Color(0xFFb13636))),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: _isVisible,
                child: Padding(
                  padding: const EdgeInsets.only(top: 200),
                  child: Container(
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                    ),
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      textAlignVertical: TextAlignVertical.center,
                      controller: _phoneNumberController,
                      focusNode: _focusNode2,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Introduzca su número de télefono',
                        hintStyle: TextStyle(
                            fontFamily: "Baskerville",
                            fontSize: 16.0,
                            color: Colors.white),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 320,
                left: 130,
                child: Container(
                  margin: const EdgeInsets.only(top: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Boton(
                        "VOLVER",
                        onPressed: () {
                          Navigator.pop(context, r);
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 200),
                        child: Boton(
                          "CONTINUAR",
                          onPressed: () {
                            _comprobarDatos(context);
                          },
                        ),
                      ),
                    ],
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
