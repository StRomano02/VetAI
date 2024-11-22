import 'package:flutter/material.dart';

class AddAnimalScreen extends StatefulWidget {
  @override
  _AddAnimalScreenState createState() => _AddAnimalScreenState();
}

class _AddAnimalScreenState extends State<AddAnimalScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? _imagePath;

  void _pickImage() async {
    // Logica per selezionare un'immagine (usa librerie come image_picker)
    // Per esempio: final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _imagePath =
          "path/to/selected/image.png"; // Sostituisci con il path reale
    });
  }

  void _saveAnimal() {
    if (_formKey.currentState!.validate()) {
      // Salva i dati nel backend
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Animale aggiunto con successo!')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aggiungi un nuovo animale'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Campo per il nome
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Inserisci il nome';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),

              // Campo per l'età
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(labelText: 'Età'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Inserisci l\'età';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),

              // Campo per la descrizione
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Descrizione'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Inserisci una descrizione';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Bottone per selezionare un'immagine
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: _pickImage,
                    icon: Icon(Icons.photo),
                    label: Text('Carica foto'),
                  ),
                  SizedBox(width: 10),
                  if (_imagePath != null)
                    Text(
                      'Immagine selezionata',
                      style: TextStyle(color: Colors.green),
                    ),
                ],
              ),
              SizedBox(height: 20),

              // Bottone per salvare
              Center(
                child: ElevatedButton(
                  onPressed: _saveAnimal,
                  child: Text('Salva'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
