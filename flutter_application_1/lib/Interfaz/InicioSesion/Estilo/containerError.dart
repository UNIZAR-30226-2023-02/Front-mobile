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
