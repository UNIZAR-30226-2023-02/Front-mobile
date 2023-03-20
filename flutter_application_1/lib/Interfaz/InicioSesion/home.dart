

import 'package:flutter/material.dart';


class Home extends StatelessWidget{
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        //margin: EdgeInsets.symmetric(horizontal: w*0.01,vertical: h*0.01 ),
        // ignore: prefer_const_constructors
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage('assets/tapete.png'),
            fit:BoxFit.fill
          ),
        ),
        // ignore: prefer_const_constructors
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget> [
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[const Text("Trivial B2B",
                            style: TextStyle(fontFamily: "Baskerville",fontSize: 50.0, color: Color(0xFFc9c154),fontWeight: FontWeight.bold,decoration: TextDecoration.none ),),
                        Image.asset('assets/quesito.png')]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [Column(children:[SizedBox(height: 30),BotonHome("INICIAR SESIÓN")]),
              Column(children:[SizedBox(height: 30),BotonHome("REGISTRARSE")])]
            )]
            )
          );
  }
}

class BotonHome extends StatelessWidget{
  const BotonHome(String t,{Key? key}) : text = t, super(key: key);
  final String text;
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
                      borderRadius: BorderRadius.circular(16),
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
                    padding: const EdgeInsets.all(16.0),
                    textStyle: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20,fontFamily: "Georgia"),
                  ),
                  onPressed: () {print("hola" + text);},
                  child: Text(text),
                ),
              ],
            ),
          );
  }

}