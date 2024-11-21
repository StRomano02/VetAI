import 'package:flutter/material.dart';
import 'providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'screens/welcome_screen.dart';
import 'screens/home_screen.dart';
//import 'screens/login_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) =>
                AuthProvider()..checkLoginStatus()), // Inizializza lo stato
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VetAI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.indigo, // Tavolozza indaco (più elegante)
        ).copyWith(
          primary: Color(0xFF3949AB), // Blu elegante, meno scuro
          secondary: Color(0xFF5C6BC0), // Colore secondario
        ),
        scaffoldBackgroundColor: Colors.white, // Sfondo bianco
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF3949AB),
          titleTextStyle: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF3949AB),
            foregroundColor: Colors.white,
            textStyle: TextStyle(fontSize: 18),
          ),
        ),
        textTheme: TextTheme(
          headlineMedium: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF3949AB),
          ),
          bodyMedium: TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
      ),
      home: Consumer<AuthProvider>(
        builder: (context, auth, child) {
          if (auth.isAuthenticated) {
            return HomeScreen(); // Utente già loggato
          } else {
            return WelcomeScreen(); // Utente non loggato
          }
        },
      ),
    );
  }
}
