import 'package:flutter_application_1/Data_types/estadisticas.dart';
import 'package:flutter_application_1/Interfaz/Menu/index.dart';

import 'package:flutter/material.dart';

import '../../../Data_types/sesion.dart';

class Estadisticas extends StatelessWidget {
  final EstadisticasUsuario _eU;
  const Estadisticas(this._eU, {Key? key}) : super(key: key);
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
                  'Estadísticas',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFc9c154),
                    fontFamily: "Baskerville",
                  ),
                ),
              ),
              Container(
                height: 240, //120 sin poner el precio
                margin: const EdgeInsets.symmetric(horizontal: 35),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: const Color(0xFFc9c154),
                    width: 3,
                  ),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Center(
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(left: 7, right: 7),
                          child: Column(
                            children: [
                              //TODAS LAS TARJETAS DE ESTADISTICAS
                              Container(
                                height: 225,
                                margin: const EdgeInsets.only(top: 5),
                                decoration: BoxDecoration(
                                  color: Colors.grey[600],
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    width: 3,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      //margin: const EdgeInsets.only(top: 5),
                                      padding: const EdgeInsets.only(
                                          top: 10.0,
                                          bottom: 4.0,
                                          left: 6.0,
                                          right: 6.0),
                                      child: const Text(
                                        'TOTAL',
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontFamily: "Baskerville",
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 7, right: 7),
                                      child: Row(
                                        children: [
                                          Column(
                                            children: [
                                              const ContainerPreguntas(
                                                  number: '200'),
                                              Row(
                                                children: const [
                                                  ContainerIncorrectas(
                                                      number: '100'),
                                                  ContainerCorrectas(
                                                      number: '100'),
                                                ],
                                              ),
                                              const ContainerPorcentaje(
                                                  number: '50'),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 7),
                          child: Column(
                            children: [
                              //TODAS LAS TARJETAS DE ESTADISTICAS
                              Container(
                                height: 225,
                                margin: const EdgeInsets.only(top: 5),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 33, 149, 243),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    width: 3,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      //margin: const EdgeInsets.only(top: 5),
                                      padding: const EdgeInsets.only(
                                          top: 10.0,
                                          bottom: 4.0,
                                          left: 6.0,
                                          right: 6.0),
                                      child: const Text(
                                        'GEOGRAFÍA',
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontFamily: "Baskerville",
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 7, right: 7),
                                      child: Column(
                                        children: [
                                          const ContainerPreguntas(
                                              number: '200'),
                                          Row(
                                            children: const [
                                              ContainerIncorrectas(
                                                  number: '100'),
                                              ContainerCorrectas(number: '100'),
                                            ],
                                          ),
                                          const ContainerPorcentaje(
                                              number: '50'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 7),
                          child: Column(
                            children: [
                              Container(
                                height: 225,
                                margin: const EdgeInsets.only(top: 5),
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 76, 175, 79),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    width: 3,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      //margin: const EdgeInsets.only(top: 5),
                                      padding: const EdgeInsets.only(
                                          top: 16.0, left: 6.0, right: 6.0),
                                      child: const Text(
                                        'CIENCIA',
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontFamily: "Baskerville",
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 7, right: 7),
                                      child: Column(
                                        children: [
                                          const ContainerPreguntas(
                                              number: '200'),
                                          Row(
                                            children: const [
                                              ContainerIncorrectas(
                                                  number: '100'),
                                              ContainerCorrectas(number: '100'),
                                            ],
                                          ),
                                          const ContainerPorcentaje(
                                              number: '50'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 7),
                          child: Column(
                            children: [
                              //TODAS LAS TARJETAS DE ESTADISTICAS
                              Container(
                                height: 225,
                                margin: const EdgeInsets.only(top: 5),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 216, 189, 37),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    width: 3,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      //margin: const EdgeInsets.only(top: 5),
                                      padding: const EdgeInsets.only(
                                          top: 10.0,
                                          bottom: 4.0,
                                          left: 6.0,
                                          right: 6.0),
                                      child: const Text(
                                        'HISTORIA',
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontFamily: "Baskerville",
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 7, right: 7),
                                      child: Column(
                                        children: [
                                          const ContainerPreguntas(
                                              number: '200'),
                                          Row(
                                            children: const [
                                              ContainerIncorrectas(
                                                  number: '100'),
                                              ContainerCorrectas(number: '100'),
                                            ],
                                          ),
                                          const ContainerPorcentaje(
                                              number: '50'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 7),
                          child: Column(
                            children: [
                              //TODAS LAS TARJETAS DE ESTADISTICAS
                              Container(
                                height: 225,
                                margin: const EdgeInsets.only(top: 5),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 233, 30, 148),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    width: 3,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      //margin: const EdgeInsets.only(top: 5),
                                      padding: const EdgeInsets.only(
                                          top: 10.0,
                                          bottom: 4.0,
                                          left: 6.0,
                                          right: 6.0),
                                      child: const Text(
                                        'ENTRETENIMIENTO',
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontFamily: "Baskerville",
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 7, right: 7),
                                      child: Column(
                                        children: [
                                          const ContainerPreguntas(
                                              number: '200'),
                                          Row(
                                            children: const [
                                              ContainerIncorrectas(
                                                  number: '100'),
                                              ContainerCorrectas(number: '100'),
                                            ],
                                          ),
                                          const ContainerPorcentaje(
                                              number: '50'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 7),
                          child: Column(
                            children: [
                              //TODAS LAS TARJETAS DE ESTADISTICAS
                              Container(
                                height: 225,
                                margin: const EdgeInsets.only(top: 5),
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 255, 153, 0),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    width: 3,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      //margin: const EdgeInsets.only(top: 5),
                                      padding: const EdgeInsets.only(
                                          top: 10.0,
                                          bottom: 4.0,
                                          left: 6.0,
                                          right: 6.0),
                                      child: const Text(
                                        'DEPORTES',
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontFamily: "Baskerville",
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 7, right: 7),
                                      child: Column(
                                        children: [
                                          const ContainerPreguntas(
                                              number: '200'),
                                          Row(
                                            children: const [
                                              ContainerIncorrectas(
                                                  number: '100'),
                                              ContainerCorrectas(number: '100'),
                                            ],
                                          ),
                                          const ContainerPorcentaje(
                                              number: '50'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 7),
                          child: Column(
                            children: [
                              //TODAS LAS TARJETAS DE ESTADISTICAS
                              Container(
                                height: 225,
                                margin: const EdgeInsets.only(top: 5),
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 231, 40, 26),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    width: 3,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      //margin: const EdgeInsets.only(top: 5),
                                      padding: const EdgeInsets.only(
                                          top: 10.0,
                                          bottom: 4.0,
                                          left: 6.0,
                                          right: 6.0),
                                      child: const Text(
                                        'ARTE Y LITERA',
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontFamily: "Baskerville",
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 7, right: 7),
                                      child: Column(
                                        children: [
                                          const ContainerPreguntas(
                                              number: '200'),
                                          Row(
                                            children: const [
                                              ContainerIncorrectas(
                                                  number: '100'),
                                              ContainerCorrectas(number: '100'),
                                            ],
                                          ),
                                          const ContainerPorcentaje(
                                              number: '50'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 40.0, top: 10),
                    child: Boton1(
                      "MENÚ",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Menu(Sesion())),
                        );
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
