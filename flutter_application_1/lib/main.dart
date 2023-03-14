import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/dentro.dart';


void main() {
  runApp(const MyApp());
} 

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
                            createUser(_name, _email, context);
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


Future<void> createUser(String username, String password, BuildContext context) async {
  final url = Uri.parse('https://cc34-146-158-156-138.eu.ngrok.io/api/usuarios/login/');
  final response = await http.post(url, body: {
    'username': username,
    'password': password,
  });

  if (response.statusCode == 200) { // Successful API call
    print('User loged successfully');
    print(response.body);

    final respuestaLogIn = jsonDecode(response.body); //el tipo de dato final se inicializa en ejecución en respuestaLogIn guardamos la respuesta json como objeto de dart
    if (respuestaLogIn['OK'] == 'True') {   //parseo la salida json
      // Redirigir a otra pantalla
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Dentro()),  //ejecuto el widget "dentro" que esta en el fichero de la nueva pantalla
      );
    }

  } else {  // Failed API call
    print('Failed to log user');
    print(response.body);
  }
}
