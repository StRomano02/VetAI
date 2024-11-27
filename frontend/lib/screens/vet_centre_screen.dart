import 'package:flutter/material.dart';
import '../models/centre.dart';

class CenterPage extends StatelessWidget {
  final Centre centre;

  CenterPage({required this.centre});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Struttura"),
        centerTitle: true,
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Immagine con gestione errori
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                centre.imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.grey[300],
                  child: Icon(
                    Icons.local_hospital,
                    size: 80,
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Card per i dettagli
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      centre.name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Indirizzo: ${centre.address}",
                      style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Telefono: ${centre.phoneNumber}",
                      style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            // Pulsante per modificare i dettagli
            OutlinedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditStructureDetailsPage(
                            centre: centre,
                          )),
                );
              },
              icon: Icon(Icons.edit, color: Colors.blue),
              label: Text(
                "Modifica Dettagli",
                style: TextStyle(color: Colors.blue),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.blue),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              ),
            ),
            SizedBox(height: 16),
            // Pulsante per accedere al magazzino intelligente
            OutlinedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SmartWarehousePage()),
                );
              },
              icon: Icon(Icons.warehouse, color: Colors.green),
              label: Text(
                "Magazzino Intelligente",
                style: TextStyle(color: Colors.green),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.green),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EditStructureDetailsPage extends StatelessWidget {
  final Centre centre;

  EditStructureDetailsPage({required this.centre});

  @override
  Widget build(BuildContext context) {
    // Controller per i campi di input
    final nameController = TextEditingController(text: centre.name);
    final addressController = TextEditingController(text: centre.address);
    final phoneController = TextEditingController(text: centre.phoneNumber);

    return Scaffold(
      appBar: AppBar(
        title: Text("Modifica Dettagli"),
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Nome della struttura",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: addressController,
              decoration: InputDecoration(
                labelText: "Indirizzo",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                labelText: "Telefono",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Salvare i dettagli aggiornati
                final updatedCentre = Centre(
                  name: nameController.text,
                  address: addressController.text,
                  phoneNumber: phoneController.text,
                  imageUrl: centre.imageUrl, // Manteniamo l'immagine invariata
                );

                // Passare i dati aggiornati indietro o salvare in un database
                Navigator.pop(context, updatedCentre);
              },
              child: Text("Salva"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SmartWarehousePage extends StatelessWidget {
  final List<Resource> resources = [
    Resource(name: "Cibo per cani", quantity: 50, threshold: 10),
    Resource(name: "Cibo per gatti", quantity: 30, threshold: 5),
    Resource(name: "Siringhe", quantity: 20, threshold: 5),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Magazzino Intelligente"),
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(
            fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Risorse disponibili:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: resources.length,
                itemBuilder: (context, index) {
                  final resource = resources[index];
                  return ListTile(
                    title: Text(resource.name),
                    subtitle: Text(
                        "Quantità: ${resource.quantity} (Soglia: ${resource.threshold})"),
                    trailing: resource.quantity <= resource.threshold
                        ? Icon(Icons.warning, color: Colors.red)
                        : null,
                  );
                },
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                // Aggiungere una nuova risorsa o gestire notifiche
              },
              icon: Icon(Icons.add),
              label: Text("Aggiungi Risorsa"),
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
