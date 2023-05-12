import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_application_1/Data_types/index.dart';
import 'package:flutter_application_1/Interfaz/Menu/index.dart';

import '../../../API/index.dart';
import '../../InicioSesion_Registro/index.dart';
import 'package:flutter_application_1/Interfaz/Menu/Estilo/index.dart';

class DarDeBaja extends StatefulWidget {
  const DarDeBaja(this._s, {Key? key}) : super(key: key);
  final Sesion _s;

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => _DarDeBajaState(_s);
}

class _DarDeBajaState extends State<DarDeBaja> {
  _DarDeBajaState(this._s);
  final Sesion _s;
  bool _errorBaja = false, _bajaCompletada = false;

  _darseDeBaja() async {
    Future<DarDeBajaUsuarioResponse> f = darDeBajaUsuario(
        DarDeBajaUsuarioPetition(), _s.getField(SesionFieldsCodes.token));
    DarDeBajaUsuarioResponse r = await f;
    if (r.OK) {
      _bajaCompletada = true;
    } else {
      _errorBaja = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_errorBaja) {
          _errorBaja = false;
          setState(() {});
        } else if (_bajaCompletada) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Home()),
              (Route<dynamic> route) => false);
        } else {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Menu(_s)),
              (Route<dynamic> route) => false);
        }
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          //margin: EdgeInsets.symmetric(horizontal: w*0.01,vertical: h*0.01 ),
          // ignore: prefer_const_constructors
          decoration: BoxDecoration(
            image: const DecorationImage(
                image: AssetImage('assets/tapete.png'), fit: BoxFit.fill),
          ),
          // ignore: prefer_const_constructors
          child: Stack(
            children: [
              Container(
                alignment: Alignment.topCenter,
                margin: const EdgeInsets.only(
                  top: 40,
                ),
                child: const Text(
                  "Darse de baja",
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFc9c154),
                    fontFamily: "Baskerville",
                  ),
                ),
              ),
              LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 140),
                          child: SizedBox(
                            height: constraints.maxHeight / 1.5,
                            width: constraints.maxWidth / 1.5,
                            child: const Text(
                              "¿Desea dar de baja su cuenta en TrivialB2B?",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 28.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: "Baskerville",
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 0, top: 160),
                          child: Stack(
                            children: [
                              Boton1(
                                "NO",
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Menu(_s)),
                                      (Route<dynamic> route) => false);
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 200),
                                child: Boton1(
                                  "SI",
                                  onPressed: () {
                                    _darseDeBaja();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      _errorBaja ? Container(
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
                                  width: constraints.maxWidth / 2,
                                  height: constraints.maxHeight / 2.5,
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
                                          padding:
                                              const EdgeInsets.only(top: 20),
                                          child: SizedBox(
                                            height: constraints.maxHeight / 4.5,
                                            width: constraints.maxWidth / 2.3,
                                            child: const Text(
                                              "No se ha podido dar de baja la cuenta",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Color(0xFFb13636),
                                                  fontWeight: FontWeight.bold,
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
                                              const EdgeInsets.only(bottom: 10),
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
                                                      border: Border.all(
                                                          color: Colors.white,
                                                          width: 2),
                                                    ),
                                                  ),
                                                ),
                                                TextButton(
                                                  style: TextButton.styleFrom(
                                                    foregroundColor:
                                                        Colors.white,
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
                                                    _errorBaja = false;
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
                        ) : const SizedBox.shrink(),
                      _bajaCompletada ? Container(
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
                                  width: constraints.maxWidth / 2,
                                  height: constraints.maxHeight / 2.5,
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
                                          padding:
                                              const EdgeInsets.only(top: 20),
                                          child: SizedBox(
                                            height: constraints.maxHeight / 4.5,
                                            width: constraints.maxWidth / 2.3,
                                            child: const Text(
                                              "Se ha dado de baja su cuenta correctamente",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Color(0xFF3dce00),
                                                  fontWeight: FontWeight.bold,
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
                                              const EdgeInsets.only(bottom: 10),
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
                                                      border: Border.all(
                                                          color: Colors.white,
                                                          width: 2),
                                                    ),
                                                  ),
                                                ),
                                                TextButton(
                                                  style: TextButton.styleFrom(
                                                    foregroundColor:
                                                        Colors.white,
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
                                                    Navigator
                                                        .pushAndRemoveUntil(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        Home()),
                                                            (Route<dynamic>
                                                                    route) =>
                                                                false);
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
                        ) : const SizedBox.shrink(),
                    ],
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
