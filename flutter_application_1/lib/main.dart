import 'package:flutter/material.dart';
import 'package:flutter_application_1/Interfaz/InicioSesion/home.dart';

import 'Interfaz/InicioSesion/iniciarSesion.dart';
import 'Interfaz/InicioSesion/inicioApp.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter_application_1/dentro.dart';

// import 'package:flutter_application_1/InicioSesion/home.dart';
// import 'package:flutter_application_1/InicioSesion/registrarse.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Login',
    home: Scaffold(
      body: InicioApp()
    )
  ));
} 

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container (
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/tapete.png'),
            fit:BoxFit.fill,
          ),
        ),
        child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 30),
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
            margin: const EdgeInsets.only(right: 480, bottom: 5, top: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Usuario',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontFamily: "Baskerville",
                      color: Colors.white
                      ),
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
                TextField(
                  controller: _userController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Ingrese su usuario',
                    hintStyle: TextStyle(
                      fontFamily: "Baskerville",
                      fontSize: 18.0,
                      color: Colors.white
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
//TEXTO CONTRASEÑA-------------------------------------------------------------
          // const SizedBox(height: 16),
          // Container(  
          //   padding: const EdgeInsets.symmetric(horizontal: 16),
          //   margin: const EdgeInsets.only(right: 480, bottom: 5),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: const [
          //       Padding(
          //         padding: EdgeInsets.only(left: 8.0),
          //         child: Text(
          //           'Usuario',
          //           style: TextStyle(
          //             fontSize: 24.0,
          //             color: Colors.white
          //             ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // Container(
          //   padding: const EdgeInsets.symmetric(horizontal: 16),
          //   margin: const EdgeInsets.only(left: 60, right: 280),
          //   decoration: BoxDecoration(
          //     border: Border.all(color: Colors.white),
          //     color: Colors.white.withOpacity(0),
          //     borderRadius: BorderRadius.circular(15),
          //   ),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       TextField(
          //         controller: _userController,
          //         decoration: const InputDecoration(
          //           border: InputBorder.none,
          //           hintText: 'Ingrese su usuario',
          //           hintStyle: TextStyle(
          //             fontSize: 18.0,
          //             color: Colors.white
          //           ),
          //         ),
          //         style: const TextStyle(color: Colors.white),
          //       ),
          //     ],
          //   ),
          // ),
//------------------------------------------------------------------------- 
          const SizedBox(height: 32),
          Container (
            margin: const EdgeInsets.only(top: 30),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // children: [
              //   ElevatedButton(
              //     onPressed: () {
              //       // handle login logic
              //     },
              //     child: const Text('Volver'),
              //   ),
              //   ElevatedButton(
              //     onPressed: () {
              //       // handle back button logic
              //     },
              //     child: const Text('Continuar'),
              //   ),
              // ],
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [Column(children:const [SizedBox(height: 30),BotonHome("VOLVER")]),
              Column(children:const [SizedBox(height: 30),BotonHome("CONTINUAR")])]
            ),
          ),
        ],
      ),
      )
    );
  }

  @override
  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

class BotonHome extends StatelessWidget{
  const BotonHome(String t,{Key? key}) : text = t, super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    // ignore: dead_code
    return 
          ClipRRect(
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
                        colors: <Color>[
                          Color(0xFFdee8eb),
                          Color(0xFFb0c7d0)
                        ],
                        stops: [0.4,1.0],
                        
                      ),
                    ),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFF004461),
                    // padding: const EdgeInsets.all(16.0),
                    padding:  const EdgeInsets.only(top: 4, bottom: 4, left: 15, right: 15),
                    textStyle: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18,fontFamily: "Georgia"),
                  ),
                  onPressed: () {print("hola" + text);},
                  child: Text(text),
                ),
              ],
            ),
          );
  }

}
/*
import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';

void main() {
  runApp(const MyApp());
} 

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formulario de dos campos',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Formulario de dos campos'),
        ),
        body: Center(
          child: MyForm(),
        ),
      ),
    );
  }
}

class MyForm extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _email;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Nombre',
              icon: Icon(Icons.person),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Por favor ingresa tu nombre';
              }
              return null;
            },
            onSaved: (value) {
              _name = value!;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Email',
              icon: Icon(Icons.email),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Por favor ingresa tu email';
              }
              return null;
            },
            onSaved: (value) {
              _email = value!;
            },
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Valores del formulario'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[
                            Text('Nombre: $_name'),
                            Text('Email: $_email'),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Aceptar'),
                          onPressed: () {
                            // Navigator.of(context).pop();
                            createUser(_name, _email);
                          },
                        ),
                      ],
                    );
                  },
                );
              }
            },
            child: const Text('Enviar'),
          ),
        ],
      ),
    );
  }
}


class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}



Future<void> createUser(String username, String password) async {

  HttpOverrides.global = MyHttpOverrides();

  final url = Uri.parse('https://6e01-146-158-156-138.eu.ngrok.io/api/usuarios/login/');
  final response = await post(url, body: {
    'username': username,
    'password': password,
  });
  if (response.statusCode == 200) {
    // Successful API call
    print('User loged successfully');
    print(response.body);
  } else {
    // Failed API call
    print('Failed to log user');
  }
}*/
