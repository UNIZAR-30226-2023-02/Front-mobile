import 'package:flutter_application_1/Data_types/estadisticas.dart';
import 'package:flutter_application_1/Interfaz/Menu/index.dart';

import 'package:flutter/material.dart';

import '../../../Data_types/sesion.dart';

class Estadisticas extends StatelessWidget {
  final EstadisticasUsuario _eU;
  final Sesion _s;
  const Estadisticas(this._s,this._eU, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return 
    WillPopScope(onWillPop: () async {
      Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Menu(_s)),
                (Route<dynamic> route) => false);
                return false;
    },child: Scaffold(
      resizeToAvoidBottomInset: false,
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
                padding: const EdgeInsets.only(top: 20.0),
                child: const Text(
                  'Mis estadísticas',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFc9c154),
                    fontFamily: "Baskerville",
                  ),
                ),
              ),
              Container(
                height: 225,
                margin: const EdgeInsets.only(left: 35,right: 35,top: 5),
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
                                
                                height: 210,
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
                                          top: 5.0,
                                          left: 6.0,
                                          right: 6.0),
                                      child: const Text(
                                        'TOTAL',
                                        style: TextStyle(
                                          fontSize: 18.0,
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
                                               ContainerPreguntas(
                                                  number: _eU.getField(EstadisticasFieldsCodes.preguntas, TematicasEstadisticasCodes.totales)),
                                              Row(
                                                children: [
                                                  ContainerIncorrectas(
                                                      number: _eU.getField(EstadisticasFieldsCodes.incorrectas, TematicasEstadisticasCodes.totales)),
                                                  ContainerCorrectas(
                                                      number: _eU.getField(EstadisticasFieldsCodes.correctas, TematicasEstadisticasCodes.totales)),
                                                ],
                                              ),
                                              ContainerPorcentaje(
                                                  number: _eU.getField(EstadisticasFieldsCodes.acierto, TematicasEstadisticasCodes.totales)),
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
                                height: 210,
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
                                          top: 5.0,
                                          left: 6.0,
                                          right: 6.0),
                                      child: const Text(
                                        'GEOGRAFÍA',
                                        style: TextStyle(
                                          fontSize: 18.0,
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
                                               ContainerPreguntas(
                                                  number: _eU.getField(EstadisticasFieldsCodes.preguntas, TematicasEstadisticasCodes.geografia)),
                                              Row(
                                                children: [
                                                  ContainerIncorrectas(
                                                      number: _eU.getField(EstadisticasFieldsCodes.incorrectas, TematicasEstadisticasCodes.geografia)),
                                                  ContainerCorrectas(
                                                      number: _eU.getField(EstadisticasFieldsCodes.correctas, TematicasEstadisticasCodes.geografia)),
                                                ],
                                              ),
                                              ContainerPorcentaje(
                                                  number: _eU.getField(EstadisticasFieldsCodes.acierto, TematicasEstadisticasCodes.geografia)),
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
                                height: 210,
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
                                          top: 5.0, left: 6.0, right: 6.0),
                                      child: const Text(
                                        'CIENCIA',
                                        style: TextStyle(
                                          fontSize: 18.0,
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
                                               ContainerPreguntas(
                                                  number: _eU.getField(EstadisticasFieldsCodes.preguntas, TematicasEstadisticasCodes.ciencia)),
                                              Row(
                                                children: [
                                                  ContainerIncorrectas(
                                                      number: _eU.getField(EstadisticasFieldsCodes.incorrectas, TematicasEstadisticasCodes.ciencia)),
                                                  ContainerCorrectas(
                                                      number: _eU.getField(EstadisticasFieldsCodes.correctas, TematicasEstadisticasCodes.ciencia)),
                                                ],
                                              ),
                                              ContainerPorcentaje(
                                                  number: _eU.getField(EstadisticasFieldsCodes.acierto, TematicasEstadisticasCodes.ciencia)),
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
                                height: 210,
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
                                          top: 5.0,
                                          left: 6.0,
                                          right: 6.0),
                                      child: const Text(
                                        'HISTORIA',
                                        style: TextStyle(
                                          fontSize: 18.0,
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
                                               ContainerPreguntas(
                                                  number: _eU.getField(EstadisticasFieldsCodes.preguntas, TematicasEstadisticasCodes.historia)),
                                              Row(
                                                children: [
                                                  ContainerIncorrectas(
                                                      number: _eU.getField(EstadisticasFieldsCodes.incorrectas, TematicasEstadisticasCodes.historia)),
                                                  ContainerCorrectas(
                                                      number: _eU.getField(EstadisticasFieldsCodes.correctas, TematicasEstadisticasCodes.historia)),
                                                ],
                                              ),
                                              ContainerPorcentaje(
                                                  number: _eU.getField(EstadisticasFieldsCodes.acierto, TematicasEstadisticasCodes.historia)),
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
                                height: 210,
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
                                          top: 5.0,
                                          left: 6.0,
                                          right: 6.0),
                                      child: const Text(
                                        'ENTRETENIMIENTO',
                                        style: TextStyle(
                                          fontSize: 18.0,
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
                                               ContainerPreguntas(
                                                  number: _eU.getField(EstadisticasFieldsCodes.preguntas, TematicasEstadisticasCodes.entretenimiento)),
                                              Row(
                                                children: [
                                                  ContainerIncorrectas(
                                                      number: _eU.getField(EstadisticasFieldsCodes.incorrectas, TematicasEstadisticasCodes.entretenimiento)),
                                                  ContainerCorrectas(
                                                      number: _eU.getField(EstadisticasFieldsCodes.correctas, TematicasEstadisticasCodes.entretenimiento)),
                                                ],
                                              ),
                                              ContainerPorcentaje(
                                                  number: _eU.getField(EstadisticasFieldsCodes.acierto, TematicasEstadisticasCodes.entretenimiento)),
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
                                height: 210,
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
                                          top: 5.0,
                                          left: 6.0,
                                          right: 6.0),
                                      child: const Text(
                                        'DEPORTES',
                                        style: TextStyle(
                                          fontSize: 18.0,
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
                                               ContainerPreguntas(
                                                  number: _eU.getField(EstadisticasFieldsCodes.preguntas, TematicasEstadisticasCodes.deportes)),
                                              Row(
                                                children: [
                                                  ContainerIncorrectas(
                                                      number: _eU.getField(EstadisticasFieldsCodes.incorrectas, TematicasEstadisticasCodes.deportes)),
                                                  ContainerCorrectas(
                                                      number: _eU.getField(EstadisticasFieldsCodes.correctas, TematicasEstadisticasCodes.deportes)),
                                                ],
                                              ),
                                              ContainerPorcentaje(
                                                  number: _eU.getField(EstadisticasFieldsCodes.acierto, TematicasEstadisticasCodes.deportes)),
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
                                height: 210,
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
                                          top: 5.0,
                                          left: 6.0,
                                          right: 6.0),
                                      child: const Text(
                                        'ARTE Y LITERATURA',
                                        style: TextStyle(
                                          fontSize: 18.0,
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
                                               ContainerPreguntas(
                                                  number: _eU.getField(EstadisticasFieldsCodes.preguntas, TematicasEstadisticasCodes.arte)),
                                              Row(
                                                children: [
                                                  ContainerIncorrectas(
                                                      number: _eU.getField(EstadisticasFieldsCodes.incorrectas, TematicasEstadisticasCodes.arte)),
                                                  ContainerCorrectas(
                                                      number: _eU.getField(EstadisticasFieldsCodes.correctas, TematicasEstadisticasCodes.arte)),
                                                ],
                                              ),
                                              ContainerPorcentaje(
                                                  number: _eU.getField(EstadisticasFieldsCodes.acierto, TematicasEstadisticasCodes.arte)),
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
              Align(
                alignment: Alignment.bottomCenter,
                child:
                  Container(
                    margin: const EdgeInsets.only(left: 0.0, top: 5),
                    child: Boton1(
                      "MENU",
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Menu(_s)),
                (Route<dynamic> route) => false);
                      },
                    ),
                  ),
              ),
            ],
          ),
        ),
      ),),
    );
  }
}
