// ignore: file_names
// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Data_types/amigosUsuario.dart';
import 'package:flutter_application_1/Data_types/datosUsuario.dart';
import 'package:flutter_application_1/API/index.dart';
import 'package:flutter_application_1/Interfaz/Menu/Estilo/index.dart';
import 'package:flutter_application_1/Interfaz/Menu/homeMenu.dart';

import '../../../../Data_types/sesion.dart';
import '../home.dart';

//ignore: must_be_immutable
class Amigos extends StatefulWidget {
  Amigos(this._s, this._a, {Key? key}) : super(key: key);
  final Sesion _s;
  AmigosUsuario _a;

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _AmigosState createState() => _AmigosState(_s, _a);
}

class _AmigosState extends State<Amigos> {
  final _formKey = GlobalKey<FormState>();
  Sesion _s;
  DatosUsuario _dA = DatosUsuario(
      usuario: "Acher99",
      correoElectronico: "acheraldkadkajk",
      fechaNacimiento: "2002-02-01",
      telefonoMovil: "789676899");
  AmigosUsuario _a;
  _AmigosState(this._s, this._a);

  String _errorBuscarAmigo = "";
  bool _errorCampos = false;
  bool _datosAmigo = false;
  bool _anadirAmigo = false;

  bool _isKeyboardVisible = false;

  final TextEditingController _friendSearchController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _friendSearchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void conseguirDatosAmigo(int index) async {
    /*Future<DatosUsuarioResponse> f = obtenerDatosUsuario(
        DatosUsuarioPetition(_s.getField(SesionFieldsCodes.token)));
    DatosUsuarioResponse r = await f;*/
    _dA.setField(DatosUsuarioFieldsCodes.usuario, _a.amigos[index]);
  }

  void anadirAmigo() {
    String amigo = _friendSearchController.text;
    if (amigo == "") {
    } else if (_a.amigos.contains(amigo)) {
    } else if (_a.amigos.contains(amigo)) {
    } else {
      _a.amigos.add(amigo);
    }
  }

  void eliminarAmigo() {
    _a.amigos.remove(_dA.getField(DatosUsuarioFieldsCodes.usuario));
  }

  void _comprobarDatos(BuildContext context) async {}

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
                    child: Align(
                      alignment: Alignment.center,
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: Container(
                              width: constraints.maxWidth / 1.3,
                              height: constraints.maxHeight / 1.8,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: const Color(0xFFc9c154),
                                  width: 10,
                                ),
                              ),
                              child: ListView.separated(
                                itemCount: _a.amigos.length,
                                separatorBuilder: (context, index) =>
                                    const Divider(
                                  color: Colors.grey,
                                  thickness: 1.5,
                                ),
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(_a.amigos[index]),
                                    onLongPress: () {
                                      _datosAmigo = true;
                                      conseguirDatosAmigo(index);
                                      setState(() {});
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30, left: 150),
                  child: Boton1(
                    "VOLVER",
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => Menu(_s)),
                          (Route<dynamic> route) => false);
                    },
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30, left: 380),
                  child: Boton1(
                    "AÑADIR AMIGO",
                    onPressed: () {
                      _anadirAmigo = true;
                      setState(() {});
                    },
                  ),
                ),
              ),
              LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return Visibility(
                    visible: _anadirAmigo,
                    child: Container(
                      height: constraints.maxHeight,
                      width: constraints.maxWidth,
                      decoration: const BoxDecoration(color: Color(0x80444444)),
                      margin: const EdgeInsets.only(top: 0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Container(
                                width: constraints.maxWidth / 1.55,
                                height: constraints.maxHeight / 1.7,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF164966),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 20),
                                        child: Boton1(
                                          "AÑADIR",
                                          onPressed: () {
                                            anadirAmigo();
                                          },
                                        ),
                                      ),
                                    ),
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
                                      padding: const EdgeInsets.only(left: 390),
                                      child: IconButton(
                                          iconSize: 31,
                                          icon: const Icon(
                                            Icons.close,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            _anadirAmigo = false;
                                            setState(() {});
                                          }),
                                    ),
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 60),
                                        child: Container(
                                          height: 60,
                                          width: 370,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                              color: Colors.white,
                                              width: 2,
                                            ),
                                          ),
                                          child: TextFormField(
                                            controller: _friendSearchController,
                                            keyboardType:
                                                TextInputType.visiblePassword,
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              hintText:
                                                  'Introduzca el nombre de usuario a añadir',
                                              hintStyle: TextStyle(
                                                  fontFamily: "Baskerville",
                                                  fontSize: 16.0,
                                                  color: Colors.white),
                                            ),
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),
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
                },
              ),
              LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return Visibility(
                    visible: _datosAmigo,
                    child: Container(
                      height: constraints.maxHeight,
                      width: constraints.maxWidth,
                      decoration: const BoxDecoration(color: Color(0x80444444)),
                      margin: const EdgeInsets.only(top: 0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 25),
                              child: Container(
                                width: constraints.maxWidth / 1.75,
                                height: constraints.maxHeight / 1.3,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF164966),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              width: constraints.maxWidth / 2,
                                              child: Text(
                                                "Datos de ${_dA.getField(DatosUsuarioFieldsCodes.usuario)}",
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontFamily: "Georgia"),
                                              ),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.only(top: 5),
                                              child: Divider(
                                                color: Colors.white,
                                                thickness: 1.5,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
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
                                      padding: const EdgeInsets.only(left: 340),
                                      child: IconButton(
                                          iconSize: 31,
                                          icon: const Icon(
                                            Icons.close,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            _datosAmigo = false;
                                            setState(() {});
                                          }),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 60),
                                      child: SizedBox(
                                        height: constraints.maxHeight / 2.3,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 0, left: 30),
                                                child: ContainerDatosRegistro(
                                                  "Correo electrónico: ",
                                                  _dA.getField(
                                                      DatosUsuarioFieldsCodes
                                                          .correoElectronico),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 30, top: 40),
                                                child: ContainerDatosRegistro(
                                                  "Fecha de nacimiento :",
                                                  _dA.getField(
                                                      DatosUsuarioFieldsCodes
                                                          .fechaNacimiento),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 30, top: 40),
                                                child: ContainerDatosRegistro(
                                                  "Número de teléfono :",
                                                  _dA.getField(
                                                      DatosUsuarioFieldsCodes
                                                          .telefonoMovil),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(top: 245),
                                      child: Divider(
                                        color: Colors.white,
                                        thickness: 1.5,
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 5),
                                        child: Boton1(
                                          "Eliminar de amigos",
                                          onPressed: () {
                                            eliminarAmigo();
                                            _datosAmigo = false;
                                            setState(() {});
                                          },
                                        ),
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
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
