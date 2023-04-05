// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Api/api.dart';
import 'package:flutter_application_1/Interfaz/InicioSesion/index.dart';
import 'package:flutter_application_1/Data_types/registro.dart';
import 'package:flutter_application_1/Interfaz/InicioSesion/Estilo/index.dart';

class ScaleRoute extends PageRouteBuilder {
  final Widget page;

  ScaleRoute({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              ScaleTransition(
            scale: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(animation),
            child: child,
          ),
        );
}

class FadeRoute<T> extends PageRouteBuilder<T> {
  final Widget page;

  FadeRoute({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}

class SlideRoute extends PageRouteBuilder {
  final Widget page;

  SlideRoute({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}

class Registrarse1 extends StatefulWidget {
  const Registrarse1({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _Registrarse1State createState() => _Registrarse1State();
}

class _Registrarse1State extends State<Registrarse1> {
  Registro r = Registro();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userController = TextEditingController();
  String _usuario = "";
  String _errorUsuario = "";
  bool _errorUsuarioVisible = false;

  void _comprobarDatos(BuildContext context) async {
    if (_userController.text == "") {
      setState(() {
        _errorUsuarioVisible = true;
        _errorUsuario =
            "El nombre de usuario esta vacío.\nPor favor, introduzca un nombre de usuario";
      });
    } else {
      _formKey.currentState!.save();
      Future<RegistroUserResponse> f =
          registroUsuario(RegistroUserPetition(_usuario, "", "", "", "", ""));
      RegistroUserResponse re = await f;
      if (re.error_username != "") {
        setState(() {
          _errorUsuarioVisible = true;
          _errorUsuario =
              "El nombre de usuario introducido ya existe.\nPor favor, introduzca otro nombre de usuario";
        });
      } else {
        r.setField(RegistroFieldsCodes.usuario, _usuario);
        // ignore: use_build_context_synchronously
        r = await Navigator.push(
            context, MaterialPageRoute(builder: (context) => Registrarse2(r)));
        setState(() {
          _errorUsuarioVisible = false;
          _userController.text = r.getField(RegistroFieldsCodes.usuario);
        });
      }
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
              ContainerTitle('Registrarse'),
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
                            width: 320,
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
                                  hintText: 'Introduzca el nombre de usuario',
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
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50, top: 210),
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
                      Boton(
                        "VOLVER",
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Visibility(
                        visible: true,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 180),
                          child: Boton(
                            "CONTINUAR",
                            onPressed: () {
                              _comprobarDatos(context);
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
  }

  @override
  void dispose() {
    _userController.dispose();
    super.dispose();
  }
}
