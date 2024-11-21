import 'package:flutter/material.dart';
import 'shelter_screen.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';
import '../widgets/gradient_background.dart';
import '../providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'animal_list_screen.dart';

class ClientHomeScreen extends StatefulWidget {
  @override
  _ClientHomeScreenState createState() => _ClientHomeScreenState();
}

class _ClientHomeScreenState extends State<ClientHomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2), // Durata dell'animazione
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _controller.forward(); // Avvia l'animazione
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'VetAI',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
              backgroundColor: Colors.transparent, // Per app bar trasparente
            ),
          ),
          centerTitle: true,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              // Header del menu
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          AssetImage('assets/images/profile_placeholder.png'),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Nome Utente',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'email@example.com',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              // Voce per il profilo
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Profilo'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                },
              ),

              // Voce per le impostazioni
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Impostazioni'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsPage()),
                  );
                },
              ),

              // Logout
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
                onTap: () {
                  Provider.of<AuthProvider>(context, listen: false).logout();
                },
              ),
            ],
          ),
        ),
        body: GradientBackground(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Logo del progetto
                SizedBox(
                  height: 200, // Altezza del logo
                  child: Image.asset(
                    'assets/images/logo.png', // Logo nella cartella assets
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 20),

                // Dashboard con barra di ricerca e bottone
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Barra di ricerca
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Inserisci il nome del rifugio',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.search),
                        ),
                        onSubmitted: (value) {
                          if (value.isNotEmpty) {
                            // Azione: Naviga alla pagina del rifugio cercato
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ShelterPage(shelterName: value),
                              ),
                            );
                          }
                        },
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AnimalListPage(category: 'Cose')),
                          );
                        },
                        child: Text('I miei animali'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
