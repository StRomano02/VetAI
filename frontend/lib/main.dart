import 'package:flutter/material.dart';
import 'providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'screens/welcome_screen.dart';
import 'screens/client_home_screen.dart';
import 'screens/vet_home_screen.dart';

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
          primarySwatch: Colors.grey,
        ).copyWith(
          primary: Color(0xFFBDBDBD), // Grigio chiaro elegante
          secondary:
              Color(0xFF757575), // Grigio intermedio per pulsanti o dettagli
        ),
        scaffoldBackgroundColor: Colors.white, // Sfondo bianco
        cardColor: Colors.white, // Colore per le card o i contenitori
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white, // Sfondo bianco per l'AppBar
          titleTextStyle: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF424242), // Grigio scuro per il testo dell'AppBar
          ),
          iconTheme: IconThemeData(
            color: Color(0xFF424242), // Colore delle icone dell'AppBar
          ),
          elevation: 0, // Rimuove l'ombra per un look piatto
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor:
                Color(0xFF757575), // Grigio intermedio per pulsanti
            foregroundColor: Colors.white,
            textStyle: TextStyle(fontSize: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // Angoli arrotondati
            ),
          ),
        ),
        textTheme: TextTheme(
          headlineMedium: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF424242), // Grigio scuro per titoli
          ),
          bodyMedium: TextStyle(
            fontSize: 16,
            color: Colors.black87, // Colore standard per il testo
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor:
              Color(0xFFF5F5F5), // Grigio molto chiaro per i campi di input
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Color(0xFFBDBDBD)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF757575)),
          ),
          hintStyle: TextStyle(color: Colors.grey),
        ),
      ),
      home: Consumer<AuthProvider>(
        builder: (context, auth, child) {
          if (auth.isAuthenticated) {
            // Controlla il ruolo salvato
            final role = auth.userData?['role'];
            if (role == 'vet') {
              return VetHomeScreen(); // Home per il veterinario
            } else if (role == 'client') {
              return ClientHomeScreen(); // Home per il cliente
            }
          }
          return WelcomeScreen(); // Utente non loggato
        },
      ),
    );
  }
}
