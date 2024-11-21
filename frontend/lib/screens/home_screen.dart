// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'vet_home_screen.dart';
// import 'client_home_screen.dart';

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   String? userRole;

//   @override
//   void initState() {
//     super.initState();
//     _loadUserRole();
//   }

//   void _loadUserRole() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       userRole = prefs.getString('userRole'); // Ottieni il ruolo salvato
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (userRole == null) {
//       // Mostra uno schermo di caricamento mentre si carica il ruolo
//       return Scaffold(
//         body: Center(child: CircularProgressIndicator()),
//       );
//     }

//     // Mostra la schermata diversa in base al ruolo
//     return userRole == 'vet' ? VetHomeScreen() : ClientHomeScreen();
//   }
// }
