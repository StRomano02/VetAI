import 'package:flutter/material.dart';
import 'animal_list_screen.dart';
import 'add_animal_screen.dart';
import 'vet_profile_screen.dart';

final List<Map<String, String?>> animals = [
  {'name': 'Shaky', 'status': 'In cerca di casa', 'category': 'Cani'},
  {'name': 'Sophie', 'status': 'In cura', 'category': 'Gatti'},
  {'name': 'Squalo', 'status': 'In cerca di casa', 'category': 'Altri'},
  {'name': 'Tosca', 'status': 'In cura', 'category': 'Cani'},
  {'name': 'Domi', 'status': 'In cerca di casa', 'category': 'Gatti'},
];

class VetHomeScreen extends StatefulWidget {
  @override
  _VetHomeScreenState createState() => _VetHomeScreenState();
}

class _VetHomeScreenState extends State<VetHomeScreen> {
  int _selectedIndex = 0; // Indice iniziale

  // Lista delle schermate
  final List<Widget> _pages = [
    VetHomeScreenContent(), // Schermata principale
    ClinicPage(), // Placeholder per Clinica
    MessagesPage(), // Placeholder per Messaggi
    StorePage(), // Placeholder per Magazzino
    ProfileScreen(), // Schermata Profilo
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Cambia schermata
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Mostra la schermata selezionata
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped, // Cambia schermata al tocco
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.pets),
            label: 'Animali',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital),
            label: 'Clinica',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messaggi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Magazzino',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profilo',
          ),
        ],
      ),
    );
  }
}

class VetHomeScreenContent extends StatelessWidget {
  final List<String> _categories = [
    'In cerca di casa',
    'In cura',
    'Cani',
    'Gatti',
    'Altri'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          'VetAI',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.black),
            onPressed: () {
              // Azione per notifiche
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Barra di ricerca
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) {
                // Logica per aggiornare la ricerca
              },
              decoration: InputDecoration(
                hintText: 'Cerca un animale',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          // Lista delle categorie
          Expanded(
            child: ListView(
              children: _categories.map((category) {
                return CategorySection(
                  title: category,
                  animals: animals.where((animal) {
                    if (category == 'In cerca di casa' ||
                        category == 'In cura') {
                      return animal['status'] == category;
                    } else {
                      return animal['category'] == category;
                    }
                  }).toList(),
                );
              }).toList(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddAnimalScreen()),
          );
        },
        backgroundColor: Colors.green,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

// Schermate placeholder per altre sezioni
class ClinicPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Clinica')),
    );
  }
}

class MessagesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Messaggi')),
    );
  }
}

class StorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Magazzino')),
    );
  }
}

// Widget delle categorie
class CategorySection extends StatelessWidget {
  final String title;
  final List<Map<String, String?>> animals;

  CategorySection({required this.title, required this.animals});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AnimalListScreen(
                        category: title,
                        animals: animals,
                      ),
                    ),
                  );
                },
                child: Text('Vedi tutto >'),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SizedBox(
            height: 150,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: animals.map((animal) {
                return AnimalCard(
                  name: animal['name']!,
                  status: animal['status'],
                );
              }).toList(),
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}

// Widget per le card degli animali
class AnimalCard extends StatelessWidget {
  final String name;
  final String? status;

  AnimalCard({required this.name, this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                height: 110,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                ),
                child: Center(
                  child: Icon(
                    Icons.pets,
                    size: 50,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              if (status != null)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: status == "In cerca di casa"
                          ? Colors.green
                          : Colors.orange,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      status!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              name,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
