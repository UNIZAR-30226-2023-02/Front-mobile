import 'package:flutter_application_1/API/api.dart';
import 'package:flutter_application_1/Interfaz/Menu/index.dart';
import 'package:flutter/material.dart';

import '../../../Data_types/index.dart';

//ignore: must_be_immutable
class Tienda extends StatefulWidget {
  final Sesion _s;
  List<Ficha> _fichas;
  List<Tablero> _tableros;
  Tienda(this._s, this._fichas, this._tableros, {Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => _TiendaState(_s, _fichas, _tableros);
}

class _TiendaState extends State<Tienda> {
  final Sesion _s;
  List<Ficha> _fichas;
  List<Tablero> _tableros;
  Ficha _ficha = Ficha();
  Tablero _tablero = Tablero();
  bool _mostrarFichas = true, _mostrarFicha = false,_mostrarTablero = false;
  int objeto = 0;

  _TiendaState(this._s, this._fichas, this._tableros);

  verObjeto(int index) {
    
    if(_mostrarFichas){
       _ficha = _fichas[index];
       _mostrarFicha = true;
    }
    else {
      _tablero = _tableros[index];
      _mostrarTablero = true;
    }
    setState(() {});
  }

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
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.all(16.0),
              child: Text(
                _mostrarFichas ? "Tienda Fichas" : "Tienda Tableros",
                style: const TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFc9c154),
                  fontFamily: "Baskerville",
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xFFc9c154),
                    width: 2.0,
                  ),
                ),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
            ),
            Stack(children: [
              Visibility(
                visible: _mostrarFichas,
                child: Column(
                  children: [
                    Container(
                      height: 210, //120 sin poner el precio
                      margin: const EdgeInsets.only(left: 60,right: 60,top: 20),
                      decoration: BoxDecoration(
                        color:  Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color(0xFFc9c154),
                          width: 3,
                        ),
                      ),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        itemCount: _fichas.length,
                        itemBuilder: (context, index) {
                          bool adquirido = _fichas[index].getField(FichaFieldsCodes.adquirido) != 0;
                          return Container(
                            margin: const EdgeInsets.only(left: 10.0,right: 10.0),
                            decoration: BoxDecoration(
                              color: adquirido ? Color.fromARGB(255, 56, 111, 143): const Color(0xFF164966),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white,width: 2.0)
                            ),
                            child: Column(
                            children: [
                              GestureDetector(
                                onTap: (){
                                  verObjeto(index);
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      width: 140,
                                      height: 140,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              '$urlDir${_fichas[index].getField(FichaFieldsCodes.imagen)}'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                //margin: const EdgeInsets.only(top: 5),
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Text(
                                  adquirido ? "Comprado" : '${_fichas[index].getField(FichaFieldsCodes.coste)} monedas',
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontFamily: "Baskerville",
                                  ),
                                ),
                              ),
                            ],
                          ),);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: !_mostrarFichas,
                child: Column(
                  children: [
                    Container(
                      height: 155, //120 sin poner el precio
                      margin: const EdgeInsets.symmetric(horizontal: 35),
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color.fromARGB(255, 218, 173, 40),
                          width: 3,
                        ),
                      ),
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        itemCount: _tableros.length,
                        separatorBuilder: (context, index) => const Divider(
                          color: Colors.grey,
                          thickness: 1.5,
                        ),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: (){
                              verObjeto(index);
                            },
                            child: Stack(
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  color: const Color.fromARGB(0, 66, 66, 66),
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                ),
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          '$urlDir${_tableros[index].getField(TableroFieldsCodes.imagen)}'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 40.0, top: 15),
                  child: Boton1(
                    "MENÚ",
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => Menu(_s)),
                          (Route<dynamic> route) => false);
                    },
                  ),
                ),
                Stack(
                  children: [
                    Visibility(
                      visible: _mostrarFichas,
                      child: Container(
                        margin: const EdgeInsets.only(right: 40.0, top: 15),
                        child: Boton1(
                          "TABLEROS",
                          onPressed: () {
                            _mostrarFichas = false;
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                    Visibility(
                      visible: !_mostrarFichas,
                      child: Container(
                        margin: const EdgeInsets.only(right: 40.0, top: 15),
                        child: Boton1(
                          "FICHAS",
                          onPressed: () {
                            _mostrarFichas = true;
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
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
