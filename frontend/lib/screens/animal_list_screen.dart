import 'package:flutter/material.dart';

class AnimalListScreen extends StatelessWidget {
  final String category; // Categoria degli animali (es. "Cani")
  final List<Map<String, String?>> animals; // Lista degli animali

  AnimalListScreen({required this.category, required this.animals});

  @override
  Widget build(BuildContext context) {
    // Filtra gli animali in base alla categoria o allo stato
    final filteredAnimals = animals.where((animal) {
      return animal['category'] == category || animal['status'] == category;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('$category'), // Mostra la categoria nel titolo
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Torna alla schermata precedente
          },
        ),
      ),
      body: filteredAnimals.isNotEmpty
          ? ListView.builder(
              itemCount: filteredAnimals.length, // Numero di animali filtrati
              itemBuilder: (context, index) {
                final animal = filteredAnimals[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    backgroundImage: animal['imageUrl'] != null
                        ? NetworkImage(animal['imageUrl']!)
                        : null,
                    child: animal['imageUrl'] == null
                        ? Icon(
                            Icons.pets,
                            color: Colors.grey[600],
                          )
                        : null,
                  ),
                  title: Text(animal['name'] ?? 'Senza nome'),
                  onTap: () {
                    // Azione quando clicchi su un animale (es. vai ai dettagli)
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AnimalDetailScreen(animal: animal),
                      ),
                    );
                  },
                );
              },
            )
          : Center(
              child: Text(
                'Nessun animale trovato in questa categoria.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
    );
  }
}

class AnimalDetailScreen extends StatelessWidget {
  final Map<String, String?> animal;

  AnimalDetailScreen({required this.animal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(animal['name'] ?? 'Dettaglio Animale'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Text('Dettagli di ${animal['name']}'),
      ),
    );
  }
}
