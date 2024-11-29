import 'package:flutter/material.dart';
import 'animal_detail_screen.dart';
import 'chat_detail_screen.dart';
import '../models/animal.dart';
import '../models/chat.dart';
import 'vet_profile_screen.dart';
import 'add_animal_screen.dart';

class ClientHomeScreen extends StatefulWidget {
  @override
  _ClientHomeScreenState createState() => _ClientHomeScreenState();
}

class _ClientHomeScreenState extends State<ClientHomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    ClientHomePageContent(),
    SearchPage(),
    SavedAnimalsPage(),
    MessagesPage(),
    VetProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Cerca',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Salvati',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messaggi',
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

class ClientHomePageContent extends StatefulWidget {
  @override
  _ClientHomePageContentState createState() => _ClientHomePageContentState();
}

class _ClientHomePageContentState extends State<ClientHomePageContent>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Numero di tab
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          title: Text(
            'VetAI',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(40), // Altezza personalizzata
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200], // Sfondo grigio chiaro della barra
                  borderRadius: BorderRadius.circular(25), // Bordo arrotondato
                ),
                child: TabBar(
                  indicator: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(25), // Indicatore arrotondato
                    color: Colors.transparent, // Nessun colore per l'indicatore
                  ),
                  labelColor: Colors.green, // Colore del testo selezionato
                  unselectedLabelColor:
                      Colors.black, // Colore del testo non selezionato
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold, // Testo in grassetto
                  ),
                  tabs: [
                    Tab(
                      text: 'I miei animali',
                    ),
                    Tab(
                      text: 'Trova un animale',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(
              top: 10.0), // Aggiungi margine sopra il contenuto
          child: TabBarView(
            children: [
              MyAnimalsSection(), // Contenuto per "I miei animali"
              FindNewAnimalSection(), // Contenuto per "Trova un nuovo animale"
            ],
          ),
        ),
      ),
    );
  }
}

class MyAnimalsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final myAnimals = exampleAnimals
        .where((animal) => animal.status == "In cura") // Animali personali
        .toList();

    final upcomingVisits = [
      {'name': 'Domi', 'date': '2024-12-01', 'vet': 'Dr. Rossi'},
      {'name': 'Squalo', 'date': '2024-12-05', 'vet': 'Dr. Verdi'},
    ];

    return Column(
      children: [
        // Sezione animali
        CategorySection(
          title: 'I miei animali',
          animals: myAnimals,
          onAddAnimal: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddAnimalScreen(),
              ),
            );
          },
          onViewAll: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AnimalListPage(category: 'In cura'),
              ),
            );
          },
        ),
        SizedBox(height: 20),
        // Sezione visite
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Visite in programma',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            itemCount: upcomingVisits.length,
            itemBuilder: (context, index) {
              final visit = upcomingVisits[index];
              return ListTile(
                leading: Icon(Icons.calendar_today, color: Colors.green),
                title: Text('Animale: ${visit['name']}'),
                subtitle: Text('Data: ${visit['date']} - Vet: ${visit['vet']}'),
                trailing: Icon(Icons.arrow_forward, color: Colors.grey),
                onTap: () {
                  // Logica per aprire i dettagli della visita
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class FindNewAnimalSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sections = [
      'In cerca di casa',
      'Cani',
      'Gatti',
      'Altri',
    ];

    return ListView(
      children: sections.map((section) {
        final filteredAnimals = exampleAnimals.where((animal) {
          // Logica per filtrare animali in base alla categoria
          String mapSpeciesToCategory(String species) {
            if (['Cane', 'Cagna'].contains(species)) return 'Cani';
            if (['Gatto', 'Gattina'].contains(species)) return 'Gatti';
            return 'Altri';
          }

          final bool isInStatusCategory = animal.status == section;
          final bool isInSpeciesCategory =
              mapSpeciesToCategory(animal.species) == section;

          return isInStatusCategory || isInSpeciesCategory;
        }).toList();

        return CategorySection(
          title: section,
          animals: filteredAnimals,
          onAddAnimal: () {
            // Logica per aggiungere un animale
          },
          onViewAll: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AnimalListPage(category: section),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cerca Strutture'),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Text(
          'Mappa e ricerca strutture',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ),
    );
  }
}

class SavedAnimalsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Filtra gli animali con lo status "In cura"
    final animalsInCare = exampleAnimals.where((animal) {
      return animal.status == 'In cerca di casa';
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Animali salvati'),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: animalsInCare.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // Calcola il numero di colonne in base alla larghezza disponibile
                  final crossAxisCount = (constraints.maxWidth / 150).floor();

                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          crossAxisCount, // Numero di colonne dinamico
                      crossAxisSpacing: 12.0, // Spazi tra le colonne
                      mainAxisSpacing: 12.0, // Spazi tra le righe
                      childAspectRatio: 1, // Rapporto larghezza/altezza
                    ),
                    itemCount: animalsInCare.length,
                    itemBuilder: (context, index) {
                      final animal = animalsInCare[index];
                      return AnimalCard(
                          animal: animal); // Usa il widget AnimalCard
                    },
                  );
                },
              ),
            )
          : Center(
              child: Text(
                'Nessun animale salvato al momento.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profilo'),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey[200],
              child: Icon(Icons.person, size: 50, color: Colors.grey[600]),
            ),
            SizedBox(height: 10),
            Text('Nome Utente', style: TextStyle(fontSize: 18)),
            Text('email@dominio.com', style: TextStyle(color: Colors.grey)),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Impostazioni'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text('Guida'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Esci'),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class MessagesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Messaggi"),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: exampleChats.length,
        itemBuilder: (context, index) {
          final chat = exampleChats[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(chat.imageUrl),
            ),
            title: Text(
              chat.name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(chat.lastMessage),
            trailing: Text(
              "${chat.lastMessageTime.hour}:${chat.lastMessageTime.minute.toString().padLeft(2, '0')}",
              style: TextStyle(color: Colors.grey),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatDetailScreen(chat: chat),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class AnimalListPage extends StatelessWidget {
  final String category;

  AnimalListPage({required this.category});

  @override
  Widget build(BuildContext context) {
    final filteredAnimals = exampleAnimals.where((animal) {
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
      ),
      body: filteredAnimals.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Due colonne
                  crossAxisSpacing: 16.0, // Spazi tra le colonne
                  mainAxisSpacing: 16.0, // Spazi tra le righe
                  childAspectRatio: 1.2, // Rapporto larghezza/altezza
                ),
                itemCount: filteredAnimals.length,
                itemBuilder: (context, index) {
                  final animal = filteredAnimals[index];
                  return AnimalCard(animal: animal); // Usa il widget AnimalCard
                },
              ),
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

class AnimalCard extends StatelessWidget {
  final Animal animal;

  AnimalCard({required this.animal});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AnimalDetailScreen(animal: animal),
          ),
        );
      },
      child: Container(
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
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(12)),
                  ),
                  child: animal.photoUrl != null && animal.photoUrl!.isNotEmpty
                      ? Image.network(
                          animal.photoUrl!,
                          fit: BoxFit.cover,
                          height: 110,
                          width: double.infinity,
                          errorBuilder: (context, error, stackTrace) {
                            // Mostra l'icona di fallback se il caricamento fallisce
                            return Center(
                              child: Icon(
                                Icons.pets,
                                size: 50,
                                color: Colors.black,
                              ),
                            );
                          },
                        )
                      : Center(
                          child: Icon(
                            Icons.pets,
                            size: 50,
                            color: Colors.black,
                          ),
                        ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: animal.status == "In cerca di casa"
                          ? Colors.green
                          : Colors.orange,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      animal.status,
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
                animal.name,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategorySection extends StatelessWidget {
  final String title;
  final List<Animal> animals;
  final VoidCallback onAddAnimal;
  final VoidCallback onViewAll;

  CategorySection({
    required this.title,
    required this.animals,
    required this.onAddAnimal,
    required this.onViewAll,
  });

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
                onPressed: onViewAll,
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
              children: [
                ...animals.map((animal) {
                  return AnimalCard(animal: animal);
                }).toList(),
                GestureDetector(
                  onTap: onAddAnimal,
                  child: Container(
                    width: 160,
                    margin: EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: const Color.fromARGB(255, 133, 121, 121),
                          width: 2),
                    ),
                    child: Center(
                      child: Icon(Icons.add,
                          size: 40,
                          color: const Color.fromARGB(255, 133, 121, 121)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
