import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vet App',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue, // Colore principale
        scaffoldBackgroundColor: Colors.blue[50], // Sfondo leggero
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.lightBlue,
        ).copyWith(
          secondary: Colors.blueAccent, // Colore secondario
        ),
        textTheme: TextTheme(
          displayLarge: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.blue[900]), // Titoli
          bodyLarge:
              TextStyle(fontSize: 16, color: Colors.black87), // Testo normale
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.lightBlue, // Barra superiore
          titleTextStyle: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.lightBlue, // Colore pulsante
            foregroundColor: Colors.white, // Colore testo pulsante
            textStyle: TextStyle(fontSize: 18),
          ),
        ),
      ),
      home: HomeScreen(),
    );
  }
}

// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home Screen'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {},
//           child: Text('Premi qui'),
//         ),
//       ),
//     );
//   }
//}
