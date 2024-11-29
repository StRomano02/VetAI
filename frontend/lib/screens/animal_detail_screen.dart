import 'package:flutter/material.dart';
import '../models/animal.dart';
import 'edit_animal_screen.dart';

class AnimalDetailScreen extends StatelessWidget {
  static Animal getAnimalByName(String name) {
    return exampleAnimals.firstWhere(
      (animal) => animal.name == name,
      orElse: () => Animal(
        name: 'Sconosciuto',
        species: 'Specie sconosciuta',
        status: 'Status sconosciuto',
      ),
    );
  }

  final Animal animal; // Ricevi direttamente un oggetto Animal

  AnimalDetailScreen({required this.animal});

  AnimalDetailScreen.byName({required String name})
      : animal = getAnimalByName(name);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(animal.name),
        backgroundColor: const Color.fromARGB(255, 126, 138, 127),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // Naviga alla schermata di modifica
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditAnimalScreen(animal: animal),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (animal.photoUrl != null && animal.photoUrl!.isNotEmpty)
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.network(
                    animal.photoUrl!,
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.pets, size: 100, color: Colors.grey);
                    },
                  ),
                ),
              )
            else
              Center(
                child: Icon(
                  Icons.pets,
                  size: 100,
                  color: Colors.grey,
                ),
              ),
            const SizedBox(height: 16),
            _buildSectionTitle('Informazioni Generali'),
            _buildCard([
              _buildInfoRow('Specie', animal.species),
              _buildInfoRow('Razza', animal.breed),
              _buildInfoRow('Genere', animal.gender),
              _buildInfoRow('Età o Data di nascita', animal.birthDateOrAge),
              _buildInfoRow('Colore o Segni distintivi', animal.colorOrMarks),
              _buildInfoRow('Numero Microchip', animal.microchipNumber),
              _buildInfoRow('Peso Attuale', animal.currentWeight),
            ]),
            const SizedBox(height: 16),
            _buildSectionTitle('Informazioni sul Proprietario'),
            _buildCard([
              _buildInfoRow('Nome Proprietario', animal.ownerName),
              _buildInfoRow('Contatto Proprietario', animal.ownerContact),
              _buildInfoRow('Indirizzo Proprietario', animal.ownerAddress),
            ]),
            const SizedBox(height: 16),
            _buildSectionTitle('Storico degli Appuntamenti'),
            _buildCard([
              if (animal.ownerAppointments != null &&
                  animal.ownerAppointments!.isNotEmpty)
                ...animal.ownerAppointments!
                    .map((appointment) => _buildListItem(appointment))
              else
                _buildListItem('Nessun appuntamento registrato.'),
            ]),
            const SizedBox(height: 16),
            _buildSectionTitle('Cartella Clinica'),
            _buildCard([
              if (animal.medicalHistory != null &&
                  animal.medicalHistory!.isNotEmpty)
                ...animal.medicalHistory!.entries.map(
                    (entry) => _buildListItem('${entry.key}: ${entry.value}'))
              else
                _buildListItem('Nessuna cartella clinica disponibile.'),
            ]),
            const SizedBox(height: 16),
            _buildSectionTitle('Note sulla Dieta'),
            _buildCard([
              _buildListItem(animal.dietNotes ?? 'Nessuna nota.'),
            ]),
            const SizedBox(height: 16),
            _buildSectionTitle('Note sulla Riproduzione'),
            _buildCard([
              _buildListItem(animal.reproductionNotes ?? 'Nessuna nota.'),
            ]),
            const SizedBox(height: 16),
            _buildSectionTitle('Farmaci Prescritti'),
            _buildCard([
              if (animal.prescribedDrugs != null &&
                  animal.prescribedDrugs!.isNotEmpty)
                ...animal.prescribedDrugs!.map((drug) => _buildListItem(
                    '${drug['name']} (${drug['dose']} per ${drug['duration']})'))
              else
                _buildListItem('Nessun farmaco prescritto.'),
            ]),
            const SizedBox(height: 16),
            _buildSectionTitle('Test Diagnostici'),
            _buildCard([
              if (animal.diagnosticTests != null &&
                  animal.diagnosticTests!.isNotEmpty)
                ...animal.diagnosticTests!.map((test) => _buildListItem(
                    '${test['type']} (${test['date']}): ${test['result']}'))
              else
                _buildListItem('Nessun test diagnostico disponibile.'),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: const Color.fromARGB(255, 20, 39, 21),
        ),
      ),
    );
  }

  Widget _buildCard(List<Widget> children) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              value ?? 'Non disponibile',
              textAlign: TextAlign.end,
              style: TextStyle(color: Colors.grey[700]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        '- $text',
        style: TextStyle(color: Colors.grey[700]),
      ),
    );
  }
}
