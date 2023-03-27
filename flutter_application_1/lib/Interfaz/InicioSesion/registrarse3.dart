// // ignore: file_names
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/Api/api.dart';
// import 'package:flutter_application_1/Interfaz/InicioSesion/registrarse2.dart';
// import 'package:flutter_application_1/Interfaz/Menu/home.dart';
// class Registrarse3 extends StatefulWidget {
//   const Registrarse3({Key? key}) : super(key: key);

//   @override
//   // ignore: library_private_types_in_public_api
//   _Registrarse3State createState() => _Registrarse3State();
// }

// class _Registrarse3State extends State<Registrarse3> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _userController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   String _correo = "", _telefono = "";

//   // ignore: non_constant_identifier_names
//   // void Printear() {
//   //   LoginUserResponse r =<
//   //       iniciarSesionUsuario(LoginUserPetition(_usuario, _contrasenya))
//   //           as LoginUserResponse;
//   //   // ignore: avoid_print
//   //   print('Hola ${r.OK} ${r.token} ${r.error_username} ${r.error_password}');
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         // body: SingleChildScrollView (  //SOLUCION FONDO DE PANTALLA SE ESTRECHA AL SACAR TECLADO
//         body: Container(
//       decoration: const BoxDecoration(
//         image: DecorationImage(
//           image: AssetImage('assets/tapete.png'),
//           fit: BoxFit.fill,
//           // contentMode = .ScaleAspectFill,
//           // alignment: Alignment.topCenter,
//         ),
//       ),
//       child: Form(
//         key: _formKey,
//         child: Column(
//           // mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               alignment: Alignment.center,
//               margin: const EdgeInsets.only(top: 20),
//               padding: const EdgeInsets.all(16.0),
//               child: const Text(
//                 'Registrarse',
//                 style: TextStyle(
//                   fontSize: 30.0,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xFFc9c154),
//                   fontFamily: "Baskerville",
//                 ),
//               ),
//             ),

// //TEXTO USUARIO-------------------------------------------------------------
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               margin: const EdgeInsets.only(right: 360, bottom: 5, top: 20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.only(left: 8.0),
//                     child: Text(
//                       'Correo electrónico',
//                       style: TextStyle(
//                           fontSize: 24.0,
//                           fontFamily: "Baskerville",
//                           color: Colors.white),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               margin: const EdgeInsets.only(left: 60, right: 280),
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   color: Colors.white,
//                   width: 2,
//                 ),
//                 color: Colors.white.withOpacity(0),
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   TextFormField(
//                     controller: _userController,
//                     decoration: const InputDecoration(
//                       border: InputBorder.none,
//                       hintText: 'Ingrese su correo electrónico',
//                       hintStyle: TextStyle(
//                           fontFamily: "Baskerville",
//                           fontSize: 18.0,
//                           color: Colors.white),
//                     ),
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return 'Por favor ingresa tu correo';
//                       }
//                       return null;
//                     },
//                     onSaved: (value) {
//                       _correo = value!;
//                     },
//                     style: const TextStyle(color: Colors.white),
//                   ),
//                 ],
//               ),
//             ),
// //TEXTO CONTRASEÑA-------------------------------------------------------------
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               margin: const EdgeInsets.only(right: 400, bottom: 5, top: 20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.only(left: 8.0),
//                     child: Text(
//                       'Telefóno movil',
//                       style: TextStyle(
//                           fontSize: 24.0,
//                           fontFamily: "Baskerville",
//                           color: Colors.white),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               margin: const EdgeInsets.only(left: 60, right: 280),
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   color: Colors.white,
//                   width: 2,
//                 ),
//                 color: Colors.white.withOpacity(0),
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   TextFormField(
//                     controller: _passwordController,
//                     decoration: const InputDecoration(
//                       border: InputBorder.none,
//                       hintText: 'Ingrese su teléfono movil',
//                       hintStyle: TextStyle(
//                           fontFamily: "Baskerville",
//                           fontSize: 18.0,
//                           color: Colors.white),
//                     ),
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return 'Por favor ingresa tu teléfono';
//                       }
//                       return null;
//                     },
//                     onSaved: (value) {
//                       _telefono = value!;
//                     },
//                     style: const TextStyle(color: Colors.white),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 32),
//             Container(
//               margin: const EdgeInsets.only(top: 0),
//               child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                      Column(
//                         children: [SizedBox(height: 5), BotonHome("VOLVER",onPressed: (){Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => Registrarse2(_usuario)));})]),
//                     Column(children: [
//                       const SizedBox(height: 5),
//                       Stack(
//                         children: <Widget>[
//                           Positioned.fill(
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(30),
//                                 gradient: const LinearGradient(
//                                   begin: Alignment.topCenter,
//                                   end: Alignment.bottomCenter,
//                                   colors: <Color>[
//                                     Color(0xFFdee8eb),
//                                     Color(0xFFb0c7d0)
//                                   ],
//                                   stops: [0.4, 1.0],
//                                 ),
//                               ),
//                             ),
//                           ),
//                           TextButton(
//                             style: TextButton.styleFrom(
//                               foregroundColor: const Color(0xFF004461),
//                               // padding: const EdgeInsets.all(16.0),
//                               padding: const EdgeInsets.only(
//                                   top: 4, bottom: 4, left: 15, right: 15),
//                               textStyle: const TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 18,
//                                   fontFamily: "Georgia"),
//                             ),
//                             onPressed: () async {
//                               // print("mirando estado");
//                               // if (_formKey.currentState!.validate()) {
//                               //   print("${_usuario} ${_contrasenya}");
//                               //   _formKey.currentState!.save();

//                               //   print("${_usuario} ${_contrasenya}");
//                               //   Future<LoginUserResponse> f =
//                               //       iniciarSesionUsuario(LoginUserPetition(
//                               //           _usuario, _contrasenya));
//                               //   LoginUserResponse r = await f;

//                               //   print("Peticion");

//                               //   print(
//                               //       'Hola ${r.OK} ${r.token} ${r.error_username} ${r.error_password}');
//                               // }
//                               // ;
//                               Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => Menu()),
//                               );
//                             },
//                             child: Text("CONTINUAR"),
//                           ),
//                         ],
//                       )
//                     ])
//                   ]),
//             ),
//           ],
//         ),
//       ),
//       // ),
//     ));
//   }

//   @override
//   void dispose() {
//     _userController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
// }

// class BotonHome extends StatelessWidget {
//   final String textContrasenya;
//   final VoidCallback onPressed;
//   const BotonHome(String t, {Key? key, required this.onPressed})
//       : textContrasenya = t,
//         super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // ignore: dead_code
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(4),
//       child: Stack(
//         children: <Widget>[
//           Positioned.fill(
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(30),
//                 gradient: const LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: <Color>[Color(0xFFdee8eb), Color(0xFFb0c7d0)],
//                   stops: [0.4, 1.0],
//                 ),
//               ),
//             ),
//           ),
//           TextButton(
//             style: TextButton.styleFrom(
//               foregroundColor: const Color(0xFF004461),
//               // padding: const EdgeInsets.all(16.0),
//               padding:
//                   const EdgeInsets.only(top: 4, bottom: 4, left: 15, right: 15),
//               textStyle: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 18,
//                   fontFamily: "Georgia"),
//             ),
//             onPressed: onPressed,
//             child: Text(textContrasenya),
//           ),
//         ],
//       ),
//     );
//   }
// }
