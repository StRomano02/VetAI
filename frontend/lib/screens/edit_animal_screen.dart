import 'package:flutter/material.dart';
import '../models/animal.dart';
import '../services/animal_service.dart';

class EditAnimalScreen extends StatefulWidget {
  final Animal animal;

  EditAnimalScreen({required this.animal});

  @override
  _EditAnimalScreenState createState() => _EditAnimalScreenState();
}

class _EditAnimalScreenState extends State<EditAnimalScreen> {
  final _formKey = GlobalKey<FormState>();
  late Animal _editedAnimal;

  @override
  void initState() {
    super.initState();
    _editedAnimal = widget.animal; // Inizializza con i dati esistenti
  }

  Future<void> _saveChanges() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        // Crea una mappa con i dati aggiornati
        Map<String, dynamic> updatedData = {
          'name': _editedAnimal.name,
          'species': _editedAnimal.species,
          'status': _editedAnimal.status,
          if (_editedAnimal.breed != null) 'breed': _editedAnimal.breed,
          if (_editedAnimal.gender != null) 'gender': _editedAnimal.gender,
          if (_editedAnimal.birthDateOrAge != null)
            'birth_date_or_age': _editedAnimal.birthDateOrAge,
          if (_editedAnimal.colorOrMarks != null)
            'color_or_marks': _editedAnimal.colorOrMarks,
          if (_editedAnimal.microchipNumber != null)
            'microchip_number': _editedAnimal.microchipNumber,
          if (_editedAnimal.currentWeight != null)
            'current_weight': _editedAnimal.currentWeight,
          if (_editedAnimal.ownerName != null)
            'owner_name': _editedAnimal.ownerName,
          if (_editedAnimal.ownerContact != null)
            'owner_contact': _editedAnimal.ownerContact,
          if (_editedAnimal.ownerAddress != null)
            'owner_address': _editedAnimal.ownerAddress,
          if (_editedAnimal.ownerAppointments != null)
            'owner_appointments': _editedAnimal.ownerAppointments,
          if (_editedAnimal.medicalHistory != null)
            'medical_history': _editedAnimal.medicalHistory,
          if (_editedAnimal.dietNotes != null)
            'diet_notes': _editedAnimal.dietNotes,
          if (_editedAnimal.reproductionNotes != null)
            'reproduction_notes': _editedAnimal.reproductionNotes,
          if (_editedAnimal.prescribedDrugs != null)
            'prescribed_drugs': _editedAnimal.prescribedDrugs,
          if (_editedAnimal.diagnosticTests != null)
            'diagnostic_tests': _editedAnimal.diagnosticTests,
          if (_editedAnimal.photoUrl != null)
            'photo_url': _editedAnimal.photoUrl,
        };

        // Chiamata al servizio
        await AnimalService().updateAnimal(_editedAnimal.id!, updatedData);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Dati aggiornati con successo')),
        );
        Navigator.pop(context); // Torna indietro
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Errore durante l\'aggiornamento: $error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifica ${_editedAnimal.name}'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveChanges,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(height: 16),
              _buildTextField('Nome', _editedAnimal.name, (value) {
                _editedAnimal.name = value;
              }, required: true),
              SizedBox(height: 16),
              _buildTextField('Specie', _editedAnimal.species, (value) {
                _editedAnimal.species = value;
              }, required: true),
              SizedBox(height: 16),
              _buildTextField('Stato', _editedAnimal.status, (value) {
                _editedAnimal.status = value;
              }, required: true),
              SizedBox(height: 16),
              _buildTextField('Razza', _editedAnimal.breed, (value) {
                _editedAnimal.breed = value;
              }),
              SizedBox(height: 16),
              _buildTextField('Genere', _editedAnimal.gender, (value) {
                _editedAnimal.gender = value;
              }),
              SizedBox(height: 16),
              _buildTextField(
                  'Età o Data di Nascita', _editedAnimal.birthDateOrAge,
                  (value) {
                _editedAnimal.birthDateOrAge = value;
              }),
              SizedBox(height: 16),
              _buildTextField(
                  'Colore o Segni distintivi', _editedAnimal.colorOrMarks,
                  (value) {
                _editedAnimal.colorOrMarks = value;
              }),
              SizedBox(height: 16),
              _buildTextField('Numero Microchip', _editedAnimal.microchipNumber,
                  (value) {
                _editedAnimal.microchipNumber = value;
              }),
              SizedBox(height: 16),
              _buildTextField('Peso Attuale', _editedAnimal.currentWeight,
                  (value) {
                _editedAnimal.currentWeight = value;
              }),
              SizedBox(height: 16),
              _buildTextField('Nome Proprietario', _editedAnimal.ownerName,
                  (value) {
                _editedAnimal.ownerName = value;
              }),
              SizedBox(height: 16),
              _buildTextField(
                  'Contatto Proprietario', _editedAnimal.ownerContact, (value) {
                _editedAnimal.ownerContact = value;
              }),
              SizedBox(height: 16),
              _buildTextField(
                  'Indirizzo Proprietario', _editedAnimal.ownerAddress,
                  (value) {
                _editedAnimal.ownerAddress = value;
              }),
              SizedBox(height: 16),
              _buildTextField('Note sulla Dieta', _editedAnimal.dietNotes,
                  (value) {
                _editedAnimal.dietNotes = value;
              }),
              SizedBox(height: 16),
              _buildTextField(
                  'Note sulla Riproduzione', _editedAnimal.reproductionNotes,
                  (value) {
                _editedAnimal.reproductionNotes = value;
              }),
              SizedBox(height: 16),

              // Campi complessi: Appuntamenti
              _buildListField(
                'Appuntamenti Proprietario',
                _editedAnimal.ownerAppointments ?? [],
                (value) {
                  setState(() {
                    _editedAnimal.ownerAppointments = value;
                  });
                },
              ),
              SizedBox(height: 16),

              // Campi complessi: Prescrizioni mediche
              _buildListField(
                'Farmaci Prescritti',
                _editedAnimal.prescribedDrugs
                        ?.map((e) => e['name']!)
                        .toList() ??
                    [],
                (value) {
                  setState(() {
                    _editedAnimal.prescribedDrugs =
                        value.map((e) => {'name': e}).toList();
                  });
                },
              ),

              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveChanges,
                child: Text('Salva modifiche'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, String? initialValue, Function(String value) onChanged,
      {bool required = false}) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(labelText: label),
      onChanged: onChanged,
      validator: required
          ? (value) =>
              value == null || value.isEmpty ? '$label è obbligatorio' : null
          : null,
    );
  }

  Widget _buildListField(String label, List<String> items,
      Function(List<String> value) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        ...items.map((item) => ListTile(
              title: Text(item),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    items.remove(item);
                    onChanged(items);
                  });
                },
              ),
            )),
        TextButton(
          onPressed: () {
            setState(() {
              items.add('');
              onChanged(items);
            });
          },
          child: Text('Aggiungi nuovo $label'),
        )
      ],
    );
  }
}
