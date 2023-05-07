import 'package:flutter_application_1/Interfaz/Menu/home.dart';

import 'package:flutter/material.dart';

void main() => runApp(Estadisticas());

class Estadisticas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: _Estadisticas(),
    );
  }
}

class _Estadisticas extends StatelessWidget {
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
                height: 220,  //120 sin poner el precio
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
                          //TODAS LAS ESTADISTICAS

                          Container(
                            margin: const EdgeInsets.only(left: 7, right: 7),
                            child: Column(
                              children: [ 
                                //TODAS LAS TARJETAS DE ESTADISTICAS
                                Container(
                                  height: 85,
                                  width: 185,
                                  margin: const EdgeInsets.only(top: 5),
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 116, 116, 116),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      width: 3,
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        child: Column(
                                          children:[
                                            Container(
                                              alignment: Alignment.center,
                                              //margin: const EdgeInsets.only(top: 5),
                                              padding: const EdgeInsets.only(left: 46.0, top: 10.0),
                                              child: const Text(
                                                'Preguntas respondidas',
                                                style: TextStyle(
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(255, 255, 255, 255),
                                                  fontFamily: "Baskerville",
                                                ),
                                              ),
                                            ),

                                            Container(
                                              alignment: Alignment.center,
                                              //margin: const EdgeInsets.only(top: 5),
                                              padding: const EdgeInsets.only(top: 5.0),
                                              child: const Text(
                                                '200',
                                                style: TextStyle(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(255, 255, 255, 255),
                                                  fontFamily: "Baskerville",
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 70,
                                        width: 90,
                                        margin: const EdgeInsets.only(top: 5),
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(255, 231, 40, 26),
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(
                                            color: Color.fromARGB(255, 255, 255, 255),
                                            width: 3,
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Container(
                                              child: Column(
                                                children:[
                                                  Container(
                                                    alignment: Alignment.center,
                                                    //margin: const EdgeInsets.only(top: 5),
                                                    padding: const EdgeInsets.only(left: 5, right: 5, top: 10.0),
                                                    child: const Text(
                                                      'Icorrectas',
                                                      style: TextStyle(
                                                        fontSize: 14.0,
                                                        fontWeight: FontWeight.bold,
                                                        color: Color.fromARGB(255, 255, 255, 255),
                                                        fontFamily: "Baskerville",
                                                      ),
                                                    ),
                                                  ),

                                                  Container(
                                                    alignment: Alignment.center,
                                                    //margin: const EdgeInsets.only(top: 5),
                                                    padding: const EdgeInsets.only(top: 5.0),
                                                    child: const Text(
                                                      '100',
                                                      style: TextStyle(
                                                        fontSize: 20.0,
                                                        fontWeight: FontWeight.bold,
                                                        color: Color.fromARGB(255, 255, 255, 255),
                                                        fontFamily: "Baskerville",
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      Container(
                                        height: 70,
                                        width: 90,
                                        margin: const EdgeInsets.only(top: 5, left: 5),
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(255, 76, 175, 79),
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(
                                            color: Color.fromARGB(255, 255, 255, 255),
                                            width: 3,
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Container(
                                              child: Column(
                                                children:[
                                                  Container(
                                                    alignment: Alignment.center,
                                                    //margin: const EdgeInsets.only(top: 5),
                                                    padding: const EdgeInsets.only(left: 5, right: 5, top: 10.0),
                                                    child: const Text(
                                                      'Correctas',
                                                      style: TextStyle(
                                                        fontSize: 14.0,
                                                        fontWeight: FontWeight.bold,
                                                        color: Color.fromARGB(255, 255, 255, 255),
                                                        fontFamily: "Baskerville",
                                                      ),
                                                    ),
                                                  ),

                                                  Container(
                                                    alignment: Alignment.center,
                                                    //margin: const EdgeInsets.only(top: 5),
                                                    padding: const EdgeInsets.only(top: 5.0),
                                                    child: const Text(
                                                      '100',
                                                      style: TextStyle(
                                                        fontSize: 20.0,
                                                        fontWeight: FontWeight.bold,
                                                        color: Color.fromARGB(255, 255, 255, 255),
                                                        fontFamily: "Baskerville",
                                                      ),
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

                                Container(
                                  height: 35,
                                  width: 185,
                                  margin: const EdgeInsets.only(top: 5),
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 114, 165, 207),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      width: 3,
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        child: Row(
                                          children:[
                                            Container(
                                              alignment: Alignment.center,
                                              //margin: const EdgeInsets.only(top: 5),
                                              padding: const EdgeInsets.only(left: 38.0, top: 6.0),
                                              child: const Text(
                                                '%Acierto',
                                                style: TextStyle(
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(255, 255, 255, 255),
                                                  fontFamily: "Baskerville",
                                                ),
                                              ),
                                            ),

                                            Container(
                                              alignment: Alignment.center,
                                              //margin: const EdgeInsets.only(top: 5),
                                              padding: const EdgeInsets.only(left: 10.0, top: 6.0),
                                              child: const Text(
                                                '50%',
                                                style: TextStyle(
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(255, 255, 255, 255),
                                                  fontFamily: "Baskerville",
                                                ),
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

                          Container(
                            margin: const EdgeInsets.only(right: 7),
                            child: Column(
                              children: [ 
                                //TODAS LAS TARJETAS DE ESTADISTICAS
                                Container(
                                  height: 200,
                                  width: 156,
                                  margin: const EdgeInsets.only(top: 5),
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 33, 149, 243),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      width: 3,
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        //margin: const EdgeInsets.only(top: 5),
                                        padding: const EdgeInsets.all(16.0),
                                        child: const Text(
                                          'Geografía',
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(255, 255, 255, 255),
                                            fontFamily: "Baskerville",
                                          ),
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
                                  height: 200,
                                  width: 156,
                                  margin: const EdgeInsets.only(top: 5),
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 76, 175, 79),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      width: 3,
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        //margin: const EdgeInsets.only(top: 5),
                                        padding: const EdgeInsets.only(left: 35.0, top: 16.0),
                                        child: const Text(
                                          'Ciencia y naturaleza',
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(255, 255, 255, 255),
                                            fontFamily: "Baskerville",
                                          ),
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
                                  height: 200,
                                  width: 156,
                                  margin: const EdgeInsets.only(top: 5),
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 216, 189, 37),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      width: 3,
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        //margin: const EdgeInsets.only(top: 5),
                                        padding: const EdgeInsets.all(16.0),
                                        child: const Text(
                                          'Historia',
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(255, 255, 255, 255),
                                            fontFamily: "Baskerville",
                                          ),
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
                                  height: 200,
                                  width: 156,
                                  margin: const EdgeInsets.only(top: 5),
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 233, 30, 148),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      width: 3,
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        //margin: const EdgeInsets.only(top: 5),
                                        padding: const EdgeInsets.all(16.0),
                                        child: const Text(
                                          'Entretenimiento',
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(255, 255, 255, 255),
                                            fontFamily: "Baskerville",
                                          ),
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
                                  height: 200,
                                  width: 156,
                                  margin: const EdgeInsets.only(top: 5),
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 255, 153, 0),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      width: 3,
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        //margin: const EdgeInsets.only(top: 5),
                                        padding: const EdgeInsets.all(16.0),
                                        child: const Text(
                                          'Deporte',
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(255, 255, 255, 255),
                                            fontFamily: "Baskerville",
                                          ),
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
                                  height: 200,
                                  width: 156,
                                  margin: const EdgeInsets.only(top: 5),
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 231, 40, 26),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      width: 3,
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        //margin: const EdgeInsets.only(top: 5),
                                        padding: const EdgeInsets.all(16.0),
                                        child: const Text(
                                          'Arte y literatura',
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(255, 255, 255, 255),
                                            fontFamily: "Baskerville",
                                          ),
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
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 40.0, top: 15),
                    child: BotonHome(
                      "MENÚ",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Menu()),
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



class ObjetcButton extends StatelessWidget {
  final Color color = const Color.fromARGB(0, 66, 66, 66);
  final VoidCallback onPressed;
  final String pathImagen;

  const ObjetcButton({Key? key, required this.onPressed, required this.pathImagen}) : super(key: key);

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


class BotonHome extends StatelessWidget {
  final String textContrasenya;
  final VoidCallback onPressed;
  const BotonHome(String t, {Key? key, required this.onPressed})
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
              // padding: const EdgeInsets.all(16.0),
              padding:
                  const EdgeInsets.only(top: 4, bottom: 4, left: 30, right: 30),
              textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontFamily: "Georgia"),
            ),
            onPressed: onPressed,
            child: Text(textContrasenya),
          ),
        ],
      ),
    );
  }
}