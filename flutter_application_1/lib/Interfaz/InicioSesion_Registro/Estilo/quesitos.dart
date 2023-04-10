import 'dart:ffi';

import 'package:flutter/material.dart';

class ContainerQuesitos extends StatefulWidget {
  List<bool> _quesitos;
  ContainerQuesitos(this._quesitos, {Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _ContainerQuesitosState createState() => _ContainerQuesitosState(_quesitos);
}

class _ContainerQuesitosState extends State<ContainerQuesitos> {
  List<bool> _quesitos;

  _ContainerQuesitosState(this._quesitos);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Image(
          image: AssetImage('assets/qBlancos.png'),
        ),
        Visibility(
          visible: _quesitos[0],
          child: const Image(
            image: AssetImage('assets/q1.png'),
          ),
        ),
        Visibility(
          visible: _quesitos[1],
          child: const Image(
            image: AssetImage('assets/q2.png'),
          ),
        ),
        Visibility(
          visible: _quesitos[2],
          child: const Image(
            image: AssetImage('assets/q3.png'),
          ),
        ),
        Visibility(
          visible: _quesitos[3],
          child: const Image(
            image: AssetImage('assets/q4.png'),
          ),
        ),
        Visibility(
          visible: _quesitos[4],
          child: const Image(
            image: AssetImage('assets/q5.png'),
          ),
        ),
        Visibility(
          visible: _quesitos[5],
          child: const Image(
            image: AssetImage('assets/q6.png'),
          ),
        ),
      ],
    );
  }
}
