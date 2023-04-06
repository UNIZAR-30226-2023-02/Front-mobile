// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Api/api.dart';
import 'package:flutter_application_1/Interfaz/Menu/homeMenu.dart';
import 'package:flutter_application_1/Interfaz/InicioSesion/Estilo/index.dart';

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
  String _usuario = "", _contrasenya = "";
  String _errorUsuario = "", _errorContrasena = "";
  bool _errorUsuarioVisible = false, _errorContrasenaVisible = false;

  void _comprobarDatos(BuildContext context) async {
    if (_userController.text == "") {
      setState(() {
        _errorUsuarioVisible = true;
        _errorUsuario =
            "El nombre de usuario esta vacío.\nPor favor, introduzca un nombre de usuario";
        _errorContrasenaVisible = false;
        _passwordController.text = "";
      });
    } else if (_passwordController.text == "") {
      setState(() {
        _errorUsuarioVisible = false;
        _errorContrasenaVisible = true;
        _errorContrasena =
            "La contraseña esta vacía.\nPor favor, introduzca la contraseña";
      });
    } else {
      _errorUsuarioVisible = false;
      _errorContrasenaVisible = false;
    }

    if (!_errorContrasenaVisible && !_errorUsuarioVisible) {
      print("Campos no vacíos\n");
      _formKey.currentState!.save();
      Future<LoginUserResponse> f =
          iniciarSesionUsuario(LoginUserPetition(_usuario, _contrasenya));
      LoginUserResponse r = await f;
      if (r.OK) {
        // ignore: use_build_context_synchronously
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeMenu()));
      } else {
        if (r.error_username != "") {
          setState(() {
            _errorUsuarioVisible = true;
            _errorUsuario =
                "El nombre de usuario introducido no existe.\nPor favor, introduzca otro";
            _errorContrasenaVisible = false;
            _userController.text = "";
            _passwordController.text = "";
          });
        } else {
          if (r.error_password != "") {
            setState(() {
              _errorUsuarioVisible = false;
              _errorContrasenaVisible = true;
              _errorContrasena =
                  "La contraseña introducida no es correcta.\nPor favor, introdúzcala de nuevo";
            });
          } else {
            setState(() {
              _errorUsuarioVisible = false;
              _errorContrasenaVisible = false;
            });
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Container(
                alignment: Alignment.topCenter,
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.all(16.0),
                child: const Text(
                  'Iniciar sesión',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFc9c154),
                    fontFamily: "Baskerville",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100, left: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ContainerLabelForm('USUARIO'),
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
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10),
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
                                  if (!_errorUsuarioVisible) {
                                    _usuario = value!;
                                  }
                                },
                                style: const TextStyle(color: Colors.white),
                              ),
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
                          ContainerLabelForm('CONTRASEÑA'),
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
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10),
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
                                    if (!_errorContrasenaVisible) {
                                      _contrasenya = value!;
                                    }
                                  },
                                  style: const TextStyle(color: Colors.white),
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
              Padding(
                padding: const EdgeInsets.only(left: 30, top: 210),
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
