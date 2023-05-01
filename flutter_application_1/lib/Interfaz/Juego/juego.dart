import 'dart:math';
import 'dart:async';

import 'package:flutter/material.dart';

class Juego extends StatelessWidget {
  const Juego({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _Juego(),
    );
  }
}

class _Juego extends StatefulWidget {
  @override
  __JuegoState createState() => __JuegoState();
}

class __JuegoState extends State<_Juego> {
  Color Azul = Colors.blue;
  Color Naranja = Color.fromARGB(255, 240, 143, 17);
  Color Rojo = Color.fromARGB(255, 230, 44, 19);
  Color Rosa = Color.fromARGB(255, 231, 19, 185);
  Color Verde = Color.fromARGB(255, 53, 224, 18);
  Color Amarillo = Color.fromARGB(255, 231, 235, 42);
  Color Blanco = Color.fromARGB(255, 255, 255, 255);

  // void _cambiarColor2() {
  //   setState(() {
  //     Bcolor2 = Colors.green;
  //   });
  // }
  // void _cambiarColor1() {
  //   setState(() {
  //     Bcolor1 = Colors.green;
  //   });
  // }

  //CONTADOR--------------------------------------------------------
  int _countdownTime = 5;
  Timer? _timer;
  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdownTime > 0) {
          _countdownTime--;
        } else {
          timer.cancel();
        }
      });
    });
  }
  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  //DADO------------------------------------------------------------
  int _diceNumber = 1;
  int turno = 1;

  void _rollDice() {
    setState(() {
      _diceNumber = Random().nextInt(6) + 1;
      turno = 0;
    });
  }

  void _resetTurno() {
    setState(() {
      turno = 1;
    });
  }

  //-------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/tapete.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: screenSize.height / 2 - 50, // ajustar la posición vertical del hexágono
              left: screenSize.width / 2 - 50, // ajustar la posición horizontal del hexágono
              child: Stack(
                children: [
                  
                  Transform.translate(  //Contador
                    offset: const Offset(-150, -128),
                    child: Text(
                      '$_countdownTime',
                      style: TextStyle(fontSize: 48),
                    ),
                  ),

                  Transform.translate(  //Texto J1
                    offset: const Offset(-262, -128),
                    child: const Text(
                      "Jugador 1",
                      style: TextStyle(
                        fontFamily: "Baskerville",
                        fontSize: 12.0,
                        //color: Color(0xFFc9c154),
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none
                      ),
                    ),
                  ),
                  Transform.translate(  //Imagen J1
                    offset: const Offset(-265, -110),
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/perfil.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Transform.translate(  //Putos J1
                    offset: const Offset(-205, -60),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/trivial_blanco.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),

                  Transform.translate(  //Texto J2
                    offset: const Offset(-262, -8),
                    child: const Text(
                      "Jugador 2",
                      style: TextStyle(
                        fontFamily: "Baskerville",
                        fontSize: 12.0,
                        //color: Color(0xFFc9c154),
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none
                      ),
                    ),
                  ),
                  Transform.translate(  //Imagen J2
                    offset: const Offset(-265, 10),
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/perfil.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Transform.translate(  //Putos J2
                    offset: const Offset(-205, 60),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/trivial_blanco.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),

                  Transform.translate(  //Texto J3
                    offset: const Offset(-262, 112),
                    child: const Text(
                      "Jugador 3",
                      style: TextStyle(
                        fontFamily: "Baskerville",
                        fontSize: 12.0,
                        //color: Color(0xFFc9c154),
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none
                      ),
                    ),
                  ),
                  Transform.translate(  //Imagen J3
                    offset: const Offset(-265, 130),
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/perfil.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Transform.translate(  //Putos J3
                    offset: const Offset(-205, 180),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/trivial_blanco.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),

                  Transform.translate(  //Texto J4
                    offset: const Offset(293, -128),
                    child: const Text(
                      "Jugador 4",
                      style: TextStyle(
                        fontFamily: "Baskerville",
                        fontSize: 12.0,
                        //color: Color(0xFFc9c154),
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none
                      ),
                    ),
                  ),
                  Transform.translate(  //Imagen J4
                    offset: const Offset(290, -110),
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/perfil.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Transform.translate(  //Putos J4
                    offset: const Offset(260, -60),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/trivial_blanco.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),

                  Transform.translate(  //Texto J5
                    offset: const Offset(293, -8),
                    child: const Text(
                      "Jugador 5",
                      style: TextStyle(
                        fontFamily: "Baskerville",
                        fontSize: 12.0,
                        //color: Color(0xFFc9c154),
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none
                      ),
                    ),
                  ),
                  Transform.translate(  //Imagen J5
                    offset: const Offset(290, 10),
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/perfil.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Transform.translate(  //Putos J5
                    offset: const Offset(260, 60),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/trivial_blanco.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),

                  Transform.translate(  //Texto J6
                    offset: const Offset(293, 112),
                    child: const Text(
                      "Jugador 6",
                      style: TextStyle(
                        fontFamily: "Baskerville",
                        fontSize: 12.0,
                        //color: Color(0xFFc9c154),
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none
                      ),
                    ),
                  ),
                  Transform.translate(  //Imagen J6
                    offset: const Offset(290, 130),
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/perfil.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Transform.translate(  //Putos J6
                    offset: const Offset(260, 180),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/trivial_blanco.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),

                  //CHexagono
                  Transform.translate(
                    offset: const Offset(0, 0),
                    child: HexagonButton(
                      color: Blanco,
                      onPressed: () {
                        //_cambiardecolor2();
                        setState(() {
                          _countdownTime = 5;
                        });
                        startTimer();
                      },
                    ),
                  ),
                  //C1
                  Transform.rotate(
                    angle: -27 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(19, 66),
                      child: RectangleButton(
                        color: Amarillo,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C2
                  Transform.rotate(
                    angle: -27 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(19, 87),
                      child: RectangleButton(
                        color: Verde,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C3
                  Transform.rotate(
                    angle: -27 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(19, 108),
                      child: RectangleButton(
                        color: Rojo,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C4
                  Transform.rotate(
                    angle: -27 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(19, 129),
                      child: RectangleButton(
                        color: Naranja,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C5
                  Transform.rotate(
                    angle: -27 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(19, 150),
                      child: RectangleButton(
                        color: Azul,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C66
                  Transform.rotate(
                    angle: -154 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(18, -17),
                      child: RectangleButton(
                        color: Rosa,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C65
                  Transform.rotate(
                    angle: -154 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(18, -37),
                      child: RectangleButton(
                        color: Rojo,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C64
                  Transform.rotate(
                    angle: -154 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(18, -57),
                      child: RectangleButton(
                        color: Azul,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C63
                  Transform.rotate(
                    angle: -154 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(18, -77),
                      child: RectangleButton(
                        color: Amarillo,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C62
                  Transform.rotate(
                    angle: -154 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(18, -98),
                      child: RectangleButton(
                        color: Naranja,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),

                  //C72
                  Transform.rotate(
                    angle: -90 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-150, 75),
                      child: RectangleButton(
                        color: Azul,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C71
                  Transform.rotate(
                    angle: -90 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-150, 55),
                      child: RectangleButton(
                        color: Blanco,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C70
                  Transform.rotate(
                    angle: -90 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-150, 35),
                      child: RectangleButton(
                        color: Rojo,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C69
                  Transform.rotate(
                    angle: -90 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-150, 15),
                      child: RectangleButton(
                        color: Amarillo,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C68
                  Transform.rotate(
                    angle: -90 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-150, -5),
                      child: RectangleButton(
                        color: Blanco,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C67
                  Transform.rotate(
                    angle: -90 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-150, -25),
                      child: RectangleButton(
                        color: Naranja,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C7
                  Transform.rotate(
                    angle: -148 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-142, -23),
                      child: RectangleButton(
                        color: Azul,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C8
                  Transform.rotate(
                    angle: -148 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-142, -5),
                      child: RectangleButton(
                        color: Blanco,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C9
                  Transform.rotate(
                    angle: -148 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-142, 15),
                      child: RectangleButton(
                        color: Naranja,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C10
                  Transform.rotate(
                    angle: -148 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-142, 35),
                      child: RectangleButton(
                        color: Verde,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C11
                  Transform.rotate(
                    angle: -148 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-142, 55),
                      child: RectangleButton(
                        color: Blanco,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C12
                  Transform.rotate(
                    angle: -148 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-142, 75),
                      child: RectangleButton(
                        color: Rojo,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),

                  //C6
                  Transform.rotate(
                    angle: -207 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(37, -158),
                      child: Esquina2Button(
                        color: Blanco,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C18
                  Transform.rotate(
                    angle: -90 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(13, 70),
                      child: RectangleButton(
                        color: Naranja,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C17
                  Transform.rotate(
                    angle: -90 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(13, 91),
                      child: RectangleButton(
                        color: Rosa,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C16
                  Transform.rotate(
                    angle: -90 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(13, 111),
                      child: RectangleButton(
                        color: Verde,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C15
                  Transform.rotate(
                    angle: -90 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(13, 131),
                      child: RectangleButton(
                        color: Azul,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C14
                  Transform.rotate(
                    angle: -90 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(13, 151),
                      child: RectangleButton(
                        color: Rojo,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C54
                  Transform.rotate(
                    angle: -90 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(13, -20),
                      child: RectangleButton(
                        color: Verde,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C53
                  Transform.rotate(
                    angle: -90 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(13, -40),
                      child: RectangleButton(
                        color: Azul,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C52
                  Transform.rotate(
                    angle: -90 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(13, -60),
                      child: RectangleButton(
                        color: Naranja,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C51
                  Transform.rotate(
                    angle: -90 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(13, -80),
                      child: RectangleButton(
                        color: Rosa,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C50
                  Transform.rotate(
                    angle: -90 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(13, -100),
                      child: RectangleButton(
                        color: Amarillo,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),

                  //C60
                  Transform.rotate(
                    angle: 330 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-148, 88),
                      child: RectangleButton(
                        color: Naranja,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C59
                  Transform.rotate(
                    angle: 330 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-148, 68),
                      child: RectangleButton(
                        color: Blanco,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C58
                  Transform.rotate(
                    angle: 330 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-148, 48),
                      child: RectangleButton(
                        color: Azul,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C57
                  Transform.rotate(
                    angle: 330 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-148, 28),
                      child: RectangleButton(
                        color: Rosa,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C56
                  Transform.rotate(
                    angle: 330 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-148, 8),
                      child: RectangleButton(
                        color: Blanco,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C55
                  Transform.rotate(
                    angle: 330 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-148, -13),
                      child: RectangleButton(
                        color: Amarillo,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C61
                  Transform.rotate(
                    angle: 207 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(30, -178),
                      child: Esquina3Button(
                        color: Blanco,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),

                  //C42
                  Transform.rotate(
                    angle: -207 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(19, 66),
                      child: RectangleButton(
                        color: Rojo,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C41
                  Transform.rotate(
                    angle: -207 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(19, 86),
                      child: RectangleButton(
                        color: Naranja,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C40
                  Transform.rotate(
                    angle: -207 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(19, 106),
                      child: RectangleButton(
                        color: Amarillo,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C39
                  Transform.rotate(
                    angle: -207 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(19, 126),
                      child: RectangleButton(
                        color: Verde,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C38
                  Transform.rotate(
                    angle: -207 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(19, 146),
                      child: RectangleButton(
                        color: Rosa,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),


                  //C43
                  Transform.rotate(
                    angle: -329 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-142, -23),
                      child: RectangleButton(
                        color: Rosa,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C44
                  Transform.rotate(
                    angle: -329 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-142, -5),
                      child: RectangleButton(
                        color: Blanco,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C45
                  Transform.rotate(
                    angle: -329 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-142, 15),
                      child: RectangleButton(
                        color: Verde,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C46
                  Transform.rotate(
                    angle: -329 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-142, 35),
                      child: RectangleButton(
                        color: Naranja,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C47
                  Transform.rotate(
                    angle: -329 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-142, 55),
                      child: RectangleButton(
                        color: Blanco,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C48
                  Transform.rotate(
                    angle: -329 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-142, 75),
                      child: RectangleButton(
                        color: Amarillo,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  

                  //C30
                  Transform.rotate(
                    angle: -331 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(18, -17),
                      child: RectangleButton(
                        color: Azul,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C29
                  Transform.rotate(
                    angle: -331 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(18, -37),
                      child: RectangleButton(
                        color: Amarillo,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C28
                  Transform.rotate(
                    angle: -331 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(18, -57),
                      child: RectangleButton(
                        color: Rosa,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C27
                  Transform.rotate(
                    angle: -331 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(18, -77),
                      child: RectangleButton(
                        color: Rojo,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C26
                  Transform.rotate(
                    angle: -331 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(18, -98),
                      child: RectangleButton(
                        color: Verde,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),          

                  //C36
                  Transform.rotate(
                    angle: 90 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-140, 73),
                      child: RectangleButton(
                        color: Rosa,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C35
                  Transform.rotate(
                    angle: 90 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-140, 53),
                      child: RectangleButton(
                        color: Blanco,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C34
                  Transform.rotate(
                    angle: 90 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-140, 33),
                      child: RectangleButton(
                        color: Amarillo,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C33
                  Transform.rotate(
                    angle: 90 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-140, 13),
                      child: RectangleButton(
                        color: Rojo,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C32
                  Transform.rotate(
                    angle: 90 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-140, -8),
                      child: RectangleButton(
                        color: Blanco,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C31
                  Transform.rotate(
                    angle: 90 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-140, -29),
                      child: RectangleButton(
                        color: Verde,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),

                  //C24
                  Transform.rotate(
                    angle: 150 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-145, 75),
                      child: RectangleButton(
                        color: Verde,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C23
                  Transform.rotate(
                    angle: 150 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-145, 57),
                      child: RectangleButton(
                        color: Blanco,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C22
                  Transform.rotate(
                    angle: 150 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-145, 38),
                      child: RectangleButton(
                        color: Rosa,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C21
                  Transform.rotate(
                    angle: 150 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-145, 18),
                      child: RectangleButton(
                        color: Azul,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C20
                  Transform.rotate(
                    angle: 150 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-145, -2),
                      child: RectangleButton(
                        color: Blanco,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C19
                  Transform.rotate(
                    angle: 150 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-145, -21),
                      child: RectangleButton(
                        color: Rojo,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),

                  //C49
                  Transform.rotate(
                    angle: 270 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(0, -184),
                      child: EsquinaButton(
                        color: Blanco,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C37
                  Transform.rotate(
                    angle: -27 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-16, -164),
                      child: Esquina2Button(
                        color: Blanco,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C25
                  Transform.rotate(
                    angle: 30 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(-8, -146),
                      child: Esquina3Button(
                        color: Blanco,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),
                  //C13
                  Transform.rotate(
                    angle: -270 * pi / 180,
                    child: Transform.translate(
                      offset: const Offset(26, -135),
                      child: EsquinaButton(
                        color: Blanco,
                        onPressed: () {
                          //_cambiarColor2();
                        },
                      ),
                    ),
                  ),

                  //ImagenDado
                  Transform.translate(  
                    offset: const Offset(190, -120),
                    child: Image.asset(
                      'assets/cara$_diceNumber.png',
                      height: 50,
                    ),
                  ),
                  //BotonDado
                  Padding(
                    padding: EdgeInsets.only(top: 180, left: 168), // ajusta los valores según tus necesidades
                    child: BotonDado(
                      'Tirar',
                      onPressed: _rollDice,
                      turno: turno,
                    ),
                  ),
                  //BOTON TEMPORAL REINICIO TURNO
                  Padding(
                    padding: EdgeInsets.only(top: 190, left: 0), // ajusta los valores según tus necesidades
                    child: ElevatedButton(
                    onPressed: _resetTurno,
                    child: Text('Reiniciar turno'),
                  ),
                  ),
                  
                   
                   
                    ],
                  ),

            ),
          ],
        ),
      ),
    );
  }
}

class _HexagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final double w = size.width;
    final double h = size.height;
    // path.moveTo(size.width * 0.5, 0); //centro arriba (linea arriba izquierda)
    // path.lineTo(size.width * 0.5, 0); //centro arriba (linea arriba derecha)
    // path.lineTo(size.width, size.height * 0.4); //punto derecho
    // path.lineTo(size.width * 0.8, size.height); //abajo derecha
    // path.lineTo(size.width * 0.2, size.height); //abajo izquierda 
    // path.lineTo(size.width * 0, size.height * 0.4); //punto izquierdo


    path.moveTo(w * 0.5, 0);
    path.lineTo(w, h * 0.25);
    path.lineTo(w, h * 0.75);
    path.lineTo(w * 0.5, h);
    path.lineTo(0, h * 0.75);
    path.lineTo(0, h * 0.25);


    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class _RectangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final double w = size.width;
    final double h = size.height;

    path.moveTo(0, 0);
    path.lineTo(w * 0.56, 0);
    path.lineTo(w * 0.56, h * 0.3);
    path.lineTo(0, h * 0.3);


    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class _EsquinaClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final double w = size.width;
    final double h = size.height;

    path.moveTo(0.25 * w, 0);
    path.lineTo(0.75 * w, 0);
    // path.lineTo(w, 0.5 * h);
    // path.lineTo(w, 0.7 * h);
    path.lineTo(0.55 * w, h);
    // path.lineTo(0.25 * w, h);
    path.lineTo(28, h);
    path.lineTo(-28, -50);  //arriba izq
    path.close();

    // path.moveTo(10,20);
    // path.lineTo(size.width * 0.2, 0);
    // path.lineTo(size.width * 0.8, 0);
    // path.lineTo(size.width, size.height);
    // path.lineTo(0, size.height);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class _Esquina2Clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final double w = size.width;
    final double h = size.height;

    path.moveTo(0.25 * w, 0);
    path.lineTo(1 * w, -300);
    path.lineTo(0.55 * w, h);
    path.lineTo(30, h +8);
    path.lineTo(-19, -60);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class _Esquina3Clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final double w = size.width;
    final double h = size.height;

    path.moveTo(0.25 * w, 0);
    path.lineTo(w, -130);
    path.lineTo(0.55 * w, h);
    path.lineTo(35, h + 8);
    path.lineTo(-19, -200);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
/////////////////////////////////////////////////////////
class HexagonButton extends StatelessWidget {
  final Color color;
  final VoidCallback onPressed;

  const HexagonButton({
    Key? key,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: ClipPath(
        clipper: _HexagonClipper(),
        child: Container(
          width: 70,
          height: 70,
          color: color,
        ),
      ),
    );
  }
}

class RectangleButton extends StatelessWidget {
  final Color color;
  final VoidCallback onPressed;

  const RectangleButton({
    Key? key,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: ClipPath(
        clipper: _RectangleClipper(),
        child: Container(
          width: 70,
          height: 70,
          color: color,
        ),
      ),
    );
  }
}

class EsquinaButton extends StatelessWidget {
  final Color color;
  final VoidCallback onPressed;

  const EsquinaButton({
    Key? key,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: ClipPath(
        clipper: _EsquinaClipper(),
        child: Container(
          width: 120,
          height: 48,
          color: color,
        ),
      ),
    );
  }
}

class Esquina2Button extends StatelessWidget {
  final Color color;
  final VoidCallback onPressed;

  const Esquina2Button({
    Key? key,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: ClipPath(
        clipper: _Esquina2Clipper(),
        child: Container(
          width: 120,
          height: 55,
          color: color,
        ),
      ),
    );
  }
}

class Esquina3Button extends StatelessWidget {
  final Color color;
  final VoidCallback onPressed;

  const Esquina3Button({
    Key? key,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: ClipPath(
        clipper: _Esquina3Clipper(),
        child: Container(
          width: 120,
          height: 60,
          color: color,
        ),
      ),
    );
  }


}
/////////////////////////////////////////////////////////

class BotonDado extends StatelessWidget {
  final String textContrasenya;
  final VoidCallback onPressed;
  final int turno;
 const BotonDado(String t, {Key? key, required this.onPressed, required this.turno})
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
            padding: const EdgeInsets.only(top: 4, bottom: 4, left: 15, right: 15),
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              fontFamily: "Georgia"),
          ),
          onPressed: turno == 1 ? onPressed : null,
          child: Text(textContrasenya),
          ),
        ],
      ),
    );
  }
}