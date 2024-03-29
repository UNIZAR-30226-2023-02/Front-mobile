// ignore_for_file: unnecessary_new, no_leading_underscores_for_local_identifiers

import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_application_1/Api/api.dart';
import 'package:flutter_application_1/Data_types/sesion.dart';

import 'package:flutter_application_1/Interfaz/InicioSesion_Registro/Estilo/index.dart';

import 'package:flutter_application_1/Data_types/registro.dart';
import 'package:flutter_application_1/Interfaz/InicioSesion_Registro/index.dart';
import 'package:flutter_application_1/Interfaz/Menu/home.dart';

//ignore: must_be_immutable
class RegistrandoUsuario extends StatefulWidget {
  Registro r;
  RegistrandoUsuario(this.r, {Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _RegistrandoUsuario createState() => _RegistrandoUsuario(r);
}

class _RegistrandoUsuario extends State<RegistrandoUsuario> {
  Registro _r;
  late Timer _timer1, _timer2;

  int contador = 0;
  bool registrado = false;

  _RegistrandoUsuario(this._r);

  @override
  void initState() {
    super.initState();
    _setTimer();
    _comprobarRegistrarUsuario();
  }

  void _comprobarRegistrarUsuario() async {
    if (contador < 3) {
      Future<RegistroUserResponse> f = registroUsuario(RegistroUserPetition(
          _r.getField(RegistroFieldsCodes.usuario),
          _r.getField(RegistroFieldsCodes.contrasena),
          _r.getField(RegistroFieldsCodes.confirmarContrasena),
          _r.getField(RegistroFieldsCodes.fechaNacimiento),
          _r.getField(RegistroFieldsCodes.correoElectronico),
          _r.getField(RegistroFieldsCodes.telefonoMovil)));
      RegistroUserResponse re = await f;

      if (re.OK) {
        registrado = true;
      } else {
        _timer1 = Timer(
            const Duration(milliseconds: 500), _comprobarRegistrarUsuario);
      }
    }
  }

  void _setTimer() {
    if (registrado) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => IniciandoSesionRegistro(
                  Sesion(usuario: _r.getField(RegistroFieldsCodes.usuario)),
                  _r.getField(RegistroFieldsCodes.contrasena))),
          (Route<dynamic> route) => false);
    } else if (contador < 3) {
      contador++;
      _timer2 = Timer(const Duration(seconds: 2), _setTimer);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ErrorRegistro(_r)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          // ignore: prefer_const_constructors
          decoration: BoxDecoration(
            image: const DecorationImage(
                image: AssetImage('assets/tapete.png'), fit: BoxFit.fill),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Stack(
              children: const [
                Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Text(
                    "Registrando usuario...",
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFf7f6f6),
                      fontFamily: "Bona Nova",
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 295),
                  child: SizedBox(
                    width: 60,
                    height: 60,
                    child: AnimacionImagen(),
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
