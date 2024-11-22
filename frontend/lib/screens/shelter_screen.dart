import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'animal_list_screen.dart';

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
                      'assets/images/zebbbbbre.jpeg'), // Immagine del rifugio
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

            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Bottone per i Cani
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                AnimalListPage(category: 'Cani'),
                          ),
                        );
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 5, 50, 86),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.dog, // Icona di un uccello
                              color: Colors.white,
                              size: 40,
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Cani",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Bottone per i Gatti
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                AnimalListPage(category: 'Gatti'),
                          ),
                        );
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 5, 50, 86),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.cat, // Icona di un uccello
                              color: Colors.white,
                              size: 40,
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Gatti",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Bottone per Altri Animali
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                AnimalListPage(category: 'Altri'),
                          ),
                        );
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 5, 50, 86),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.horse, // Icona di un uccello
                              color: Colors.white,
                              size: 40,
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Altri",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
