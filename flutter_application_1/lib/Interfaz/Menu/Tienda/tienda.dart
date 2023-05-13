import 'package:flutter_application_1/Interfaz/Menu/index.dart';
import 'package:flutter_application_1/Interfaz/Menu/Estilo/index.dart';
import 'package:flutter/material.dart';

import '../../../API/index.dart';
import '../../../Data_types/index.dart';

//ignore: must_be_immutable
class Tienda extends StatefulWidget {
  final Sesion _s;
  List<Ficha> _fichas;
  List<Tablero> _tableros;
  int _monedas;
  Tienda(this._s, this._fichas, this._tableros, this._monedas, {Key? key})
      : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() =>
      _TiendaState(_s, _fichas, _tableros, _monedas);
}

class _TiendaState extends State<Tienda> {
  final Sesion _s;
  List<Ficha> _fichas;
  List<Tablero> _tableros;
  int _monedas;
  bool _mostrarFichas = true, _mostrarObjeto = false;
  int _objeto = 0;
  int _indiceFichaUso = 0, _indiceTableroUso = 0;
  bool _errorComprarObjeto = false, _compraRealizada = false;
  String _sErrorComprarObjeto = "";

  _TiendaState(this._s, this._fichas, this._tableros, this._monedas);

  verObjeto(int index) {
    _objeto = index;
    _mostrarObjeto = true;
    setState(() {});
  }

  comprarObjeto() async {
    Future<ComprarObjetoTiendaResponse> f = comprarObjetoTienda(
        ComprarObjetoTiendaPetition(
            _s.getField(SesionFieldsCodes.token),
            _mostrarFichas
                ? _fichas[_objeto].getField(FichaFieldsCodes.id).toString()
                : _tableros[_objeto]
                    .getField(TableroFieldsCodes.id)
                    .toString()));
    ComprarObjetoTiendaResponse r = await f;

    if (r.OK) {
      int coste;
      if (_mostrarFichas) {
        _fichas[_objeto].setField(FichaFieldsCodes.adquirido, 1);
        coste = _fichas[_objeto].getField(FichaFieldsCodes.coste);
      } else {
        _tableros[_objeto].setField(TableroFieldsCodes.adquirido, 1);
        coste = _tableros[_objeto].getField(TableroFieldsCodes.coste);
      }
      _monedas -= coste;
      _compraRealizada = true;
    } else {
      _errorComprarObjeto = true;
      _sErrorComprarObjeto = r.error;
      if (_sErrorComprarObjeto == "") {
        _sErrorComprarObjeto = "No se pudo completar la compra";
      }
    }
    _mostrarObjeto = false;
    setState(() {});
  }

  seleccionarObjeto(int index) async {
    Future<UsarObjetoTiendaResponse> f = usarObjetoTienda(
        UsarObjetoTiendaPetition(
            _s.getField(SesionFieldsCodes.token),
            _mostrarFichas
                ? _fichas[index].getField(FichaFieldsCodes.id).toString()
                : _tableros[index].getField(TableroFieldsCodes.id).toString()));
    UsarObjetoTiendaResponse r = await f;
    if (r.OK) {
      if (_mostrarFichas) {
        _fichas[_indiceFichaUso].setField(FichaFieldsCodes.enUso, 0);
        _fichas[index].setField(FichaFieldsCodes.enUso, 1);
        _indiceFichaUso = index;
      } else {
        _tableros[_indiceTableroUso].setField(TableroFieldsCodes.enUso, 0);
        _tableros[index].setField(TableroFieldsCodes.enUso, 1);
        _indiceTableroUso = index;
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_mostrarObjeto) {
          _mostrarObjeto = false;
          setState(() {});
        } else if (_compraRealizada) {
          _compraRealizada = false;
          setState(() {});
        } else if (_errorComprarObjeto) {
          _errorComprarObjeto = false;
          setState(() {});
        } else {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Menu(_s)),
              (Route<dynamic> route) => false);
        }

        return false;
      },
      child: Scaffold(
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
          child: Stack(
            children: [
              Column(
                // mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 20, bottom: 10),
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
                  Stack(
                    children: [
                      Visibility(
                        visible: _mostrarFichas,
                        child: Column(
                          children: [
                            Container(
                              height: 200, //120 sin poner el precio
                              margin: const EdgeInsets.only(
                                  left: 60, right: 60, top: 10),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: const Color(0xFFc9c154),
                                  width: 3,
                                ),
                              ),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 5),
                                itemCount: _fichas.length,
                                itemBuilder: (context, index) {
                                  bool adquirido = _fichas[index].getField(
                                          FichaFieldsCodes.adquirido) !=
                                      0;
                                  bool uso = _fichas[index]
                                          .getField(FichaFieldsCodes.enUso) !=
                                      0;
                                  if (uso) {
                                    _indiceFichaUso = index;
                                  }
                                  return GestureDetector(
                                    onTap: () {
                                      if (adquirido) {
                                        if (!uso) {
                                          seleccionarObjeto(index);
                                        }
                                      } else {
                                        verObjeto(index);
                                      }
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          left: 10.0, right: 10.0),
                                      decoration: BoxDecoration(
                                          color: adquirido
                                              ? const Color.fromARGB(
                                                  255, 56, 111, 143)
                                              : const Color(0xFF164966),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                              color: uso
                                                  ? const Color(0xFFc9c154)
                                                  : Colors.white,
                                              width: 2.0)),
                                      child: Column(
                                        children: [
                                          Stack(
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
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            //margin: const EdgeInsets.only(top: 5),
                                            padding: const EdgeInsets.only(
                                                top: 10.0),
                                            child: uso
                                                ? const Text(
                                                    "En uso",
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color(0xFFc9c154),
                                                      fontFamily: "Baskerville",
                                                    ),
                                                  )
                                                : Text(
                                                    adquirido
                                                        ? "Comprado"
                                                        : '${_fichas[index].getField(FichaFieldsCodes.coste)} monedas',
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: adquirido
                                                          ? const Color(
                                                              0xFF3dce00)
                                                          : Colors.white,
                                                      fontFamily: "Baskerville",
                                                    ),
                                                  ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
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
                              height: 200, //120 sin poner el precio
                              margin: const EdgeInsets.only(
                                  left: 60, right: 60, top: 10),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: const Color(0xFFc9c154),
                                  width: 3,
                                ),
                              ),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 5),
                                itemCount: _tableros.length,
                                itemBuilder: (context, index) {
                                  bool adquirido = _tableros[index].getField(
                                          TableroFieldsCodes.adquirido) !=
                                      0;
                                  bool uso = _tableros[index]
                                          .getField(TableroFieldsCodes.enUso) !=
                                      0;
                                  if (uso) {
                                    _indiceTableroUso = index;
                                  }
                                  return GestureDetector(
                                    onTap: () {
                                      if (adquirido) {
                                        if (!uso) {
                                          seleccionarObjeto(index);
                                        }
                                      } else {
                                        verObjeto(index);
                                      }
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          left: 10.0, right: 10.0),
                                      decoration: BoxDecoration(
                                          color: adquirido
                                              ? const Color.fromARGB(
                                                  255, 56, 111, 143)
                                              : const Color(0xFF164966),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                              color: uso
                                                  ? const Color(0xFFc9c154)
                                                  : Colors.white,
                                              width: 2.0)),
                                      child: Column(
                                        children: [
                                          Stack(
                                            children: [
                                              Container(
                                                width: 140,
                                                height: 140,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                        '$urlDir${_tableros[index].getField(TableroFieldsCodes.imagen)}'),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            //margin: const EdgeInsets.only(top: 5),
                                            padding: const EdgeInsets.only(
                                                top: 10.0),
                                            child: uso
                                                ? const Text(
                                                    "En uso",
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color(0xFFc9c154),
                                                      fontFamily: "Baskerville",
                                                    ),
                                                  )
                                                : Text(
                                                    adquirido
                                                        ? "Comprado"
                                                        : '${_tableros[index].getField(TableroFieldsCodes.coste)} monedas',
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: adquirido
                                                          ? const Color(
                                                              0xFF3dce00)
                                                          : Colors.white,
                                                      fontFamily: "Baskerville",
                                                    ),
                                                  ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 40),
                            child: Boton1(
                              "MENÚ",
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Menu(_s)),
                                    (Route<dynamic> route) => false);
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 280, top: 10),
                          child: Row(
                            children: [
                              Text(
                                "Saldo : $_monedas",
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontFamily: "Baskerville",
                                ),
                              ),
                              Container(
                                width: 30,
                                height: 30,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/Moneda.png'),
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 40),
                            child: Stack(
                              children: [
                                Visibility(
                                  visible: _mostrarFichas,
                                  child: Boton1(
                                    "TABLEROS",
                                    onPressed: () {
                                      _mostrarFichas = false;
                                      setState(() {});
                                    },
                                  ),
                                ),
                                Visibility(
                                  visible: !_mostrarFichas,
                                  child: Boton1(
                                    "FICHAS",
                                    onPressed: () {
                                      _mostrarFichas = true;
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return Stack(
                    children: [
                      _mostrarObjeto
                          ? Container(
                              height: constraints.maxHeight,
                              width: constraints.maxWidth,
                              decoration:
                                  const BoxDecoration(color: Color(0x80444444)),
                              margin: const EdgeInsets.only(top: 0),
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  width: constraints.maxWidth / 1.5,
                                  height: constraints.maxHeight / 1.5,
                                  margin: const EdgeInsets.only(
                                      left: 10.0, right: 10.0),
                                  decoration: BoxDecoration(
                                      color: const Color(0xFF164966),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          color: Colors.white, width: 2.0)),
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 60),
                                          child: SizedBox(
                                            height: constraints.maxHeight / 2.0,
                                            width: constraints.maxWidth / 2.8,
                                            child: Text(
                                              _mostrarFichas
                                                  ? "¿Desea confirmar la compra de la ficha?"
                                                  : "¿Desea confirmar la compra del tablero?",
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontFamily: "Baskerville",
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 30),
                                          child: Container(
                                            width: 160,
                                            height: 200,
                                            decoration: BoxDecoration(
                                                color: const Color(0xFF164966),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                border: Border.all(
                                                    color: Colors.white,
                                                    width: 2.0)),
                                            child: Stack(
                                              children: [
                                                Container(
                                                  width: 140,
                                                  height: 140,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage(_mostrarFichas
                                                          ? '$urlDir${_fichas[_objeto].getField(FichaFieldsCodes.imagen)}'
                                                          : '$urlDir${_tableros[_objeto].getField(TableroFieldsCodes.imagen)}'),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  margin: const EdgeInsets
                                                      .symmetric(horizontal: 8),
                                                ),
                                                Container(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  //margin: const EdgeInsets.only(top: 5),
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10.0),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      bottom: 20,
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          _mostrarFichas
                                                              ? '${_fichas[_objeto].getField(FichaFieldsCodes.coste)}'
                                                              : '${_tableros[_objeto].getField(TableroFieldsCodes.coste)}',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 14.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white,
                                                            fontFamily:
                                                                "Baskerville",
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 30,
                                                          height: 30,
                                                          decoration:
                                                              const BoxDecoration(
                                                            image:
                                                                DecorationImage(
                                                              image: AssetImage(
                                                                  'assets/Moneda.png'),
                                                              fit: BoxFit
                                                                  .scaleDown,
                                                            ),
                                                          ),
                                                          margin:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      8),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 50, bottom: 40),
                                          child: Stack(
                                            children: [
                                              Boton1(
                                                "NO",
                                                onPressed: () {
                                                  _mostrarObjeto = false;
                                                  setState(() {});
                                                },
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 100),
                                                child: Boton1(
                                                  "SI",
                                                  onPressed: () {
                                                    comprarObjeto();
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                      _errorComprarObjeto
                          ? Container(
                              height: constraints.maxHeight,
                              width: constraints.maxWidth,
                              decoration:
                                  const BoxDecoration(color: Color(0x80444444)),
                              margin: const EdgeInsets.only(top: 0),
                              child: Align(
                                alignment: Alignment.center,
                                child: Stack(
                                  children: [
                                    Container(
                                      width: constraints.maxWidth / 2,
                                      height: constraints.maxHeight / 2.5,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 2,
                                        ),
                                      ),
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment: Alignment.topCenter,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 30),
                                              child: SizedBox(
                                                height:
                                                    constraints.maxHeight / 4.5,
                                                width:
                                                    constraints.maxWidth / 2.3,
                                                child: Text(
                                                  _sErrorComprarObjeto,
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      color: Color(0xFFb13636),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                      fontFamily: "Georgia"),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 20),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                child: Stack(
                                                  children: <Widget>[
                                                    Positioned.fill(
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                          color: Colors.black,
                                                          border: Border.all(
                                                              color:
                                                                  Colors.white,
                                                              width: 2),
                                                        ),
                                                      ),
                                                    ),
                                                    TextButton(
                                                      style:
                                                          TextButton.styleFrom(
                                                        foregroundColor:
                                                            Colors.white,
                                                        // padding: const EdgeInsets.all(16.0),
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 4,
                                                                bottom: 4,
                                                                left: 15,
                                                                right: 15),
                                                        textStyle:
                                                            const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 18,
                                                                fontFamily:
                                                                    "Georgia"),
                                                      ),
                                                      onPressed: () {
                                                        _errorComprarObjeto =
                                                            false;
                                                        setState(() {});
                                                      },
                                                      child:
                                                          const Text("ACEPTAR"),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                      _compraRealizada
                          ? Container(
                              height: constraints.maxHeight,
                              width: constraints.maxWidth,
                              decoration:
                                  const BoxDecoration(color: Color(0x80444444)),
                              margin: const EdgeInsets.only(top: 0),
                              child: Align(
                                alignment: Alignment.center,
                                child: Stack(
                                  children: [
                                    Container(
                                      width: constraints.maxWidth / 2,
                                      height: constraints.maxHeight / 2.5,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 2,
                                        ),
                                      ),
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment: Alignment.topCenter,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 30),
                                              child: SizedBox(
                                                height:
                                                    constraints.maxHeight / 4.5,
                                                width:
                                                    constraints.maxWidth / 2.3,
                                                child: const Text(
                                                  "Commpra completada",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Color(0xFF3dce00),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                      fontFamily: "Georgia"),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 20),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                child: Stack(
                                                  children: <Widget>[
                                                    Positioned.fill(
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                          color: Colors.black,
                                                          border: Border.all(
                                                              color:
                                                                  Colors.white,
                                                              width: 2),
                                                        ),
                                                      ),
                                                    ),
                                                    TextButton(
                                                      style:
                                                          TextButton.styleFrom(
                                                        foregroundColor:
                                                            Colors.white,
                                                        // padding: const EdgeInsets.all(16.0),
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 4,
                                                                bottom: 4,
                                                                left: 15,
                                                                right: 15),
                                                        textStyle:
                                                            const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 18,
                                                                fontFamily:
                                                                    "Georgia"),
                                                      ),
                                                      onPressed: () {
                                                        _compraRealizada =
                                                            false;
                                                        setState(() {});
                                                      },
                                                      child:
                                                          const Text("ACEPTAR"),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
