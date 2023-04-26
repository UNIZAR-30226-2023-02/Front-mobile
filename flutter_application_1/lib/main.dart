import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Api/api.dart';
import 'package:flutter_application_1/Interfaz/InicioSesion_Registro/InicioSesion/iniciandoSesion.dart';
import 'package:flutter_application_1/Interfaz/InicioSesion_Registro/index.dart';
import 'package:flutter_application_1/Interfaz/Juego/juego.dart';
import 'package:flutter_application_1/Data_types/registro.dart';
import 'package:flutter_application_1/Data_types/datosUsuario.dart';

import 'Data_types/sesion.dart';
//import 'pruebas.dart';
//import 'Interfaz/InicioSesion/iniciarSesion.dart';
//import 'Interfaz/InicioSesion/inicioApp.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter_application_1/dentro.dart';

// import 'package:flutter_application_1/InicioSesion/home.dart';
import 'package:flutter_application_1/Interfaz/Perfil/perfil.dart';


void main() {
  runApp(
     MaterialApp(
      home: 
      //Home()
      Perfil(DatosUsuario())
    )
  );
}

/*void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: CustomValidatorForm(),
    ),
  ));
}*/

class MyForm extends StatefulWidget {
  const MyForm({Key? key}) : super(key: key);

  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> with WidgetsBindingObserver {
  bool _isKeyboardVisible = false;
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Register this widget as a listener for application lifecycle events.
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    // Unregister this widget as a listener for application lifecycle events.
    WidgetsBinding.instance.removeObserver(this);
    _textController.dispose();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    // Check whether the keyboard is currently visible.
    final bottomInset = WidgetsBinding.instance.window.viewInsets.bottom;
    _isKeyboardVisible = bottomInset > 0.0;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Use the `_isKeyboardVisible` flag to adjust the layout of your widget.
    return Scaffold(
      appBar: AppBar(title: Text('My Form')),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _textController,
                decoration: InputDecoration(
                  labelText: 'Enter your name',
                  hintText: 'e.g. John Doe',
                ),
              ),
              SizedBox(height: 16.0),
              if (_isKeyboardVisible)
                Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(_textController.text),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
