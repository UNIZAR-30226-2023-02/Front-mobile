import 'package:flutter_application_1/Interfaz/Menu/index.dart';
import 'package:flutter/material.dart';


import '../../../Data_types/sesion.dart';

class TiendaFichas extends StatelessWidget {
  final Sesion _s;
  const TiendaFichas(this._s);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _TiendaFichas(_s),
    );
  }
}

class _TiendaFichas extends StatelessWidget {
  final Sesion _s;
  const _TiendaFichas(this._s);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.all(16.0),
                child: const Text(
                  'Tienda',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFc9c154),
                    fontFamily: "Baskerville",
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xFFc9c154),
                      width: 2.0,
                    ),
                  ),
                ),
                margin: EdgeInsets.symmetric(horizontal: 20.0),
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 0, bottom: 0),
                padding: const EdgeInsets.all(16.0),
                child: const Text(
                  'Fichas',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFc9c154),
                    fontFamily: "Baskerville",
                  ),
                ),
              ),
              Container(
                height: 155, //120 sin poner el precio
                margin: EdgeInsets.symmetric(horizontal: 35),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Color.fromARGB(255, 218, 173, 40),
                    width: 3,
                  ),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Center(
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          //TODOS LOS OBJETOS DE LA TIENDA
                          Column(
                            children: [
                              ObjetcButton(
                                //color: Color.fromARGB(255, 76, 175, 79),
                                onPressed: () {
                                  print("sisi");
                                },
                                pathImagen: 'assets/fichas/rick.png',
                              ),
                              Container(
                                alignment: Alignment.center,
                                //margin: const EdgeInsets.only(top: 5),
                                padding: const EdgeInsets.all(16.0),
                                child: const Text(
                                  '20 monedas',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFc9c154),
                                    fontFamily: "Baskerville",
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Column(
                            children: [
                              ObjetcButton(
                                //color: Color.fromARGB(255, 76, 175, 79),
                                onPressed: () {
                                  print("sisi");
                                },
                                pathImagen: 'assets/fichas/bmo.png',
                              ),
                              Container(
                                alignment: Alignment.center,
                                //margin: const EdgeInsets.only(top: 5),
                                padding: const EdgeInsets.all(16.0),
                                child: const Text(
                                  '20 monedas',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFc9c154),
                                    fontFamily: "Baskerville",
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Column(
                            children: [
                              ObjetcButton(
                                //color: Color.fromARGB(255, 76, 175, 79),
                                onPressed: () {
                                  print("sisi");
                                },
                                pathImagen: 'assets/fichas/lagarto.png',
                              ),
                              Container(
                                alignment: Alignment.center,
                                //margin: const EdgeInsets.only(top: 5),
                                padding: const EdgeInsets.all(16.0),
                                child: const Text(
                                  '20 monedas',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFc9c154),
                                    fontFamily: "Baskerville",
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Column(
                            children: [
                              ObjetcButton(
                                //color: Color.fromARGB(255, 76, 175, 79),
                                onPressed: () {
                                  print("sisi");
                                },
                                pathImagen: 'assets/fichas/bongoCat.png',
                              ),
                              Container(
                                alignment: Alignment.center,
                                //margin: const EdgeInsets.only(top: 5),
                                padding: const EdgeInsets.all(16.0),
                                child: const Text(
                                  '20 monedas',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFc9c154),
                                    fontFamily: "Baskerville",
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Column(
                            children: [ 
                              ObjetcButton(
                                //color: Color.fromARGB(255, 76, 175, 79),
                                onPressed: () {
                                  print("sisi");
                                },
                                pathImagen: 'assets/fichas/corazonBadBunny.png',
                              ),
                              Container(
                                alignment: Alignment.center,
                                //margin: const EdgeInsets.only(top: 5),
                                padding: const EdgeInsets.all(16.0),
                                child: const Text(
                                  '20 monedas',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFc9c154),
                                    fontFamily: "Baskerville",
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Column(
                            children: [
                              ObjetcButton(
                                //color: Color.fromARGB(255, 76, 175, 79),
                                onPressed: () {
                                  print("sisi");
                                },
                                pathImagen: 'assets/fichas/gato.png',
                              ),
                              Container(
                                alignment: Alignment.center,
                                //margin: const EdgeInsets.only(top: 5),
                                padding: const EdgeInsets.all(16.0),
                                child: const Text(
                                  '20 monedas',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFc9c154),
                                    fontFamily: "Baskerville",
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Column(
                            children: [
                              ObjetcButton(
                                //color: Color.fromARGB(255, 76, 175, 79),
                                onPressed: () {
                                  print("sisi");
                                },
                                pathImagen: 'assets/fichas/ghostface.png',
                              ),
                              Container(
                                alignment: Alignment.center,
                                //margin: const EdgeInsets.only(top: 5),
                                padding: const EdgeInsets.all(16.0),
                                child: const Text(
                                  '20 monedas',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFc9c154),
                                    fontFamily: "Baskerville",
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Column(
                            children: [
                              ObjetcButton(
                                //color: Color.fromARGB(255, 76, 175, 79),
                                onPressed: () {
                                  print("sisi");
                                },
                                pathImagen: 'assets/fichas/pollo.png',
                              ),
                              Container(
                                alignment: Alignment.center,
                                //margin: const EdgeInsets.only(top: 5),
                                padding: const EdgeInsets.all(16.0),
                                child: const Text(
                                  '20 monedas',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFc9c154),
                                    fontFamily: "Baskerville",
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Column(
                            children: [
                              ObjetcButton(
                                //color: Color.fromARGB(255, 76, 175, 79),
                                onPressed: () {
                                  print("sisi");
                                },
                                pathImagen: 'assets/fichas/smile.png',
                              ),
                              Container(
                                alignment: Alignment.center,
                                //margin: const EdgeInsets.only(top: 5),
                                padding: const EdgeInsets.all(16.0),
                                child: const Text(
                                  '20 monedas',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFc9c154),
                                    fontFamily: "Baskerville",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 40.0, top: 15),
                    child: BotonHome(
                      "MENÚ",
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => Menu(_s)),
                            (Route<dynamic> route) => false);
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 40.0, top: 15),
                    child: BotonHome(
                      "TABLEROS",
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => TiendaTableros(_s)),
                            (Route<dynamic> route) => false);

                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TileButton extends StatelessWidget {
  final Color color = const Color.fromARGB(0, 66, 66, 66);
  final VoidCallback onPressed;
  final String pathImagen;

  const TileButton(
      {Key? key, required this.onPressed, required this.pathImagen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Stack(
        children: [
          Container(
            width: 100,
            height: 100,
            color: color,
            margin: EdgeInsets.symmetric(horizontal: 8),
          ),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(pathImagen),
                fit: BoxFit.cover,
              ),
            ),
            margin: EdgeInsets.symmetric(horizontal: 8),
          ),
        ],
      ),
    );
  }
}