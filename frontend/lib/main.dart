import 'package:flutter/material.dart';
import 'providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'screens/welcome_screen.dart';
import 'screens/client_home_screen.dart';
import 'screens/vet_home_screen.dart';

// flutter run --dart-define=initialScreen=client
// flutter run --dart-define=initialScreen=vet

void main(List<String> args) {
  const String initialScreen = String.fromEnvironment('initialScreen',
      defaultValue: 'auth'); // Legge la variabile da --dart-define

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) =>
                AuthProvider()..checkLoginStatus()), // Mantieni AuthProvider
      ],
      child: MyApp(initialScreen: initialScreen), // Passa l'argomento
    ),
  );
}

class MyApp extends StatelessWidget {
  final String initialScreen;

  MyApp({required this.initialScreen}); // Costruttore

  @override
  Widget build(BuildContext context) {
    Widget homeWidget;

    print('Initial Screen Argument: $initialScreen');

    // Imposta lo screen iniziale in base al parametro
    switch (initialScreen) {
      case 'client':
        homeWidget = ClientHomeScreen();
        break;
      case 'vet':
        homeWidget = VetHomeScreen();
        break;
      default:
        homeWidget = AuthenticationWrapper();
    }

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
        scaffoldBackgroundColor: Colors.white,
        cardColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF424242),
          ),
          iconTheme: IconThemeData(
            color: Color(0xFF424242),
          ),
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF757575),
            foregroundColor: Colors.white,
            textStyle: TextStyle(fontSize: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        textTheme: TextTheme(
          headlineMedium: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF424242),
          ),
          bodyMedium: TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Color(0xFFF5F5F5),
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
      home: homeWidget, // Usa un widget dedicato per la logica di routing
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

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
  }
}
