// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Api/api.dart';
import 'package:flutter_application_1/Interfaz/InicioSesion/index.dart';
import 'package:flutter_application_1/Interfaz/Menu/homeMenu.dart';
import 'package:flutter_application_1/Data_types/registro.dart';
import 'package:flutter_application_1/Interfaz/InicioSesion/Estilo/index.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class Registrarse3 extends StatefulWidget {
  Registro r;
  Registrarse3(this.r, {Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _Registrarse3State createState() => _Registrarse3State(r);
}

class _Registrarse3State extends State<Registrarse3>
    with WidgetsBindingObserver {
  Registro r;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();

  String _nombre = "", _fechaNacimiento = "";
  String _errorNombre = "", _errorFechaNacimiento = "";
  bool _errorNombreVisible = false, _errorFechaNacimientoVisible = false;

  _Registrarse3State(this.r);

  bool _isKeyboardVisible = false;
  bool _isVisible = false;
  bool _isFocus1 = false, _isFocus2 = false;
  final _focusNode1 = FocusNode(), _focusNode2 = FocusNode();

  @override
  void initState() {
    super.initState();
    if (r.getField(RegistroFieldsCodes.nombre) != "") {
      _nameController.text = r.getField(RegistroFieldsCodes.nombre);
    }
    if (r.getField(RegistroFieldsCodes.fechaNacimiento) != "") {
      _birthDateController.text =
          r.getField(RegistroFieldsCodes.fechaNacimiento);
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
    _nameController.dispose();
    _birthDateController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    _focusNode1.removeListener(_handleFocus1Change);
    _focusNode1.dispose();
    _focusNode2.removeListener(_handleFocus2Change);
    _focusNode2.dispose();
    super.dispose();
  }

  bool fechaValida(String fecha) {
    try {
      final dateformat = DateFormat('yyyy/MM/dd');
      dateformat.parseStrict(fecha);
      return true;
    } catch (e) {
      return false;
    }
  }

  void _comprobarDatos(BuildContext context) async {
    _formKey.currentState!.save();
    if (_nombre == "") {
      _errorNombreVisible = true;
      _errorNombre = "El nombre está vacío.\nPor favor, introduzca el nombre.";
    } else {
      _errorNombreVisible = false;
      r.setField(RegistroFieldsCodes.nombre, _nombre);
    }

    if (_fechaNacimiento == "") {
      _errorFechaNacimientoVisible = true;
      _errorFechaNacimiento =
          "La fecha de nacimiento está vacío.\nPor favor, introduzca la fecha.";
      setState(() {});
    } else {
      Future<RegistroUserResponse> f = registroUsuario(
          RegistroUserPetition("", "", "", _fechaNacimiento, "", ""));
      RegistroUserResponse re = await f;
      if (re.error_fecha != "") {
        _errorFechaNacimientoVisible = true;
        _errorFechaNacimiento =
            "La fecha de nacimiento no es váida.\nPor favor, introduzca una fecha válida.";
        setState(() {});
      } else {
        _errorFechaNacimientoVisible = false;
        r.setField(RegistroFieldsCodes.fechaNacimiento, _fechaNacimiento);
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
                        ContainerLabelForm('NOMBRE'),
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
                              controller: _nameController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Introduzca su nombre',
                                hintStyle: TextStyle(
                                    fontFamily: "Baskerville",
                                    fontSize: 16.0,
                                    color: Colors.white),
                              ),
                              onSaved: (value) {
                                _nombre = value!;
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
                    ContainerLabelForm('FECHA DE NACIMIENTO'),
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
              ),
              Padding(
                padding: const EdgeInsets.only(left: 350, top: 110),
                child: Stack(
                  children: [
                    Visibility(
                      visible: _errorNombreVisible,
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
                                child: Text(_errorNombre,
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
                      visible: _errorFechaNacimientoVisible,
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
                  padding: const EdgeInsets.only(top: 200),
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
