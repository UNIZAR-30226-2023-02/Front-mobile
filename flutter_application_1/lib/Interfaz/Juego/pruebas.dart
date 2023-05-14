import 'dart:async';
import 'package:flutter/material.dart';

class ColoredSquareScreen extends StatefulWidget {
  @override
  _ColoredSquareScreenState createState() => _ColoredSquareScreenState();
}

class _ColoredSquareScreenState extends State<ColoredSquareScreen> {
  Color _currentColor = Colors.red; // El color inicial del cuadrado
  late Timer _timer; // El temporizador que se usará para cambiar el color
  bool ok = true;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      setState(() {
        _currentColor = _getNextColor(_currentColor); // Cambia el color del cuadrado
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancela el temporizador al cerrar la pantalla
    super.dispose();
  }

  void pulsar(){
    if(ok){
      ok = false;
    }else{
      ok = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Colored Square Screen'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              width: 200,
              height: 200,
              color: ok == true ? Colors.grey : _currentColor,
            ),

            ElevatedButton(
              onPressed: pulsar,
              child: Text('Ejecutar función'),
            ),
          ],
        ),
        
        ),
    );
  }

  Color _getNextColor(Color currentColor) {
    // Una función para obtener el siguiente color en la secuencia rojo -> verde -> azul -> rojo
    if (currentColor == Colors.red) {
      return Colors.green;
    } else{
      return Colors.red;
    }
  }
}
