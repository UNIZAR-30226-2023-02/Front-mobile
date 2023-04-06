// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Api/api.dart';
import 'package:flutter_application_1/Interfaz/InicioSesion/index.dart';
import 'package:flutter_application_1/Interfaz/Menu/homeMenu.dart';
import 'package:flutter_application_1/Data_types/registro.dart';
import 'package:flutter_application_1/Interfaz/InicioSesion/Estilo/index.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class ConfirmarRegistro extends StatefulWidget {
  Registro r;
  ConfirmarRegistro(this.r, {Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _ConfirmarRegistroState createState() => _ConfirmarRegistroState(r);
}

class _ConfirmarRegistroState extends State<ConfirmarRegistro>
    with WidgetsBindingObserver {
  Registro r;

  _ConfirmarRegistroState(this.r);

  bool _DataVisible = false;

  void changeDataVisibility() {
    _DataVisible = !_DataVisible;
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
        child: Stack(
          children: [
            const ContainerTitle('Registrarse'),
            const Padding(
              padding: EdgeInsets.only(bottom: 100),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "¿Desea confirmar su registro?",
                  style: TextStyle(
                    fontSize: 26.0,
                    color: Colors.white,
                    fontFamily: "Baskerville",
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Align(
                alignment: Alignment.center,
                child: Boton2(
                  "Ver datos registro",
                  onPressed: () {},
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
                        Navigator.pop(context, r);
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 200),
                      child: Boton1(
                        "CONFIRMAR",
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: _DataVisible,
              child: Container(
                decoration: const BoxDecoration(color: Colors.transparent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
