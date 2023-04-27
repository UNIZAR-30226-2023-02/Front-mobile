// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Interfaz/InicioSesion_Registro/index.dart';
import 'package:flutter_application_1/Interfaz/Menu/homeMenu.dart';
import 'package:flutter_application_1/Data_types/registro.dart';
import 'package:flutter_application_1/Interfaz/InicioSesion_Registro/Estilo/index.dart';
import 'package:http/http.dart';

import '../../../API/api.dart';
//ignore: must_be_immutable
class Registrarse2 extends StatefulWidget {
  Registro _r;
  List<bool> _quesitos;
  Registrarse2(this._r, this._quesitos, {Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _Registrarse2State createState() => _Registrarse2State(_r, _quesitos);
}

class _Registrarse2State extends State<Registrarse2>
    with WidgetsBindingObserver {
  Registro _r;

  List<bool> _quesitos;
  int _nQuesitos = 0;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String _contrasena = "", _confirmarContrasena = "";
  String _errorContrasenas = "";
  bool _errorContrasenasVisible = false;

  bool _isKeyboardVisible = false;
  bool _isVisible = false;
  bool _isFocus1 = false, _isFocus2 = false;
  final _focusNode1 = FocusNode(), _focusNode2 = FocusNode();

  bool _password1Visible = false, _password2Visible = false;

  _Registrarse2State(this._r, this._quesitos);

  @override
  void initState() {
    super.initState();

    _nQuesitos = _quesitos.where((element) => element == true).length;
    if (_r.getField(RegistroFieldsCodes.contrasena) != "") {
      _passwordController.text = _r.getField(RegistroFieldsCodes.contrasena);
      _confirmPasswordController.text =
          _r.getField(RegistroFieldsCodes.confirmarContrasena);
    }
    setState(() {});
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
    _isKeyboardVisible = bottomInset > 500.0;
    if (_isKeyboardVisible && (_isFocus1 || _isFocus2)) {
      _isVisible = true;
      setState(() {});
      if (_isFocus1) {
        _isFocus1 = false;
      } else {
        _isFocus2 = false;
      }
    } else if (!_isKeyboardVisible && !_isFocus1 && !_isFocus2) {
      _isVisible = false;
      _focusNode1.unfocus();
      _focusNode2.unfocus();
      setState(() {});
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    _focusNode1.removeListener(_handleFocus1Change);
    _focusNode1.dispose();
    _focusNode2.removeListener(_handleFocus2Change);
    _focusNode2.dispose();
    super.dispose();
  }

  void _comprobarDatos(BuildContext context) async {
    _formKey.currentState!.save();
    _r.setField(RegistroFieldsCodes.contrasena, _contrasena);
    _r.setField(RegistroFieldsCodes.confirmarContrasena, _confirmarContrasena);
    Future<RegistroUserResponse> f = registroUsuario(RegistroUserPetition(
        "", _contrasena, _confirmarContrasena, "", "", ""));
    RegistroUserResponse re = await f;

    if (re.error_password != "") {
      _errorContrasenasVisible = true;
      _errorContrasenas =
          "${re.error_password}\nPor favor, introdúzcalas de nuevo.";
      _quesitos[2] = false;
      _quesitos[3] = false;
    } else {
      _errorContrasenasVisible = false;
      _quesitos[2] = true;
      _quesitos[3] = true;
    }

    _nQuesitos = _quesitos.where((element) => element == true).length;
    setState(() {});

    if (!_errorContrasenasVisible) {
      // ignore: use_build_context_synchronously
      _r = await Navigator.push(context,
          MaterialPageRoute(builder: (context) => Registrarse3(_r, _quesitos)));
      setState(() {
        _nQuesitos = _quesitos.where((element) => element == true).length;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, _r);
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
                  padding: const EdgeInsets.only(top: 40, left: 630),
                  child: Text(
                    "$_nQuesitos/6",
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xfff7f6f6),
                      fontFamily: "Georgia",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 60, left: 520),
                  child: ContainerQuesitos(_quesitos),
                ),
                const ContainerTitle('Registrarse'),
                Padding(
                  padding: const EdgeInsets.only(top: 80, left: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const ContainerLabelForm('CONTRASEÑA'),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                              height: 45,
                              width: 270,
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
                                obscureText: !_password1Visible,
                                controller: _passwordController,
                                keyboardType: TextInputType.visiblePassword,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      // Based on passwordVisible state choose the icon
                                      !_password1Visible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      // Update the state i.e. toogle the state of passwordVisible variable
                                      setState(() {
                                        _password1Visible = !_password1Visible;
                                      });
                                    },
                                  ),
                                  border: InputBorder.none,
                                  hintText: 'Introduzca la contraseña',
                                  hintStyle: const TextStyle(
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
                      const ContainerLabelForm('CONFIRMAR CONTRASEÑA'),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          height: 45,
                          width: 340,
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
                            controller: _confirmPasswordController,
                            focusNode: _focusNode1,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: !_password2Visible,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  !_password2Visible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                    _password2Visible = !_password2Visible;
                                  });
                                },
                              ),
                              border: InputBorder.none,
                              hintText: 'Introduzca de nuevo la contraseña',
                              hintStyle: const TextStyle(
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
                    padding: const EdgeInsets.only(top: 160),
                    child: Container(
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                      ),
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        controller: _confirmPasswordController,
                        focusNode: _focusNode2,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: !_password2Visible,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              !_password2Visible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              // Update the state i.e. toogle the state of passwordVisible variable
                              setState(() {
                                _password2Visible = !_password2Visible;
                              });
                            },
                          ),
                          border: InputBorder.none,
                          hintText: 'Introduzca de nuevo la contraseña',
                          hintStyle: const TextStyle(
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
                        Boton1(
                          "VOLVER",
                          onPressed: () {
                            Navigator.pop(context, _r);
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 200),
                          child: Boton1(
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
      ),
    );
  }
}
