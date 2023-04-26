import 'dart:math';

import 'package:flutter/material.dart';

class AnimacionImagen extends StatefulWidget {
  const AnimacionImagen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AnimacionImagenState createState() => _AnimacionImagenState();
}

class _AnimacionImagenState extends State<AnimacionImagen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat();

    _animation =
        Tween<double>(begin: 0, end: 2 * pi).animate(animationController);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
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

class ColorChangingText extends StatefulWidget {
  @override
  _ColorChangingTextState createState() => _ColorChangingTextState();
}

class _ColorChangingTextState extends State<ColorChangingText>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Color> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);
    _colorAnimation = ColorTween(begin: Colors.red, end: Colors.blue)
        .animate(_animationController) as Animation<Color>;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _colorAnimation,
      builder: (context, child) {
        return Text(
          'Color changing text',
          style: TextStyle(color: _colorAnimation.value),
        );
      },
    );
  }
}
