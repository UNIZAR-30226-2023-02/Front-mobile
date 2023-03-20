// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Api/api.dart';

class InicioSesion extends StatefulWidget {
  const InicioSesion({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _InicioSesionState createState() => _InicioSesionState();
}

class _InicioSesionState extends State<InicioSesion> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late String _usuario,_contrasenya;
  
  // ignore: non_constant_identifier_names
  void Printear(){
    LoginUserResponse r = iniciarSesionUsuario(LoginUserPetition(_usuario, _contrasenya)) as LoginUserResponse;
    // ignore: avoid_print
    print('Hola ${r.OK} ${r.token} ${r.error_username} ${r.error_password}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: SingleChildScrollView (  //SOLUCION FONDO DE PANTALLA SE ESTRECHA AL SACAR TECLADO
      body: Container (
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/tapete.png'),
            fit:BoxFit.fill,
            // contentMode = .ScaleAspectFill,
            // alignment: Alignment.topCenter,
          ),
        ),
        child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 30),
            padding: const EdgeInsets.all(16.0),
            child: const Text(
              'Iniciar sesión',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFc9c154),
                fontFamily: "Baskerville",
              ),
            ),
          ),
          
//TEXTO USUARIO-------------------------------------------------------------
          Container(  
            padding: const EdgeInsets.symmetric(horizontal: 16),
            margin: const EdgeInsets.only(right: 480, bottom: 5, top: 0),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Usuario',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontFamily: "Baskerville",
                      color: Colors.white
                      ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            margin: const EdgeInsets.only(left: 60, right: 280),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
                width: 2,
                ),
              color: Colors.white.withOpacity(0),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _userController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Ingrese su usuario',
                    hintStyle: TextStyle(
                      fontFamily: "Baskerville",
                      fontSize: 18.0,
                      color: Colors.white
                    ),
                  ),
                  validator : (value) {
                    if (value!.isEmpty) {
                      return 'Por favor ingresa tu nombre';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _usuario = value!;
                  },
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),          
//TEXTO CONTRASEÑA-------------------------------------------------------------
          Container(  
            padding: const EdgeInsets.symmetric(horizontal: 16),
            margin: const EdgeInsets.only(right: 445, bottom: 5, top: 20),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Contraseña',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontFamily: "Baskerville",
                      color: Colors.white
                      ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            margin: const EdgeInsets.only(left: 60, right: 280),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
                width: 2,
                ),
              color: Colors.white.withOpacity(0),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Ingrese la contraseña',
                    hintStyle: TextStyle(
                      fontFamily: "Baskerville",
                      fontSize: 18.0,
                      color: Colors.white
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor ingresa tu contraseña';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _contrasenya = value!;
                  },
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),




          const SizedBox(height: 32),
          Container (
            margin: const EdgeInsets.only(top: 0),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [Column(children:[SizedBox(height: 5),BotonHome("VOLVER")]),
              Column(children:[SizedBox(height: 5),BotonHome("ENTRAR")])]
            ),
          ),
        ],
      ),
      ),
      // ),
    );
  }

  @override
  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}



class BotonHome extends StatelessWidget{
  final String textContrasenya;

  const BotonHome(String t,{Key? key,}) : textContrasenya = t, super(key: key);
  
  @override
  Widget build(BuildContext context) {
    // ignore: dead_code
    return 
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[
                          Color(0xFFdee8eb),
                          Color(0xFFb0c7d0)
                        ],
                        stops: [0.4,1.0],
                        
                      ),
                    ),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFF004461),
                    // padding: const EdgeInsets.all(16.0),
                    padding:  const EdgeInsets.only(top: 4, bottom: 4, left: 15, right: 15),
                    textStyle: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18,fontFamily: "Georgia"),
                  ),
                  onPressed: (){ },
                  child: Text(textContrasenya),
                ),
              ],
            ),
          );
  }

}

Future<void> checkLogin(){

}