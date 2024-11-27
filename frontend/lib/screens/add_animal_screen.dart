import 'package:flutter/material.dart';
import '../models/animal.dart';

class AddAnimalScreen extends StatefulWidget {
  @override
  _AddAnimalScreenState createState() => _AddAnimalScreenState();
}

class _AddAnimalScreenState extends State<AddAnimalScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controller per i campi del form
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _speciesController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  final TextEditingController _breedController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  final TextEditingController _microchipController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _ownerNameController = TextEditingController();
  final TextEditingController _ownerContactController = TextEditingController();
  final TextEditingController _ownerAddressController = TextEditingController();
  final TextEditingController _dietNotesController = TextEditingController();
  final TextEditingController _reproductionNotesController =
      TextEditingController();
  final TextEditingController _photoUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Aggiungi Animale',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.grey[200],
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 10),
              _buildTextField(_nameController, 'Nome', 'Inserisci un nome'),
              SizedBox(height: 16),
              _buildTextField(
                  _speciesController, 'Specie', 'Inserisci una specie'),
              SizedBox(height: 16),
              _buildTextField(
                  _statusController, 'Stato', 'Inserisci uno stato'),
              SizedBox(height: 16),
              _buildTextField(_breedController, 'Razza'),
              SizedBox(height: 16),
              _buildTextField(_genderController, 'Genere'),
              SizedBox(height: 16),
              _buildTextField(_birthDateController, 'Data di nascita o Età'),
              SizedBox(height: 16),
              _buildTextField(_colorController, 'Colore o Segni'),
              SizedBox(height: 16),
              _buildTextField(_microchipController, 'Numero Microchip'),
              SizedBox(height: 16),
              _buildTextField(_weightController, 'Peso Attuale'),
              SizedBox(height: 16),
              _buildTextField(_ownerNameController, 'Nome Proprietario'),
              SizedBox(height: 16),
              _buildTextField(_ownerContactController, 'Contatto Proprietario'),
              SizedBox(height: 16),
              _buildTextField(
                  _ownerAddressController, 'Indirizzo Proprietario'),
              SizedBox(height: 16),
              _buildTextField(_dietNotesController, 'Note Dietetiche'),
              SizedBox(height: 16),
              _buildTextField(
                  _reproductionNotesController, 'Note sulla Riproduzione'),
              SizedBox(height: 16),
              _buildTextField(_photoUrlController, 'URL della Foto'),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newAnimal = Animal(
                      name: _nameController.text,
                      species: _speciesController.text,
                      status: _statusController.text,
                      breed: _breedController.text,
                      gender: _genderController.text,
                      birthDateOrAge: _birthDateController.text,
                      colorOrMarks: _colorController.text,
                      microchipNumber: _microchipController.text,
                      currentWeight: _weightController.text,
                      ownerName: _ownerNameController.text,
                      ownerContact: _ownerContactController.text,
                      ownerAddress: _ownerAddressController.text,
                      dietNotes: _dietNotesController.text,
                      reproductionNotes: _reproductionNotesController.text,
                      photoUrl: _photoUrlController.text,
                    );

                    exampleAnimals.add(newAnimal);
                    Navigator.pop(context);
                  }
                },
                child: Text('Salva Animale'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[800],
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label, [
    String? validationMessage,
  ]) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.grey[100],
      ),
      validator: validationMessage != null
          ? (value) {
              if (value == null || value.isEmpty) {
                return validationMessage;
              }
              return null;
            }
          : null,
    );
  }
}
