import 'package:flutter/material.dart';
import 'animal_detail_screen.dart';
import 'add_animal_screen.dart'; // Aggiungi la schermata per aggiungere animali

class AnimalListPage extends StatelessWidget {
  final String category;

  AnimalListPage({required this.category});

  @override
  Widget build(BuildContext context) {
    // Simulazione di dati diversi per ogni categoria
    final Map<String, List<Map<String, String>>> animalData = {
      'Cani': [
        {'name': 'Rex', 'image': 'assets/images/dog1.png'},
        {'name': 'Fido', 'image': 'assets/images/dog2.png'},
      ],
      'Gatti': [
        {'name': 'Micio', 'image': 'assets/images/cat1.png'},
        {'name': 'Pallino', 'image': 'assets/images/cat2.png'},
      ],
      'Altri': [
        {'name': 'Tartaruga', 'image': 'assets/images/turtle.png'},
        {'name': 'Coniglio', 'image': 'assets/images/rabbit.png'},
      ],
      'Cose': [
        {'name': 'shakina', 'image': 'assets/images/shakina.jpeg'},
        {'name': 'nonsichiama', 'image': 'assets/images/gattina.jpeg'},
      ]
    };

    final animals = animalData[category] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text('Animali della categoria "$category"'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: animals.length,
          itemBuilder: (context, index) {
            final animal = animals[index];
            return AnimalCard(
              name: animal['name']!,
              imagePath: animal['image']!,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AnimalDetailPage(
                      name: animal['name']!,
                      imagePath: animal['image']!,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddAnimalScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class AnimalCard extends StatelessWidget {
  final String name;
  final String imagePath;
  final VoidCallback onTap;

  const AnimalCard({
    required this.name,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imagePath,
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            Text(
              name,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
