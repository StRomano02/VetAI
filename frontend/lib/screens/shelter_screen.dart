import 'package:flutter/material.dart';
import 'animal_screen.dart';

class ShelterPage extends StatefulWidget {
  final String shelterName;

  const ShelterPage({required this.shelterName});

  @override
  _ShelterPageState createState() => _ShelterPageState();
}

class _ShelterPageState extends State<ShelterPage> {
  // Esempio di informazioni dello shelter
  String description = "Un rifugio accogliente per animali.";
  String address = "Via degli Animali, 123, Roma";
  String contactInfo = "Telefono: +39 0123 456 789";

  bool isEditing = false; // Stato per modificare le informazioni

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.shelterName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Foto dello shelter
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage(
                      'assets/images/shelter_image.jpg'), // Immagine del rifugio
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),

            // Informazioni dello shelter
            Text(
              'Informazioni sul Rifugio',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // Modifica descrizione
            isEditing
                ? TextField(
                    decoration: InputDecoration(
                      labelText: 'Descrizione',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 2,
                    onChanged: (value) {
                      description = value;
                    },
                  )
                : Text(description, style: TextStyle(fontSize: 16)),

            SizedBox(height: 10),

            // Modifica indirizzo
            isEditing
                ? TextField(
                    decoration: InputDecoration(
                      labelText: 'Indirizzo',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      address = value;
                    },
                  )
                : Text('Indirizzo: $address', style: TextStyle(fontSize: 16)),

            SizedBox(height: 10),

            // Modifica contatti
            isEditing
                ? TextField(
                    decoration: InputDecoration(
                      labelText: 'Contatti',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      contactInfo = value;
                    },
                  )
                : Text('Contatti: $contactInfo',
                    style: TextStyle(fontSize: 16)),

            SizedBox(height: 20),

            // Pulsante per salvare o modificare informazioni
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isEditing =
                      !isEditing; // Alterna tra modifica e visualizzazione
                });
              },
              child:
                  Text(isEditing ? 'Salva Modifiche' : 'Modifica Informazioni'),
            ),

            SizedBox(height: 20),

            // Bottone per andare alla lista degli animali
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AnimalsPage(), // Naviga alla pagina degli animali
                  ),
                );
              },
              child: Text('Vai alla lista degli animali'),
            ),
          ],
        ),
      ),
    );
  }
}
