// ignore: file_names
// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Interfaz/Menu/index.dart';

import '../../../../Data_types/sesion.dart';
import '../home.dart';

//ignore: must_be_immutable
class Partidas extends StatefulWidget {
  Partidas(this._s, {Key? key}) : super(key: key);
  final Sesion _s;

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _PartidasState createState() => _PartidasState(_s);
}

class _PartidasState extends State<Partidas> {
  final _formKey = GlobalKey<FormState>();
  Sesion _s;
  _PartidasState(this._s);

  String _sErrorAnadirAmigo = "", _sErrorEliminarAmigo = "";
  bool _errorAnadirAmigo = false, _errorEliminarAmigo = false;
  bool _amigoEliminado = false;
  bool _amigoAnadido = false;
  bool _datosAmigo = false;
  bool _buscarPartida = true;

  final TextEditingController _gameSearchController = TextEditingController();

  void conseguirDatosAmigo(int index) async {}

  void anadirAmigoUsuario() async {}

  void eliminarAmigoUsuario() async {}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          // body: SingleChildScrollView (  //SOLUCION FONDO DE PANTALLA SE ESTRECHA AL SACAR TECLADO
          body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Container(
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/tapete.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: Boton1(
                            "MENU",
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Menu(_s)),
                                  (Route<dynamic> route) => false);
                            },
                          ),
                        ),
                      ),
                      Align(alignment: Alignment.topCenter,child: 
                      Padding(padding: const EdgeInsets.only(top: 80),child: Container(
                        width: constraints.maxWidth / 1.4,
                        height: constraints.maxHeight / 1.75,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white,
                            width: 4,
                          ),
                        ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 0),
                                child: Container(
                                  width: constraints.maxWidth / 2.7,
                                  height: constraints.maxHeight / 2.3,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: const Color(0xFF164966),
                                    border: Border.all(
                                        color: Colors.white, width: 2),
                                  ),
                                  child: SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CrearPartida(_s)),
                                          );
                                        },
                                        child: Image.asset(
                                          "assets/trivial_blanco.png",
                                          fit: BoxFit.contain,
                                        )),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),),
                      ),),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
