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
    setState(() {});
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
                  onPressed: changeDataVisibility,
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
                        onPressed: () async {
                          r = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegistrandoUsuario(r)));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: _DataVisible,
              child: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(color: Colors.transparent),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: Container(
                        height: 330,
                        width: 300,
                        decoration: BoxDecoration(
                          color: const Color(0xFF164966),
                          border: Border.all(
                              color: const Color(0xFFc9c154), width: 2),
                        ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 20, right: 20),
                                child: Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: const Color(0xFFc9c154),
                                        width: 1),
                                  ),
                                ),
                              ),
                            ),
                            SingleChildScrollView(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 50, left: 30),
                                    child: ContainerDatosRegistro(
                                      "Nombre de usuario :",
                                      r.getField(RegistroFieldsCodes.usuario),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 30, top: 40),
                                    child: ContainerDatosRegistro(
                                      "Contraseña :",
                                      r.getField(
                                          RegistroFieldsCodes.contrasena),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 30, top: 40),
                                    child: ContainerDatosRegistro(
                                      "Fecha de nacimiento :",
                                      r.getField(
                                          RegistroFieldsCodes.fechaNacimiento),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 30, top: 40),
                                    child: ContainerDatosRegistro(
                                      "Correo electrónico :",
                                      r.getField(RegistroFieldsCodes
                                          .correoElectronico),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 30, top: 40, bottom: 30),
                                    child: ContainerDatosRegistro(
                                      "Número de teléfono :",
                                      r.getField(
                                          RegistroFieldsCodes.telefonoMovil),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 233, top: 12),
                              child: IconButton(
                                iconSize: 36,
                                icon: const Icon(
                                  Icons.close,
                                  color: Color(0xFFc9c154),
                                ),
                                onPressed: changeDataVisibility,
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
          ],
        ),
      ),
    );
  }
}
