// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Interfaz/InicioSesion/index.dart';
import 'package:flutter_application_1/Interfaz/Menu/homeMenu.dart';
import 'package:flutter_application_1/Data_types/registro.dart';
import 'package:flutter_application_1/Interfaz/InicioSesion/Estilo/index.dart';
import 'package:http/http.dart';

class Registrarse2 extends StatefulWidget {
  Registro r;
  Registrarse2(this.r, {Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _Registrarse2State createState() => _Registrarse2State(r);
}

class _Registrarse2State extends State<Registrarse2>
    with WidgetsBindingObserver {
  Registro r;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String _contrasena = "", _confirmarContrasena = "";
  String _errorContrasenas = "";
  bool _errorContrasenasVisible = false;

  bool _isKeyboardVisible = false;
  bool _isVisible = false;
  bool _isFocus = false;
  final _focusNode = FocusNode();

  _Registrarse2State(this.r);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _focusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    if (_focusNode.hasFocus) {
      // The text form field has focus, so the keyboard is being displayed.
      _isFocus = true;
    }
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    // Check whether the keyboard is currently visible.
    final bottomInset = WidgetsBinding.instance.window.viewInsets.bottom;
    _isKeyboardVisible = bottomInset > 500.0;
    if (_isKeyboardVisible && _isFocus) {
      _isVisible = true;
      setState(() {});
      _isFocus = false;
    } else if (!_isKeyboardVisible && !_isFocus) {
      _isVisible = false;
      _focusNode.unfocus();
      setState(() {});
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _comprobarDatos(BuildContext context) async {
    if (_passwordController.text == "" &&
        _confirmPasswordController.text == "") {
      _errorContrasenasVisible = true;
      _errorContrasenas =
          "Las contraseñas están vacías.\nPor favor, introdúzcalas.";
      setState(() {});
    } else if (_passwordController.text != _confirmPasswordController.text) {
      _errorContrasenasVisible = true;
      _errorContrasenas =
          "Las contraseñas no coinciden.\nPor favor, introdúzcalas de nuevo.";
      setState(() {});
    } else if (_passwordController.text.length < 9) {
      _errorContrasenasVisible = true;
      _errorContrasenas =
          "La contraseña debe ser de 9 carácteres o más.\nPor favor, introdúzcala de nuevo.";
      setState(() {});
    } else {
      _errorContrasenasVisible = false;

      setState(() {});

      _formKey.currentState!.save();

      r.setField(RegistroFieldsCodes.contrasena, _contrasena);
      r.setField(RegistroFieldsCodes.confirmarContrasena, _confirmarContrasena);

      // ignore: use_build_context_synchronously
      r = await Navigator.push(
          context, MaterialPageRoute(builder: (context) => Registrarse3(r)));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (r.getField(RegistroFieldsCodes.contrasena) != "") {
      _passwordController.text = r.getField(RegistroFieldsCodes.contrasena);
      _confirmPasswordController.text =
          r.getField(RegistroFieldsCodes.confirmarContrasena);
    }
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
                        ContainerLabelForm('CONTRASEÑA'),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
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
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: TextFormField(
                                controller: _passwordController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Introduzca la contraseña',
                                  hintStyle: TextStyle(
                                      fontFamily: "Baskerville",
                                      fontSize: 16.0,
                                      color: Colors.white),
                                ),
                                onSaved: (value) {
                                  _contrasena = value!;
                                },
                                style: const TextStyle(color: Colors.white),
                              ),
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
                    ContainerLabelForm('CONFIRMAR CONTRASEÑA'),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Container(
                        height: 45,
                        width: 320,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                          color: Colors.white.withOpacity(0),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: TextFormField(
                            controller: _confirmPasswordController,
                            focusNode: _focusNode,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Introduzca la contraseña de nuevo',
                              hintStyle: TextStyle(
                                  fontFamily: "Baskerville",
                                  fontSize: 16.0,
                                  color: Colors.white),
                            ),
                            onSaved: (value) {
                              _confirmarContrasena = value!;
                            },
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 350, top: 120),
                child: Stack(
                  children: [
                    Visibility(
                      visible: _errorContrasenasVisible,
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
                                child: Text(_errorContrasenas,
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
                  padding: const EdgeInsets.only(top: 165),
                  child: Container(
                    height: 35,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        controller: _confirmPasswordController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
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
