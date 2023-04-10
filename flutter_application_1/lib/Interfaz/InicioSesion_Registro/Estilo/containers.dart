import 'dart:math';

import 'package:flutter/material.dart';

class ContainerError1 extends StatelessWidget {
  const ContainerError1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 300,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFFb13636),
              width: 2,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 50, top: 2),
          child: CustomPaint(
            size: const Size(20, 15),
            painter: Triangulo(),
          ),
        ),
      ],
    );
  }
}

class ContainerError2 extends StatelessWidget {
  const ContainerError2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 1),
          child: Container(
            width: 290,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xFFb13636),
                width: 2,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 0, top: 23),
          child: Transform.rotate(
            angle: -pi / 2,
            child: CustomPaint(
              size: const Size(20, 15),
              painter: Triangulo(),
            ),
          ),
        ),
      ],
    );
  }
}

class Triangulo extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();

    path.moveTo(0, 0);
    path.lineTo(size.width / 2, -size.height);
    path.lineTo(size.width, 0);
    canvas.drawPath(path, Paint()..color = Colors.white);
    canvas.drawPath(
        path,
        Paint()
          ..color = const Color(0xFFb13636)
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

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
