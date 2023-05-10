import 'dart:math';

import 'package:flutter/material.dart';

class ContainerLabelForm extends StatelessWidget {
  final String texto;
  const ContainerLabelForm(String t, {Key? key})
      : texto = t,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            texto,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
                fontFamily: "Baskerville",
                color: Colors.white),
          ),
        ),
      ],
    );
  }
}

class ContainerTitle extends StatelessWidget {
  final String texto;
  const ContainerTitle(this.texto, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Container(
        alignment: Alignment.topCenter,
        child: Text(
          texto,
          style: const TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFFc9c154),
            fontFamily: "Baskerville",
          ),
        ),
      ),
    );
  }
}

class ContainerDatosRegistro extends StatelessWidget {
  final String label;
  final String data;
  ContainerDatosRegistro(this.label, this.data, {Key? key}) : super(key: key);

  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _textController.text = data;
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Color(0xfff7f6f6),
              fontFamily: "Baskerville",
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Container(
              width: 170,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 0, top: 0, bottom: 0),
                child: TextField(
                  keyboardType: TextInputType.none,
                  controller: _textController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Color(0xff164966),
                    fontFamily: "Baskerville",
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ContainerContrasenaRegistro extends StatefulWidget {
  final String label;
  final String data;
  const ContainerContrasenaRegistro(this.label, this.data, {Key? key})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _ContainerContrasenaRegistroState createState() =>
      _ContainerContrasenaRegistroState(label, data);
}

class _ContainerContrasenaRegistroState
    extends State<ContainerContrasenaRegistro> {
  final String label;
  final String data;

  _ContainerContrasenaRegistroState(this.label, this.data);

  bool _passwordVisible = false;
  final TextEditingController _passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _passwordController.text = data;
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Color(0xfff7f6f6),
              fontFamily: "Baskerville",
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Container(
              width: 170,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.only(left: 10, top: 0, bottom: 0),
                child: TextField(
                  keyboardType: TextInputType.none,
                  obscureText: !_passwordVisible,
                  controller: _passwordController,
                  readOnly: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        !_passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: const Color(0xff164966),
                      ),
                      onPressed: () {
                        // Update the state i.e. toogle the state of passwordVisible variable
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Color(0xff164966),
                    fontFamily: "Baskerville",
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ContainerPreguntas extends StatelessWidget {
  final String number;

  const ContainerPreguntas({Key? key, required this.number}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      width: 185,
      margin: const EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
        color: const Color.fromARGB(160, 116, 116, 116),
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
            padding: const EdgeInsets.only(top: 10.0),
            child: const Text(
              'Preguntas respondidas: ',
              style: TextStyle(
                fontSize: 13.0,
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
            child: Text(
              number,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 255, 255, 255),
                fontFamily: "Baskerville",
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ContainerIncorrectas extends StatelessWidget {
  final String number;

  const ContainerIncorrectas({Key? key, required this.number})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 90,
      margin: const EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
        color: const Color.fromARGB(220, 231, 40, 26),
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
            padding: const EdgeInsets.only(top: 10.0),
            child: const Text(
              'Incorrectas:',
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 255, 255, 255),
                fontFamily: "Baskerville",
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            //margin: const EdgeInsets.only(top: 5),
            padding: const EdgeInsets.only(top: 0.0),
            child: Text(
              number,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 255, 255, 255),
                fontFamily: "Baskerville",
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ContainerCorrectas extends StatelessWidget {
  final String number;

  const ContainerCorrectas({Key? key, required this.number}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 90,
      margin: const EdgeInsets.only(top: 5, left: 5),
      decoration: BoxDecoration(
        color: const Color.fromARGB(220, 76, 175, 79),
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
            padding: const EdgeInsets.only(left: 5, right: 5, top: 10.0),
            child: const Text(
              'Correctas',
              style: TextStyle(
                fontSize: 12.0,
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
            child: Text(
              number,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 255, 255, 255),
                fontFamily: "Baskerville",
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ContainerPorcentaje extends StatelessWidget {
  final String number;

  const ContainerPorcentaje({Key? key, required this.number}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 185,
      margin: const EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
        color: const Color.fromARGB(220, 114, 165, 207),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color.fromARGB(255, 255, 255, 255),
          width: 3,
        ),
      ),
      child: Row(
        children: [
          Container(
            alignment: Alignment.center,
            //margin: const EdgeInsets.only(top: 5),
            padding: const EdgeInsets.only(left: 38.0, top: 0.0),
            child: const Text(
              '%Acierto: ',
              textAlign: TextAlign.center,
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
            padding: const EdgeInsets.only(left: 10.0, top: 0.0),
            child: Text(
              '$number%',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 255, 255, 255),
                fontFamily: "Baskerville",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
