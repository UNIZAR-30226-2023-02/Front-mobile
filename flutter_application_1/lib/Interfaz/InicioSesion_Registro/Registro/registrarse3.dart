// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Api/api.dart';
import 'package:flutter_application_1/Interfaz/InicioSesion_Registro/index.dart';
import 'package:flutter_application_1/Data_types/registro.dart';
import 'package:flutter_application_1/Interfaz/InicioSesion_Registro/Estilo/index.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

//ignore: must_be_immutable
class Registrarse3 extends StatefulWidget {
  Registro r;

  List<bool> _quesitos;
  Registrarse3(this.r, this._quesitos, {Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _Registrarse3State createState() => _Registrarse3State(r, _quesitos);
}

class _Registrarse3State extends State<Registrarse3>
    with WidgetsBindingObserver {
  Registro r;

  List<bool> _quesitos;
  int _nQuesitos = 0;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();

  String _telefonoMovil = "", _fechaNacimiento = "";
  String _errorTelefonoMovil = "", _errorFechaNacimiento = "";
  bool _errorTelefonoMovilVisible = false, _errorFechaNacimientoVisible = false;

  _Registrarse3State(this.r, this._quesitos);

  bool _isKeyboardVisible = false;
  bool _isVisible = false;
  bool _isFocus1 = false, _isFocus2 = false;
  final _focusNode1 = FocusNode(), _focusNode2 = FocusNode(),_focusNode3 = FocusNode();

  @override
  void initState() {
    super.initState();
    if (r.getField(RegistroFieldsCodes.telefonoMovil) != "") {
      _phoneNumberController.text =
          r.getField(RegistroFieldsCodes.telefonoMovil);
    }
    if (r.getField(RegistroFieldsCodes.fechaNacimiento) != "") {
      _birthDateController.text =
          r.getField(RegistroFieldsCodes.fechaNacimiento);
    }

    _nQuesitos = _quesitos.where((element) => element == true).length;
    setState(() {});
    WidgetsBinding.instance.addObserver(this);
    _focusNode1.addListener(_handleFocus1Change);
    _focusNode2.addListener(_handleFocus2Change);
    _focusNode3.addListener(_handleFocus3Change);
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
      _isVisible = false;
      _focusNode1.unfocus();
      _focusNode2.unfocus();
      setState(() {
      });
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
    _phoneNumberController.dispose();
    _birthDateController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    _focusNode1.removeListener(_handleFocus1Change);
    _focusNode1.dispose();
    _focusNode2.removeListener(_handleFocus2Change);
    _focusNode2.dispose();
    _focusNode3.removeListener(_handleFocus2Change);
    _focusNode3.dispose();
    super.dispose();
  }

  void _comprobarDatos(BuildContext context) async {
    _formKey.currentState!.save();

    r.setField(RegistroFieldsCodes.fechaNacimiento, _fechaNacimiento);
    r.setField(RegistroFieldsCodes.telefonoMovil, _telefonoMovil);

    Future<RegistroUserResponse> f = registroUsuario(
        RegistroUserPetition("", "", "", _fechaNacimiento, "", _telefonoMovil));
    RegistroUserResponse re = await f;

    if (re.error_telefono != "") {
      _errorTelefonoMovilVisible = true;
      _errorTelefonoMovil =
          "${re.error_telefono}\nPor favor, introdúzcalo de nuevo.";
      _quesitos[4] = false;
    } else {
      _errorTelefonoMovilVisible = false;
      _quesitos[4] = true;
    }

    if (re.error_fecha != "") {
      _errorFechaNacimientoVisible = true;
      _errorFechaNacimiento =
          "${re.error_fecha}\nPor favor, introdúzcala de nuevo.";

      _quesitos[5] = false;
    } else {
      _errorFechaNacimientoVisible = false;
      _quesitos[5] = true;
    }

    _nQuesitos = _quesitos.where((element) => element == true).length;
    setState(() {});

    if (!_errorTelefonoMovilVisible && !_errorFechaNacimientoVisible) {
      // ignore: use_build_context_synchronously
      r = await Navigator.push(context,
          MaterialPageRoute(builder: (context) => ConfirmarRegistro(r)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, r);
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
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30, right: 40),
                  child: Text(
                    "$_nQuesitos/6",
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xfff7f6f6),
                      fontFamily: "Georgia",
                    ),
                  ),
                ),),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50, right: 30),
                  child: ContainerQuesitos(_quesitos),
                ),),
                const ContainerTitle('Registrarse'),
                Padding(
                  padding: const EdgeInsets.only(top: 70, left: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const ContainerLabelForm('TELEFONO'),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                              height: 45,
                              width: 300,
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
                                controller: _phoneNumberController,
                                focusNode: _focusNode3,
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
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 180, left: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ContainerLabelForm('FECHA DE NACIMIENTO'),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          height: 45,
                          width: 260,
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
                              controller: _birthDateController,
                              focusNode: _focusNode1,
                              keyboardType: TextInputType.datetime,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Formato : YYYY-MM-DD',
                                hintStyle: TextStyle(
                                    fontFamily: "Baskerville",
                                    fontSize: 16.0,
                                    color: Colors.white),
                              ),
                              onSaved: (value) {
                                _fechaNacimiento = value!;
                              },
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),),
                Padding(
                  padding: const EdgeInsets.only(left: 370, top: 100),
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
                Padding(
                  padding: const EdgeInsets.only(left: 370, top: 210),
                  child: Stack(
                    children: [
                      Visibility(
                        visible: _errorFechaNacimientoVisible,
                        child: Stack(
                          children: [
                            const ContainerError2(),
                            Padding(
                              padding: const EdgeInsets.only(),
                              child: SizedBox(
                                width: 280,
                                height: 60,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 15, top: 15),
                                  child: Text(_errorFechaNacimiento,
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
                    padding: const EdgeInsets.only(top: 155),
                    child: Container(
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                      ),
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        controller: _birthDateController,
                        focusNode: _focusNode2,
                        keyboardType: TextInputType.datetime,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'YYYY-MM-DD',
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
                Align(
                  alignment: Alignment.bottomCenter,
                  child: 
                  Padding(padding: const EdgeInsets.only(bottom: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Boton1(
                          "VOLVER",
                          onPressed: () {
                            Navigator.pop(context, r);
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
