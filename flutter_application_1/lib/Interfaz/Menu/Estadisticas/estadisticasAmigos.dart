import 'package:flutter_application_1/Data_types/estadisticas.dart';
import 'package:flutter_application_1/Interfaz/Menu/index.dart';

import 'package:flutter_application_1/Interfaz/Menu/Estilo/index.dart';
import 'package:flutter/material.dart';

import '../../../Data_types/sesion.dart';
//ignore: must_be_immutable
class EstadisticasAmigos extends StatefulWidget {
  EstadisticasAmigos(this._eU, {Key? key}) : super(key: key);
  EstadisticasUsuario _eU;

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _EstadisticasAmigosState createState() => _EstadisticasAmigosState(_eU);
}

class _EstadisticasAmigosState extends State<EstadisticasAmigos> {
  EstadisticasUsuario _eU;
  _EstadisticasAmigosState(this._eU);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                        color: const Color.fromARGB(255, 255, 255, 255),
                        width: 3,
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          //margin: const EdgeInsets.only(top: 5),
                          padding: const EdgeInsets.only(
                              top: 10.0, bottom: 4.0, left: 6.0, right: 6.0),
                          child: const Text(
                            'TOTAL',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontFamily: "Baskerville",
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 7, right: 7),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  ContainerPreguntas(
                                      number: _eU.getField(
                                          EstadisticasFieldsCodes.preguntas,
                                          TematicasEstadisticasCodes.totales)),
                                  Row(
                                    children: [
                                      ContainerIncorrectas(
                                          number: _eU.getField(
                                              EstadisticasFieldsCodes
                                                  .incorrectas,
                                              TematicasEstadisticasCodes
                                                  .totales)),
                                      ContainerCorrectas(
                                          number: _eU.getField(
                                              EstadisticasFieldsCodes.correctas,
                                              TematicasEstadisticasCodes
                                                  .totales)),
                                    ],
                                  ),
                                  ContainerPorcentaje(
                                      number: _eU.getField(
                                          EstadisticasFieldsCodes.acierto,
                                          TematicasEstadisticasCodes.totales)),
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
                      color: const Color.fromARGB(255, 33, 149, 243),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        width: 3,
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          //margin: const EdgeInsets.only(top: 5),
                          padding: const EdgeInsets.only(
                              top: 10.0, bottom: 4.0, left: 6.0, right: 6.0),
                          child: const Text(
                            'GEOGRAFÍA',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontFamily: "Baskerville",
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 7, right: 7),
                          child: Column(
                            children: [
                              ContainerPreguntas(
                                  number: _eU.getField(
                                      EstadisticasFieldsCodes.preguntas,
                                      TematicasEstadisticasCodes.geografia)),
                              Row(
                                children: [
                                  ContainerIncorrectas(
                                      number: _eU.getField(
                                          EstadisticasFieldsCodes.incorrectas,
                                          TematicasEstadisticasCodes
                                              .geografia)),
                                  ContainerCorrectas(
                                      number: _eU.getField(
                                          EstadisticasFieldsCodes.correctas,
                                          TematicasEstadisticasCodes
                                              .geografia)),
                                ],
                              ),
                              ContainerPorcentaje(
                                  number: _eU.getField(
                                      EstadisticasFieldsCodes.acierto,
                                      TematicasEstadisticasCodes.geografia)),
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
                        color: const Color.fromARGB(255, 255, 255, 255),
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
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontFamily: "Baskerville",
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 7, right: 7),
                          child: Column(
                            children: [
                              ContainerPreguntas(
                                  number: _eU.getField(
                                      EstadisticasFieldsCodes.preguntas,
                                      TematicasEstadisticasCodes.ciencia)),
                              Row(
                                children: [
                                  ContainerIncorrectas(
                                      number: _eU.getField(
                                          EstadisticasFieldsCodes.incorrectas,
                                          TematicasEstadisticasCodes.ciencia)),
                                  ContainerCorrectas(
                                      number: _eU.getField(
                                          EstadisticasFieldsCodes.correctas,
                                          TematicasEstadisticasCodes.ciencia)),
                                ],
                              ),
                              ContainerPorcentaje(
                                  number: _eU.getField(
                                      EstadisticasFieldsCodes.acierto,
                                      TematicasEstadisticasCodes.ciencia)),
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
                      color: const Color.fromARGB(255, 216, 189, 37),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        width: 3,
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          //margin: const EdgeInsets.only(top: 5),
                          padding: const EdgeInsets.only(
                              top: 10.0, bottom: 4.0, left: 6.0, right: 6.0),
                          child: const Text(
                            'HISTORIA',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontFamily: "Baskerville",
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 7, right: 7),
                          child: Column(
                            children: [
                              ContainerPreguntas(
                                  number: _eU.getField(
                                      EstadisticasFieldsCodes.preguntas,
                                      TematicasEstadisticasCodes.historia)),
                              Row(
                                children: [
                                  ContainerIncorrectas(
                                      number: _eU.getField(
                                          EstadisticasFieldsCodes.incorrectas,
                                          TematicasEstadisticasCodes.historia)),
                                  ContainerCorrectas(
                                      number: _eU.getField(
                                          EstadisticasFieldsCodes.correctas,
                                          TematicasEstadisticasCodes.historia)),
                                ],
                              ),
                              ContainerPorcentaje(
                                  number: _eU.getField(
                                      EstadisticasFieldsCodes.acierto,
                                      TematicasEstadisticasCodes.historia)),
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
                      color: const Color.fromARGB(255, 233, 30, 148),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        width: 3,
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          //margin: const EdgeInsets.only(top: 5),
                          padding: const EdgeInsets.only(
                              top: 10.0, bottom: 4.0, left: 6.0, right: 6.0),
                          child: const Text(
                            'ENTRETENIMIENTO',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontFamily: "Baskerville",
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 7, right: 7),
                          child: Column(
                            children: [
                              ContainerPreguntas(
                                  number: _eU.getField(
                                      EstadisticasFieldsCodes.preguntas,
                                      TematicasEstadisticasCodes
                                          .entretenimiento)),
                              Row(
                                children: [
                                  ContainerIncorrectas(
                                      number: _eU.getField(
                                          EstadisticasFieldsCodes.incorrectas,
                                          TematicasEstadisticasCodes
                                              .entretenimiento)),
                                  ContainerCorrectas(
                                      number: _eU.getField(
                                          EstadisticasFieldsCodes.correctas,
                                          TematicasEstadisticasCodes
                                              .entretenimiento)),
                                ],
                              ),
                              ContainerPorcentaje(
                                  number: _eU.getField(
                                      EstadisticasFieldsCodes.acierto,
                                      TematicasEstadisticasCodes
                                          .entretenimiento)),
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
                        color: const Color.fromARGB(255, 255, 255, 255),
                        width: 3,
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          //margin: const EdgeInsets.only(top: 5),
                          padding: const EdgeInsets.only(
                              top: 10.0, bottom: 4.0, left: 6.0, right: 6.0),
                          child: const Text(
                            'DEPORTES',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontFamily: "Baskerville",
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 7, right: 7),
                          child: Column(
                            children: [
                              ContainerPreguntas(
                                  number: _eU.getField(
                                      EstadisticasFieldsCodes.preguntas,
                                      TematicasEstadisticasCodes.deportes)),
                              Row(
                                children: [
                                  ContainerIncorrectas(
                                      number: _eU.getField(
                                          EstadisticasFieldsCodes.incorrectas,
                                          TematicasEstadisticasCodes.deportes)),
                                  ContainerCorrectas(
                                      number: _eU.getField(
                                          EstadisticasFieldsCodes.correctas,
                                          TematicasEstadisticasCodes.deportes)),
                                ],
                              ),
                              ContainerPorcentaje(
                                  number: _eU.getField(
                                      EstadisticasFieldsCodes.acierto,
                                      TematicasEstadisticasCodes.deportes)),
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
                        color: const Color.fromARGB(255, 255, 255, 255),
                        width: 3,
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          //margin: const EdgeInsets.only(top: 5),
                          padding: const EdgeInsets.only(
                              top: 10.0, bottom: 4.0, left: 6.0, right: 6.0),
                          child: const Text(
                            'ARTE Y LITERATURA',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontFamily: "Baskerville",
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 7, right: 7),
                          child: Column(
                            children: [
                              ContainerPreguntas(
                                  number: _eU.getField(
                                      EstadisticasFieldsCodes.preguntas,
                                      TematicasEstadisticasCodes.arte)),
                              Row(
                                children: [
                                  ContainerIncorrectas(
                                      number: _eU.getField(
                                          EstadisticasFieldsCodes.incorrectas,
                                          TematicasEstadisticasCodes.arte)),
                                  ContainerCorrectas(
                                      number: _eU.getField(
                                          EstadisticasFieldsCodes.correctas,
                                          TematicasEstadisticasCodes.arte)),
                                ],
                              ),
                              ContainerPorcentaje(
                                  number: _eU.getField(
                                      EstadisticasFieldsCodes.acierto,
                                      TematicasEstadisticasCodes.arte)),
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
    );
  }
}
