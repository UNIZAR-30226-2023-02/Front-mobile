
import 'package:flutter_application_1/Data_types/sesion.dart';
import 'package:flutter_application_1/Interfaz/Menu/index.dart';
import 'package:flutter/material.dart';
/*
class TiendaTableros extends StatelessWidget {
  final Sesion _s;
  const TiendaTableros(this._s, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _TiendaTableros(_s),
    );
  }
}

class _TiendaTableros extends StatelessWidget {
  final Sesion _s;
  const _TiendaTableros(this._s);
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
                  'Tableros',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFc9c154),
                    fontFamily: "Baskerville",
                  ),
                ),
              ),

              Container(
                height: 155,  //120 sin poner el precio
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
                                pathImagen: 'assets/tableros_tienda/montanya.png',
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
                                pathImagen: 'assets/tableros_tienda/desierto.png',
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
                                pathImagen: 'assets/tableros_tienda/playa.png',
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
                                pathImagen: 'assets/tableros_tienda/espacio.png',
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
                                pathImagen: 'assets/tableros_tienda/templo.png',
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
                                pathImagen: 'assets/tableros_tienda/hielo.png',
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
                      "FICHAS",
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => TiendaFichas(_s)),
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
*/