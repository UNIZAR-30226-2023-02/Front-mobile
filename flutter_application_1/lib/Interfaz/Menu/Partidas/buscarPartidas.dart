// ignore: file_names
// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Data_types/index.dart';
import 'package:flutter_application_1/API/index.dart';
import 'package:flutter_application_1/Interfaz/Menu/Estilo/index.dart';

import '../home.dart';

//ignore: must_be_immutable
class BuscarPartida extends StatefulWidget {
  BuscarPartida(this._s, this._sP, {Key? key}) : super(key: key);
  final Sesion _s;
  // ignore: non_constant_identifier_names
  List<DatosSalaPartida> _sP;

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _BuscarPartidaState createState() => _BuscarPartidaState(_s, _sP);
}

class _BuscarPartidaState extends State<BuscarPartida> {
  final _formKey = GlobalKey<FormState>();
  late Timer _timer;
  final Sesion _s;
  List<DatosSalaPartida> _sP;
  _BuscarPartidaState(this._s, this._sP);

  bool _datosPartida = false;
  bool _modoClasico = false, _modoEquipos = false, _modoTematica = false;

  final TextEditingController _gameSearchController = TextEditingController();

  String _errorCambioDatos = "";
  bool _errorCampos = false;
  bool _cambioRealizado = false;
  bool _cambioDatos = false;

  bool _passwordVisible = false;
  bool _partidaPublica = true;

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
      _focusNode5 = FocusNode(),
      _focusNode6 = FocusNode();

  @override
  void initState() {
    _timer = Timer(const Duration(milliseconds: 2000), buscarSalas);
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void buscarSalas() async {
    Future<ObtenerSalasResponse> f = obtenerSalas(
        ObtenerSalasPetition(), _s.getField(SesionFieldsCodes.token));
    ObtenerSalasResponse r = await f;
    if (r.OK) {
      _sP = r.salas;
    }
    setState(() {});
    _timer = Timer(const Duration(milliseconds: 2000), buscarSalas);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/tapete.png'),
            fit: BoxFit.fill,
            // contentMode = .ScaleAspectFill,
            // alignment: Alignment.topCenter,
          ),
        ),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Form(
              key: _formKey,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Container(
                      alignment: Alignment.topCenter,
                      child: const Text(
                        "Buscar Partidas",
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
                    padding: const EdgeInsets.only(top: 30, left: 500),
                    child: GestureDetector(
                      onTap: () {
                        print("hola");
                      },
                      behavior: HitTestBehavior.deferToChild,
                      child: Container(
                        width: constraints.maxWidth / 14,
                        height: constraints.maxHeight / 14,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/lupa.png'),
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 30, left: 50),
                      child: Boton1(
                        "VOLVER",
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 70),
                          child: Stack(
                            children: [
                              Container(
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
                                  padding:
                                      const EdgeInsets.only(top: 5, bottom: 5),
                                  itemCount: _sP.length,
                                  separatorBuilder: (context, index) =>
                                      const Divider(
                                    color: Colors.grey,
                                    thickness: 1.5,
                                  ),
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Text(
                                          "Sala:\t ${_sP[index].getField(DatosSalaPartidaFieldsCodes.nombre)}"),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
