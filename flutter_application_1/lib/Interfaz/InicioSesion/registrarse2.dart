// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Api/api.dart';
import 'package:flutter_application_1/Interfaz/InicioSesion/registrarse.dart';
import 'package:flutter_application_1/Interfaz/InicioSesion/registrarse3.dart';
class Registrarse2 extends StatefulWidget{
  String usuarioR1 = "";
  String fechaR1 = "";
  Registrarse2({Key? key, required this.usuarioR1, required this.fechaR1}) : super(key: key);
  
  
  @override
  // ignore: library_private_types_in_public_api
  _Registrarse2State createState() => _Registrarse2State(usuarioR2: usuarioR1, fechaR2: fechaR1);
}

class _Registrarse2State extends State<Registrarse2> {
  String usuarioR2 = "";
  String fechaR2 = "";
  _Registrarse2State({required this.usuarioR2, required this.fechaR2});
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _contrasenya = "", _contrasenya2 = "";

  // ignore: non_constant_identifier_names
  // void Printear() {
  //   LoginUserResponse r =<
  //       iniciarSesionUsuario(LoginUserPetition(_usuario, _contrasenya))
  //           as LoginUserResponse;
  //   // ignore: avoid_print
  //   print('Hola ${r.OK} ${r.token} ${r.error_username} ${r.error_password}');
  // }

  @override
  Widget build(BuildContext context) {
    print('arriba: ${usuarioR2}');
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
                // 'Registrarse',
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
              margin: const EdgeInsets.only(right: 440, bottom: 5, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Contraseña',
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
                      hintText: 'Ingrese su contraseña',
                      hintStyle: TextStyle(
                          fontFamily: "Baskerville",
                          fontSize: 18.0,
                          color: Colors.white),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor ingresa tu contraseña';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _contrasenya = value!;
                    },
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
//TEXTO CONTRASEÑA-------------------------------------------------------------
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              margin: const EdgeInsets.only(right: 350, left: 20, bottom: 5, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Repite la contraseña',
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
                      hintText: 'Ingrese la contraseña de nuevo',
                      hintStyle: TextStyle(
                          fontFamily: "Baskerville",
                          fontSize: 18.0,
                          color: Colors.white),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor ingresa tu contraseña';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _contrasenya2 = value!;
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
                                 _formKey.currentState!.save();
                              }

                              Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Registrarse3(usuarioR2: usuarioR2, fechaR2: fechaR2, contrasenyaR2: _contrasenya)
                              ),
                              );
                            
                              //print("holaaaa");
                              //print('usuario en reg2: ${usuarioR2}, fecha: ${fechaR2}');
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
