import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../Data_types/sesion.dart';
import '../home.dart';
import 'package:flutter_application_1/Interfaz/Menu/index.dart';

import 'package:flutter_application_1/Interfaz/Menu/Estilo/index.dart';

class RedesSociales extends StatelessWidget {
  final Sesion _s;
  const RedesSociales(this._s, {Key? key}) : super(key: key);
  static const String InstagramUrl = "https://www.instagram.com/trivialb2b/",
      FacebookUrl = "https://www.facebook.com/profile.php?id=100089906757742",
      TwitterUrl = "https://twitter.com/TrivialB2B";

  _lanzarUrl(String url) async {
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
          child: Form(child: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.topCenter,
                    padding: const EdgeInsets.only(top: 40.0),
                    child: const Text(
                      'Contacto y redes sociales',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFc9c154),
                        fontFamily: "Baskerville",
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      margin: EdgeInsets.only(
                          left: constraints.maxWidth / 20,
                          bottom: constraints.maxHeight / 8),
                      child: Boton1(
                        "MENU",
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true)
                              .pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => Menu(_s)),
                                  (Route<dynamic> route) => false);
                        },
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: constraints.maxWidth / 5,
                          top: constraints.maxHeight / 3),
                      child: GestureDetector(
                        onTap: () {
                          _lanzarUrl(InstagramUrl);
                        },
                        child: Stack(
                          children: [
                            Container(
                              width: constraints.maxWidth / 8,
                              height: constraints.maxHeight / 8,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('assets/Instagram.png'),
                                      fit: BoxFit.scaleDown)),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: constraints.maxWidth / 10,
                                top: constraints.maxHeight / 25,
                              ),
                              child: const Text(
                                "TrivialB2B",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontFamily: "Baskerville",
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: constraints.maxWidth / 2,
                          top: constraints.maxHeight / 3),
                      child: GestureDetector(
                        onTap: () {
                          _lanzarUrl(TwitterUrl);
                        },
                        child: Stack(
                          children: [
                            Container(
                              width: constraints.maxWidth / 8,
                              height: constraints.maxHeight / 8,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('assets/Twitter.png'),
                                      fit: BoxFit.scaleDown)),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: constraints.maxWidth / 10,
                                top: constraints.maxHeight / 25,
                              ),
                              child: const Text(
                                "TrivialB2B",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontFamily: "Baskerville",
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: constraints.maxWidth / 5,
                          top: constraints.maxHeight / 1.8),
                      child: GestureDetector(
                        onTap: () {
                          _lanzarUrl(FacebookUrl);
                        },
                        child: Stack(
                          children: [
                            Container(
                              width: constraints.maxWidth / 8,
                              height: constraints.maxHeight / 8,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('assets/Facebook.png'),
                                      fit: BoxFit.scaleDown)),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: constraints.maxWidth / 10,
                                top: constraints.maxHeight / 25,
                              ),
                              child: const Text(
                                "TrivialB2B",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontFamily: "Baskerville",
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: constraints.maxWidth / 2,
                          top: constraints.maxHeight / 1.8),
                      child: Stack(
                        children: [
                          Container(
                            width: constraints.maxWidth / 8,
                            height: constraints.maxHeight / 8,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/Gmail.png'),
                                    fit: BoxFit.scaleDown)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: constraints.maxWidth / 10,
                              top: constraints.maxHeight / 25,
                            ),
                            child: const Text(
                              "trivialB2B@gmail.com",
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: "Baskerville",
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(
                          right: constraints.maxWidth / 10,
                          bottom: constraints.maxHeight / 10),
                      child: Stack(
                        children: [
                          SizedBox(
                            width: constraints.maxWidth / 8,
                            height: constraints.maxHeight / 8,
                            child: const Icon(
                              Icons.phone,
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: constraints.maxWidth / 10,
                              top: constraints.maxHeight / 25,
                            ),
                            child: const Text(
                              "605828074",
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: "Baskerville",
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          )),
        ),
      ),
    );
  }
}
