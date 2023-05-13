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
  BuscarPartida(this._s, this._sP, this._sN, {Key? key}) : super(key: key);
  final Sesion _s;
  // ignore: non_constant_identifier_names
  List<DatosSalaPartida> _sP;
  List<String> _sN;

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _BuscarPartidaState createState() => _BuscarPartidaState(_s, _sP, _sN);
}

class _BuscarPartidaState extends State<BuscarPartida>
    with WidgetsBindingObserver {
  final _formKey = GlobalKey<FormState>();
  late Timer _timer;
  final Sesion _s;
  List<DatosSalaPartida> _sP;
  List<String> _sN;
  late List<String> _sF = <String>[];
  _BuscarPartidaState(this._s, this._sP, this._sN);

  bool _teclado = false, _datosSala = false, _isFocus = false;

  final TextEditingController _gameSearchController = TextEditingController();
  late ValueNotifier _cambios;
  final FocusNode _focusNode = FocusNode();

  String _filtro = "";

  @override
  void initState() {
    _filtrarSalas();
    _timer = Timer.periodic(const Duration(milliseconds: 3000), (timer) {
      _buscarSalas();
    });
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _teclado = false;
        _focusNode.unfocus();
        setState(() {});
      }
    });

    _cambios = ValueNotifier<String>(_gameSearchController.text);
    _cambios.addListener(() {
      _filtro = _cambios.value;
      _filtrarSalas();
      setState(() {});
    });
    _gameSearchController.addListener(() {
      _cambios.value = _gameSearchController.text;
    });
    super.initState();
  }

  @override
  void dispose() {
    print("dispose");
    _gameSearchController.dispose();
    _focusNode.dispose();
    _cambios.dispose();
    _timer.cancel();
    super.dispose();
  }

  _filtrarSalas() {
    _sF = _sN.where((element) => element.contains(_filtro)).toList();
  }

  _buscarSalas() async {
    Future<ObtenerSalasResponse> f = obtenerSalas(
        ObtenerSalasPetition(), _s.getField(SesionFieldsCodes.token));
    ObtenerSalasResponse r = await f;
    if (r.OK) {
      _sP = r.salas;
      _sN = r.nombreSalas;
      _filtrarSalas();
      setState(() {});
    }
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
                    padding: const EdgeInsets.only(top: 15),
                    child: _teclado
                        ? Align(
                            alignment: Alignment.topCenter,
                            child: SizedBox(
                              width: constraints.maxWidth / 4,
                              height: constraints.maxHeight / 9,
                              child: TextFormField(
                                controller: _gameSearchController,
                                focusNode: _focusNode,
                                keyboardType: TextInputType.visiblePassword,
                                decoration: const InputDecoration(
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                ),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                        : Container(
                            alignment: Alignment.topCenter,
                            padding: const EdgeInsets.only(top: 10),
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
                        _teclado = true;
                        _isFocus = true;
                        _focusNode.requestFocus();
                        setState(() {});
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
                                  itemCount: _sF.length,
                                  separatorBuilder: (context, index) =>
                                      const Divider(
                                    color: Colors.grey,
                                    thickness: 1.5,
                                  ),
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Text("Sala:\t ${_sF[index]}"),
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
