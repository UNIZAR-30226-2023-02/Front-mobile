//API
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// Future<void> createUser(String username, String password) async {
//   final url = Uri.parse('https://7f05-146-158-156-138.eu.ngrok.io/api/usuarios/login/');
//   final response = await http.post(url, body: {
//     'username': username,
//     'password': password,
//   });
//   if (response.statusCode == 200) {
//     // Successful API call
//     print('User created successfully');
//   } else {
//     // Failed API call
//     print('Failed to create user');
//   }
// }

// void main() {
//   createUser('john_doe', 'password123');
// }































//PRUEBA TUTORIAL
// import 'package:flutter/material.dart';
// import 'package:english_words/english_words.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     //final wordPair = WordPair.random();
//     return MaterialApp(
//       //title: 'Welcome to Flutter',
//       //home: Scaffold(
//       title: 'Startup Name Generator',            
//       home: RandomWords(),
//       //   appBar: AppBar(
//       //     title: Text('Welcome to Flutter'),
//       //   ),
//       //   body: Center(
//       //     // child: Text('Hello World'),
//       //     //child: Text(wordPair.asPascalCase),   
//       //     child: RandomWords(),
//       //   ),
//       // ),
//     );
//   }
// }

// class RandomWordsState extends State<RandomWords> {
//   final _suggestions = <WordPair>[];
//   final _biggerFont = const TextStyle(fontSize: 18.0);

//   Widget _buildRow(WordPair pair) {
//     return ListTile(
//       title: Text(
//         pair.asPascalCase,
//         style: _biggerFont,
//       ),
//     );
//   }

//   Widget _buildSuggestions() {
//   return ListView.builder(
//       padding: const EdgeInsets.all(16.0),
//       itemBuilder: /*1*/ (context, i) {
//         if (i.isOdd) return Divider(); /*2*/

//         final index = i ~/ 2; /*3*/
//         if (index >= _suggestions.length) {
//           _suggestions.addAll(generateWordPairs().take(10)); /*4*/
//         }
//         return _buildRow(_suggestions[index]);
//       });
// }

//   // TODO Add build() method
//   // @override
//   // Widget build(BuildContext context) {
    
//   //   final wordPair = WordPair.random();
//   //   return Text(wordPair.asPascalCase);
//   // }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Startup Name Generator'),
//       ),
//       body: _buildSuggestions(),
//     );
//   }
// }

// class RandomWords extends StatefulWidget {
//   @override
//   RandomWordsState createState() => new RandomWordsState();
// }







// //INICIO SESION
// import 'package:flutter/material.dart';

// void main(){
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Formulario de dos campos',
//       theme: ThemeData(
//         primarySwatch: Colors.deepPurple,
//         accentColor: Colors.amber,
//         fontFamily: 'Quicksand',
//       ),
//       home: Scaffold(
//         // appBar: AppBar(
//         //   title: Text('Formulario de dos campos'),
//         // ),
//         body: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Colors.purple, Colors.deepPurple],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//           child: Center(
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   SizedBox(height: 50),
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 20),
//                     child: TextFormField(
//                       decoration: InputDecoration(
//                         labelText: 'Nombre',
//                         labelStyle: TextStyle(color: Colors.white),
//                         border: OutlineInputBorder(),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.white),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.amber),
//                         ),
//                       ),
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 20),
//                     child: TextFormField(
//                       decoration: InputDecoration(
//                         labelText: 'Email',
//                         labelStyle: TextStyle(color: Colors.white),
//                         border: OutlineInputBorder(),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.white),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.amber),
//                         ),
//                       ),
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                   SizedBox(height: 50),
//                   ElevatedButton(
//                     onPressed: () {},
//                     child: Text('Enviar'),
//                     style: ElevatedButton.styleFrom(
//                       primary: Colors.amber,
//                       onPrimary: Colors.deepPurple,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 50),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


// //INICIO SESION SIN BARRA DE NAVEGACION
// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Formulario de dos campos',
//       theme: ThemeData(
//         primarySwatch: Colors.deepPurple,
//         accentColor: Colors.amber,
//         fontFamily: 'Quicksand',
//       ),
//       home: SafeArea(
//         bottom: false,
//         child: Scaffold(
//           extendBody: true,
//           // appBar: AppBar(
//           //   title: Text('Formulario de dos campos'),
//           // ),
//           body: Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Colors.purple, Colors.deepPurple],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//             ),
//             child: Center(
//               child: SingleChildScrollView(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     SizedBox(height: 50),
//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 20),
//                       child: TextFormField(
//                         decoration: InputDecoration(
//                           labelText: 'Nombre',
//                           labelStyle: TextStyle(color: Colors.white),
//                           border: OutlineInputBorder(),
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.white),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.amber),
//                           ),
//                         ),
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 20),
//                       child: TextFormField(
//                         decoration: InputDecoration(
//                           labelText: 'Email',
//                           labelStyle: TextStyle(color: Colors.white),
//                           border: OutlineInputBorder(),
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.white),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(color: Colors.amber),
//                           ),
//                         ),
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                     SizedBox(height: 50),
//                     ElevatedButton(
//                       onPressed: () {},
//                       child: Text('Enviar'),
//                       style: ElevatedButton.styleFrom(
//                         primary: Colors.amber,
//                         onPrimary: Colors.deepPurple,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 50),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }








// //DADO
// import 'dart:math';
// import 'package:flutter/material.dart';

// void main() => runApp(DiceApp());

// class DiceApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Dado',
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Dado'),
//         ),
//         body: Center(
//           child: Dice(),
//         ),
//       ),
//     );
//   }
// }

// class Dice extends StatefulWidget {
//   @override
//   _DiceState createState() => _DiceState();
// }

// class _DiceState extends State<Dice> {
//   int _number = 1;

//   void _rollDice() {
//     setState(() {
//       _number = Random().nextInt(6) + 1;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: _rollDice,
//       child: Container(
//         padding: EdgeInsets.all(16.0),
//         decoration: BoxDecoration(
//           color: Colors.blueGrey,
//           borderRadius: BorderRadius.circular(16.0),
//         ),
//         child: Text(
//           '$_number',
//           style: TextStyle(
//             fontSize: 64.0,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//       ),
//     );
//   }
// }
