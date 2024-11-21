import 'package:flutter/material.dart';
import 'shelter_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
                      builder: (context) => ShelterPage(shelterName: value),
                    ),
                  );
                }
              },
            ),
            SizedBox(height: 20),

            // Bottone per "Accedi al tuo rifugio"
            ElevatedButton(
              onPressed: () {
                // Azione: Naviga alla pagina del rifugio dell'utente
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ShelterPage(shelterName: 'Il tuo rifugio'),
                  ),
                );
              },
              child: Text('Accedi al tuo rifugio'),
            ),
          ],
        ),
      ),
    );
  }
}
