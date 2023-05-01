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
class Amigos extends StatefulWidget {
  Amigos(this._s,this._dU,this._dA, {Key? key}) : super(key: key);
  final Sesion _s;
  DatosUsuario _dU,_dA;

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _AmigosState createState() => _AmigosState(_s,_dU);
}

class _AmigosState extends State<Amigos> with WidgetsBindingObserver {
  final _formKey = GlobalKey<FormState>();
  Sesion _s;
  DatosUsuario _dU;
  late DatosUsuario _dA;
  _AmigosState(this._s,this._dU);

  String _errorCambioDatos = "";
  bool _errorCampos = false;
  bool _cambioRealizado = false;
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

  void conseguirDatosUsuario() async {
    Future<DatosUsuarioResponse> f = obtenerDatosUsuario(
        DatosUsuarioPetition(_s.getField(SesionFieldsCodes.token)));
    DatosUsuarioResponse r = await f;
  }


  void _comprobarDatos(BuildContext context) async {
    
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
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
          child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Container(
                    alignment: Alignment.topCenter,
                    child: const Text(
                      "Amigos",
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFc9c154),
                        fontFamily: "Baskerville",
                      ),
                    ),
                  ),
                ),
                LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return Visibility(
                      visible: true,
                      child: Container(
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
                                width: constraints.maxWidth / 1.25,
                                height: constraints.maxHeight / 1.5,
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
                                        padding: const EdgeInsets.only(top: 30),
                                        child: SizedBox(
                                          height: constraints.maxHeight / 3,
                                          width: constraints.maxWidth / 2,
                                          child: const Text(
                                            "Datos de ${}",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontFamily: "Georgia"),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 20),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          child: Stack(
                                            children: <Widget>[
                                              Positioned.fill(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                              TextButton(
                                                style: TextButton.styleFrom(
                                                  foregroundColor: Colors.white,
                                                  // padding: const EdgeInsets.all(16.0),
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 4,
                                                          bottom: 4,
                                                          left: 15,
                                                          right: 15),
                                                  textStyle: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                      fontFamily: "Georgia"),
                                                ),
                                                onPressed: () {
                                                  _cambioRealizado = false;
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
                      ),
                    );
                  },
                ),

              ],
            ),
          ),
      ),
    );
  }
}
