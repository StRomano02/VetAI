import 'package:flutter/material.dart';
import 'animal_detail_screen.dart';
import '../models/animal.dart';
import '../models/animal_data.dart';

class AnimalListScreen extends StatelessWidget {
  final String category;

  AnimalListScreen({required this.category});

  @override
  Widget build(BuildContext context) {
    final filteredAnimals = exampleAnimals.where((animal) {
      // Un animale appartiene alla categoria se lo `status` corrisponde
      // oppure se la specie corrisponde (mappata alla categoria)
      String mapSpeciesToCategory(String species) {
        if (['Cane', 'Cagna'].contains(species)) return 'Cani';
        if (['Gatto', 'Gattina'].contains(species)) return 'Gatti';
        return 'Altri';
      }

      final bool isInStatusCategory = animal.status == category;
      final bool isInSpeciesCategory =
          mapSpeciesToCategory(animal.species) == category;

      return isInStatusCategory || isInSpeciesCategory;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('$category'),
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
            Navigator.pop(context);
          },
        ),
      ),
      body: filteredAnimals.isNotEmpty
          ? ListView.builder(
              itemCount: filteredAnimals.length,
              itemBuilder: (context, index) {
                final animal = filteredAnimals[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    backgroundImage: animal.photoUrl != null
                        ? NetworkImage(animal.photoUrl!)
                        : null,
                    child: animal.photoUrl == null
                        ? Icon(Icons.pets, color: Colors.grey[600])
                        : null,
                  ),
                  title: Text(animal.name),
                  onTap: () {
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Nessun animale trovato in questa categoria.',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Logica per aggiungere un nuovo animale
                    },
                    icon: Icon(Icons.add),
                    label: Text('Aggiungi Animale'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
