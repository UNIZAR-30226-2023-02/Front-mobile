import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../Data_types/sesion.dart';
import '../home.dart';
import 'package:flutter_application_1/Interfaz/Menu/index.dart';

import 'package:flutter_application_1/Interfaz/Menu/Estilo/index.dart';

class RedesSociales extends StatelessWidget {
  final Sesion _s;
  const RedesSociales(this._s, {Key? key}) : super(key: key);

  _lanzarUrl() async {
    const url = 'https://www.gmail.com';

    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(
      uri,
    )) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      // can't launch url
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Menu(_s)),
            (Route<dynamic> route) => false);
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
          child: Form(
            child: Stack(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  padding: const EdgeInsets.only(top: 40.0),
                  child: const Text(
                    'Redes Sociales',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFc9c154),
                      fontFamily: "Baskerville",
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: const EdgeInsets.only(left: 0.0, bottom: 40),
                    child: Boton1(
                      "MENU",
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => Menu(_s)),
                            (Route<dynamic> route) => false);
                      },
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: const EdgeInsets.only(left: 0.0, bottom: 180),
                    child: Boton1(
                      "url",
                      onPressed: () {
                        _lanzarUrl();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
