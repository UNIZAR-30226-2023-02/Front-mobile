import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() => runApp(HomeMenu());

class HomeMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: _Menu(),
    );
  }
}

class _Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pulsa las secciones'),
      ),
      body: Center(
        child: GestureDetector(
          child: CustomPaint(
            size: Size(200, 200),
            painter: MyPainter(),
          ),
          onTapDown: (details) {
            RenderBox box = context.findRenderObject() as RenderBox;
            Offset localPosition = box.globalToLocal(details.globalPosition);
            MyPainter.updatePosition(localPosition);

            int section = getSection(localPosition);
            String message =
                "Has pulsado la sección ${getSectionColorName(section)}";
            final snackBar = SnackBar(content: Text(message));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  static Paint redPaint = Paint()..color = Colors.red;
  static Paint bluePaint = Paint()..color = Colors.blue;
  static Paint greenPaint = Paint()..color = Colors.green;
  static Paint yellowPaint = Paint()..color = Colors.yellow;
  static Paint pinkPaint = Paint()..color = Colors.pink;
  static Paint purplePaint = Paint()..color = Colors.purple;

  static Offset position = Offset.zero;

  static void updatePosition(Offset newPosition) {
    position = newPosition;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = size.width / 2;

    canvas.drawCircle(Offset.zero, radius, redPaint);

    final double angle = 2 * math.pi / 6;

    for (int i = 0; i < 6; i++) {
      final double startAngle = i * angle - math.pi / 2;
      final double endAngle = (i + 1) * angle - math.pi / 2;

      final path = Path()
        ..moveTo(0, 0)
        ..lineTo(radius * math.cos(startAngle), radius * math.sin(startAngle))
        ..arcTo(Rect.fromCircle(center: Offset.zero, radius: radius),
            startAngle, angle, false)
        ..lineTo(0, 0);

      switch (i) {
        case 0:
          canvas.drawPath(path, bluePaint);
          break;
        case 1:
          canvas.drawPath(path, greenPaint);
          break;
        case 2:
          canvas.drawPath(path, yellowPaint);
          break;
        case 3:
          canvas.drawPath(path, pinkPaint);
          break;
        case 4:
          canvas.drawPath(path, purplePaint);
          break;
        case 5:
          canvas.drawPath(path, bluePaint);
          break;
      }
    }

    if (position != null) {
      canvas.drawCircle(position, 10, redPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

int getSection(Offset position) {
  final double radius = 100;
  final double angle = 2 * math.pi / 6;

  double sectionAngle = math.atan2(position.dy, position.dx);
  if (sectionAngle < 0) {
    sectionAngle += 2 * math.pi;
  }

  int section = (sectionAngle / angle).floor();
  return section;
}

String getSectionColorName(int section) {
  switch (section) {
    case 0:
      return "azul";
    case 1:
      return "verde";
    case 2:
      return "amarillo";
    case 3:
      return "rosa";
    case 4:
      return "morado";
    case 5:
      return "azul claro";
    default:
      return "";
  }
}
