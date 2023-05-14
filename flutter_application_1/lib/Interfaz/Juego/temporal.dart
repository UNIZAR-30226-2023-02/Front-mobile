import 'package:flutter_application_1/Interfaz/Juego/juego.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:convert';

void main() => runApp(Partida());

class Partida extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: _Partida(),
    );
  }
}

class _Partida extends StatelessWidget {
  void conectar() {
    final channel = IOWebSocketChannel.connect('ws://51.142.118.71:8000/ws/partida/1/?username=hector1'); //ENTRAR A LA SALA (YA CREADA)

    channel.stream.listen((message) {
      print('Received: $message');
    });

    // channel.sink.add('Hello, server!');
  }

  
  
  //SEGUN EL TIPO DE LA CONSULTA QUE ME LLEGUE HAGO UNA COSA U OTRA

  void connectToWebSocket() {
  final channel = IOWebSocketChannel.connect('ws://51.142.118.71:8000/ws/partida/1/?username=hector1');

  channel.stream.listen((message) {
    Map<String, dynamic> decodedResponse = json.decode(message);
    bool isOK = decodedResponse['OK'];
    List<Map<String, dynamic>> players = List<Map<String, dynamic>>.from(decodedResponse['jugadores']);
    String tiempoPregunta = decodedResponse['tiempo_pregunta'];
    String tiempoElegirCasilla = decodedResponse['tiempo_elegir_casilla'];
    String error = decodedResponse['error'];
  
    print('isOK: $isOK');
    print('players: $players');
    print('tiempoPregunta: $tiempoPregunta');
    print('tiempoElegirCasilla: $tiempoElegirCasilla');
    print('error: $error');
  });

  channel.sink.add('Hello, server!');
}
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                conectar();
              },
              child: Text('Botón 1'),
            ),
            ElevatedButton(
              onPressed: () {
                print('2');
              },
              child: Text('Botón 2'),
            ),
          ],
        ),
      ),
    );
  }
}