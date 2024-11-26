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
  String? _selectedCategory;
  String? _selectedStatus;

  // Opzioni per categoria e stato
  final List<String> categories = ['Cane', 'Gatto', 'Altro'];
  final List<String> statuses = ['In Cerca di Casa', 'In Cura'];

  void _pickImage() async {
    // Logica per selezionare un'immagine
    setState(() {
      _imagePath =
          "path/to/selected/image.png"; // Sostituisci con il path reale
    });
  }

  void _saveAnimal() {
    if (_formKey.currentState!.validate() &&
        _selectedCategory != null &&
        _selectedStatus != null) {
      // Logica per salvare i dati nel backend o aggiorna la lista di animali
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Animale aggiunto con successo!')),
      );
      Navigator.pop(context); // Torna alla schermata precedente
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Per favore, completa tutti i campi')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Aggiungi un nuovo animale',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Campo per il nome
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Inserisci il nome';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Campo per l'età
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(
                  labelText: 'Età',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Inserisci l\'età';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Inserisci un numero valido';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Campo per la descrizione
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Descrizione',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Inserisci una descrizione';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Dropdown per la categoria
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: InputDecoration(
                  labelText: 'Categoria',
                  border: OutlineInputBorder(),
                ),
                items: categories
                    .map((category) => DropdownMenuItem<String>(
                          value: category,
                          child: Text(category),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Seleziona una categoria';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Dropdown per lo stato
              DropdownButtonFormField<String>(
                value: _selectedStatus,
                decoration: InputDecoration(
                  labelText: 'Stato',
                  border: OutlineInputBorder(),
                ),
                items: statuses
                    .map((status) => DropdownMenuItem<String>(
                          value: status,
                          child: Text(status),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedStatus = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Seleziona uno stato';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Bottone per selezionare un'immagine
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: _pickImage,
                    icon: Icon(Icons.photo),
                    label: Text('Carica foto'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 140, 150, 141),
                    ),
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
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    backgroundColor: const Color.fromARGB(255, 21, 56, 23),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Salva',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
