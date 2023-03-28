// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Api/api.dart';
import 'package:flutter_application_1/Interfaz/InicioSesion/registrarse2.dart';

class Registrarse extends StatefulWidget {
  const Registrarse({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RegistrarseState createState() => _RegistrarseState();
}

class _RegistrarseState extends State<Registrarse> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _usuario = "", _fecha = "";

  // ignore: non_constant_identifier_names
  // void Printear() {
  //   LoginUserResponse r =
  //       iniciarSesionUsuario(LoginUserPetition(_usuario, _contrasenya))
  //           as LoginUserResponse;
  //   // ignore: avoid_print
  //   print('Hola ${r.OK} ${r.token} ${r.error_username} ${r.error_password}');
  // }

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
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                'Registrarse',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFc9c154),
                  fontFamily: "Baskerville",
                ),
              ),
            ),

//TEXTO USUARIO-------------------------------------------------------------
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              margin: const EdgeInsets.only(right: 480, bottom: 5, top: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Usuario',
                      style: TextStyle(
                          fontSize: 24.0,
                          fontFamily: "Baskerville",
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              margin: const EdgeInsets.only(left: 60, right: 280),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
                color: Colors.white.withOpacity(0),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _userController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Ingrese su usuario',
                      hintStyle: TextStyle(
                          fontFamily: "Baskerville",
                          fontSize: 18.0,
                          color: Colors.white),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor ingresa tu nombre';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _usuario = value!;
                    },
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
//TEXTO FECHA-------------------------------------------------------------
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              margin: const EdgeInsets.only(right: 350, left: 20, bottom: 5, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Fecha de nacimiento',
                      style: TextStyle(
                          fontSize: 24.0,
                          fontFamily: "Baskerville",
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              margin: const EdgeInsets.only(left: 60, right: 280),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
                color: Colors.white.withOpacity(0),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Ingrese la fecha de nacimiento',
                      hintStyle: TextStyle(
                          fontFamily: "Baskerville",
                          fontSize: 18.0,
                          color: Colors.white),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor ingresa tu fecha de nacimiento';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _fecha = value!;
                    },
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
            Container(
              margin: const EdgeInsets.only(top: 0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                     Column(
                        children: [SizedBox(height: 5), BotonHome("VOLVER",onPressed: (){Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Registrarse()));})]),
                    Column(children: [
                      const SizedBox(height: 5),
                      Stack(
                        children: <Widget>[
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                gradient: const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: <Color>[
                                    Color(0xFFdee8eb),
                                    Color(0xFFb0c7d0)
                                  ],
                                  stops: [0.4, 1.0],
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: const Color(0xFF004461),
                              // padding: const EdgeInsets.all(16.0),
                              padding: const EdgeInsets.only(
                                  top: 4, bottom: 4, left: 15, right: 15),
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  fontFamily: "Georgia"),
                            ),
                            onPressed: () async {
                              // print("mirando estado");
                              // if (_formKey.currentState!.validate()) {
                              //   print("${_usuario} ${_contrasenya}");
                              //   _formKey.currentState!.save();

                              //   print("${_usuario} ${_contrasenya}");
                              //   Future<LoginUserResponse> f =
                              //       iniciarSesionUsuario(LoginUserPetition(
                              //           _usuario, _contrasenya));
                              //   LoginUserResponse r = await f;

                              //   print("Peticion");

                              //   print(
                              //       'Hola ${r.OK} ${r.token} ${r.error_username} ${r.error_password}');
                              // }
                              // ;
                              
                              if (_formKey.currentState!.validate()) {
                                //print("${_usuario} ${_fecha}"); //esto no lo imprime, sin embargo sin este if la variable no se envia bien a registrarse2
                                _formKey.currentState!.save();
                              }

                              Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Registrarse2(usuarioR1: _usuario, fechaR1: _fecha)
                                  ),
                              );
                            },
                            child: Text("CONTINUAR"),
                          ),
                        ],
                      )
                    ])
                  ]),
            ),
          ],
        ),
      ),
      // ),
    ));
  }

  @override
  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

class BotonHome extends StatelessWidget {
  final String textContrasenya;
  final VoidCallback onPressed;
  const BotonHome(String t, {Key? key, required this.onPressed})
      : textContrasenya = t,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: dead_code
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[Color(0xFFdee8eb), Color(0xFFb0c7d0)],
                  stops: [0.4, 1.0],
                ),
              ),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF004461),
              // padding: const EdgeInsets.all(16.0),
              padding:
                  const EdgeInsets.only(top: 4, bottom: 4, left: 15, right: 15),
              textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontFamily: "Georgia"),
            ),
            onPressed: onPressed,
            child: Text(textContrasenya),
          ),
        ],
      ),
    );
  }
}
