import 'package:flutter/material.dart';

class ContainerLabelForm extends StatelessWidget {
  String texto;
  ContainerLabelForm(String t, {Key? key})
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
