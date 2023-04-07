import 'dart:math';

import 'package:flutter/material.dart';

class AnimacionImagen extends StatefulWidget {
  @override
  _AnimacionImagenState createState() => new _AnimacionImagenState();
}

class _AnimacionImagenState extends State<AnimacionImagen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
      vsync: this,
      duration: new Duration(milliseconds: 1000),
    )..repeat();

    _animation =
        Tween<double>(begin: 0, end: 2 * pi).animate(animationController);
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: AnimatedBuilder(
      animation: _animation,
      child: Image.asset('assets/trivial_blanco.png'),
      builder: (contex, child) =>
          Transform.rotate(angle: _animation.value, child: child),
    ));
  }
}
