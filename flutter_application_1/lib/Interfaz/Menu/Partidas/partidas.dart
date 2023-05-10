// ignore: file_names
// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Interfaz/Menu/index.dart';

import '../../../../Data_types/sesion.dart';
import '../home.dart';

//ignore: must_be_immutable
class Partidas extends StatelessWidget {
  const Partidas(this._s, {Key? key}) : super(key: key);
  final Sesion _s;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WillPopScope(
        onWillPop: () async {
          Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Menu(_s)),
                (Route<dynamic> route) => false);
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
                          padding: const EdgeInsets.only(bottom: 50),
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
                      Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 60),
                          child: SizedBox(
                            width: constraints.maxWidth / 1.1,
                            height: constraints.maxHeight / 1.7,
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 20, left: 40),
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.deferToChild,
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CrearPartida(_s)),
                                        );
                                      },
                                      child: Container(
                                        width: constraints.maxWidth / 3.2,
                                        height: constraints.maxHeight / 3.2,
                                        decoration: BoxDecoration(
                                          image: const DecorationImage(
                                            image: AssetImage('assets/mas.png'),
                                            fit: BoxFit.scaleDown,
                                          ),
                                          shape: BoxShape.circle,
                                          color: const Color(0xFF164966),
                                          border: Border.all(
                                              color: Colors.white, width: 2),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(top: 160, left: 80),
                                    child: Text(
                                      "CREAR PARTIDA",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontFamily: "Baskerville",
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 20, right: 40),
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.deferToChild,
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CrearPartida(_s)),
                                        );
                                      },
                                      child: Container(
                                        width: constraints.maxWidth / 3.2,
                                        height: constraints.maxHeight / 3.2,
                                        decoration: BoxDecoration(
                                          image: const DecorationImage(
                                            image:
                                                AssetImage('assets/lupa.png'),
                                            fit: BoxFit.scaleDown,
                                          ),
                                          shape: BoxShape.circle,
                                          color: const Color(0xFF164966),
                                          border: Border.all(
                                              color: Colors.white, width: 2),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(top: 160, right: 50),
                                    child: Text(
                                      "BUSCAR PARTIDAS",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontFamily: "Baskerville",
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
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
