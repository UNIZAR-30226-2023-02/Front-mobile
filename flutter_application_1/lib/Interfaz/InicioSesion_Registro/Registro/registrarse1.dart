// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Api/api.dart';
import 'package:flutter_application_1/Interfaz/InicioSesion_Registro/Registro/registrarse2.dart';
import 'package:flutter_application_1/Interfaz/Menu/homeMenu.dart';
import 'package:flutter_application_1/Data_types/registro.dart';
import 'package:flutter_application_1/Interfaz/InicioSesion_Registro/Estilo/index.dart';
import 'package:http/http.dart';

class Registrarse1 extends StatefulWidget {
  List<bool> quesitos = List<bool>.filled(6, false);
  Registrarse1({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _Registrarse1State createState() => _Registrarse1State(Registro(), quesitos);
}

class _Registrarse1State extends State<Registrarse1>
    with WidgetsBindingObserver {
  Registro _r;
  List<bool> _quesitos;
  int _nQuesitos = 0;
  _Registrarse1State(this._r, this._quesitos);
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();
  String _usuario = "", _correoElectronico = "";
  String _errorUsuario = "", _errorCorreoElectronico = "";
  bool _errorUsuarioVisible = false, _errorCorreoElectronicoVisible = false;

  bool _isKeyboardVisible = false;
  bool _isVisible = false;
  bool _isFocus1 = false, _isFocus2 = false;
  final _focusNode1 = FocusNode(), _focusNode2 = FocusNode();

  @override
  void initState() {
    super.initState();
    if (_r.getField(RegistroFieldsCodes.usuario) != "") {
      _userController.text = _r.getField(RegistroFieldsCodes.usuario);
      _mailController.text = _r.getField(RegistroFieldsCodes.correoElectronico);
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
    _userController.dispose();
    _mailController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    _focusNode1.removeListener(_handleFocus1Change);
    _focusNode1.dispose();
    _focusNode2.removeListener(_handleFocus2Change);
    _focusNode2.dispose();
    super.dispose();
  }

  void _comprobarDatos(BuildContext context) async {
    _formKey.currentState!.save();
    _r.setField(RegistroFieldsCodes.correoElectronico, _correoElectronico);
    _r.setField(RegistroFieldsCodes.usuario, _usuario);
    Future<RegistroUserResponse> f = registroUsuario(
        RegistroUserPetition(_usuario, "", "", "", _correoElectronico, ""));
    RegistroUserResponse re = await f;

    if (re.error_username != "") {
      _errorUsuarioVisible = true;
      _errorUsuario = "${re.error_username}\nPor favor, introdúzcalo de nuevo.";
      _quesitos[0] = false;
    } else {
      _errorUsuarioVisible = false;
      _quesitos[0] = true;
    }

    if (re.error_correo != "") {
      _errorCorreoElectronicoVisible = true;
      _errorCorreoElectronico =
          "${re.error_correo}\nPor favor, introdúzcalo de nuevo.";
      _quesitos[1] = false;
    } else {
      _errorCorreoElectronicoVisible = false;
      _quesitos[1] = true;
    }
    _nQuesitos = _quesitos.where((element) => element == true).length;
    setState(() {});

    if (!_errorUsuarioVisible && !_errorCorreoElectronicoVisible) {
      // ignore: use_build_context_synchronously
      _r = await Navigator.push(context,
          MaterialPageRoute(builder: (context) => Registrarse2(_r, _quesitos)));
      setState(() {
        _nQuesitos = _quesitos.where((element) => element == true).length;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
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
                                keyboardType: TextInputType.visiblePassword,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Introduzca el nombre de usuario',
                                  hintStyle: TextStyle(
                                      fontFamily: "Baskerville",
                                      fontSize: 16.0,
                                      color: Colors.white),
                                ),
                                onSaved: (value) {
                                  _usuario = value!;
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
                            keyboardType: TextInputType.visiblePassword,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Introduzca su correo electrónico',
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
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 350, top: 110),
                  child: Stack(
                    children: [
                      Visibility(
                        visible: _errorUsuarioVisible,
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
                                  child: Text(_errorUsuario,
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
                  padding: const EdgeInsets.only(left: 350, top: 230),
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
                        controller: _mailController,
                        focusNode: _focusNode2,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Introduzca su correo electrónico',
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
                        Boton1(
                          "VOLVER",
                          onPressed: () {
                            Navigator.pop(context);
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
