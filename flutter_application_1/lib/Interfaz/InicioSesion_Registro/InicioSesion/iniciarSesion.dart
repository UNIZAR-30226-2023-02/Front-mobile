// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Api/api.dart';
import 'package:flutter_application_1/Interfaz/InicioSesion_Registro/index.dart';
import 'package:flutter_application_1/Interfaz/Menu/homeMenu.dart';
import 'package:flutter_application_1/Interfaz/InicioSesion_Registro/Estilo/index.dart';

import '../../../Data_types/sesion.dart';

class InicioSesion extends StatefulWidget {
  const InicioSesion({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _InicioSesionState createState() => _InicioSesionState();
}

class _InicioSesionState extends State<InicioSesion> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _usuario = "", _contrasena = "";
  String _errorUsuario = "", _errorContrasena = "";
  bool _errorUsuarioVisible = false, _errorContrasenaVisible = false;

  void _comprobarDatos(BuildContext context) async {
    _formKey.currentState!.save();
    Future<LoginUserResponse> f =
        iniciarSesionUsuario(LoginUserPetition(_usuario, _contrasena));
    LoginUserResponse r = await f;
    if (r.OK) {
      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => IniciandoSesion(Sesion(
                  usuario: _usuario, token: r.token),_contrasena)),
          (Route<dynamic> route) => false);
    } else {
      if (r.error_username != "") {
        _errorUsuarioVisible = true;
        _errorUsuario = r.error_username;
      } else {
        _errorUsuarioVisible = false;
      }

      if (r.error_password != "") {
        _errorContrasenaVisible = true;
        _errorContrasena = r.error_password;
      } else {
        _errorContrasenaVisible = false;
      }
      setState(() {});
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
              const ContainerTitle('Iniciar sesión'),
              Padding(
                padding: const EdgeInsets.only(top: 110, left: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const ContainerLabelForm('USUARIO'),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
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
                              controller: _userController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Ingrese su usuario',
                                hintStyle: TextStyle(
                                    fontFamily: "Baskerville",
                                    fontSize: 18.0,
                                    color: Colors.white),
                              ),
                              onSaved: (value) {
                                _usuario = value!;
                              },
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 70),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const ContainerLabelForm('CONTRASEÑA'),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Container(
                              height: 45,
                              width: 250,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                                color: Colors.white.withOpacity(0),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: TextFormField(
                                controller: _passwordController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Ingrese la contraseña',
                                  hintStyle: TextStyle(
                                      fontFamily: "Baskerville",
                                      fontSize: 18.0,
                                      color: Colors.white),
                                ),
                                onSaved: (value) {
                                  _contrasena = value!;
                                },
                                style: const TextStyle(color: Colors.white),
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
                padding: const EdgeInsets.only(left: 30, top: 220),
                child: Stack(
                  children: [
                    Visibility(
                      visible: _errorUsuarioVisible,
                      child: Stack(
                        children: [
                          const ContainerError1(),
                          Padding(
                            padding: const EdgeInsets.only(),
                            child: SizedBox(
                              width: 300,
                              height: 60,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, top: 15),
                                child: Text(_errorUsuario,
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
                    Padding(
                      padding: const EdgeInsets.only(left: 320),
                      child: Visibility(
                        visible: _errorContrasenaVisible,
                        child: Stack(
                          children: [
                            const ContainerError1(),
                            Padding(
                              padding: const EdgeInsets.only(),
                              child: SizedBox(
                                width: 300,
                                height: 60,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 15, top: 15),
                                  child: Text(_errorContrasena,
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
                    ),
                  ],
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
                          Navigator.pop(context);
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 200),
                        child: Boton1(
                          "Entrar",
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

  @override
  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
