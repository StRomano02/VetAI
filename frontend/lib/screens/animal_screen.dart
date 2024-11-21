import 'package:flutter/material.dart';
import 'animal_list_screen.dart';

class AnimalsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seleziona una categoria'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2, // Due widget per riga
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            CategoryWidget(
              title: 'Cani',
              imagePath: 'assets/images/dog.png',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AnimalListPage(category: 'Cani'),
                  ),
                );
              },
            ),
            CategoryWidget(
              title: 'Gatti',
              imagePath: 'assets/images/cat.png',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AnimalListPage(category: 'Gatti'),
                  ),
                );
              },
            ),
            CategoryWidget(
              title: 'Altri',
              imagePath: 'assets/images/other_animals.png',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AnimalListPage(category: 'Altri'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryWidget extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback onTap;

  const CategoryWidget({
    required this.title,
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
            Image.asset(
              imagePath,
              height: 80,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
