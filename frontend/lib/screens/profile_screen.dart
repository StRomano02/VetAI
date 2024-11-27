import 'package:flutter/material.dart';
import '../models/profile.dart';

class UserProfileScreen extends StatelessWidget {
  final Profile profile;

  const UserProfileScreen({required this.profile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Sfondo grigio chiaro
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Profilo',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: const Color(0xFFF5F5F5), // Testo bianco/grigio chiaro
          ),
        ),
        backgroundColor: const Color(0xFF2C2C2C), // Grigio scuro per la barra
        elevation: 1,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Testata personalizzata
          Container(
            padding: EdgeInsets.symmetric(vertical: 40),
            color: const Color(0xFFE0E0E0), // Grigio medio
            child: Column(
              children: [
                // Immagine o icona del profilo
                CircleAvatar(
                  radius: 50,
                  backgroundImage: profile.imageUrl != null
                      ? NetworkImage(profile.imageUrl!)
                      : null,
                  child: profile.imageUrl == null
                      ? Icon(Icons.person, size: 50, color: Colors.grey)
                      : null,
                  backgroundColor: Colors.white,
                ),
                SizedBox(height: 16),
                // Nome dell'utente
                Text(
                  profile.name,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF2C2C2C), // Grigio scuro
                  ),
                ),
                SizedBox(height: 8),
                // Email dell'utente
                Text(
                  profile.email,
                  style: TextStyle(
                    fontSize: 16,
                    color: const Color(0xFF4F4F4F), // Grigio
                  ),
                ),
              ],
            ),
          ),
          // Spazio per modifiche e altre opzioni
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Pulsante per modificare i dati
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EditProfileScreen(profile: profile),
                        ),
                      );
                    },
                    child: Text(
                      "Modifica Dati",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF2C2C2C), // Grigio scuro
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: const Color(0xFF2C2C2C), // Grigio scuro
                        width: 2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14),
                      minimumSize: Size(double.infinity, 50),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EditProfileScreen extends StatefulWidget {
  final Profile profile;

  const EditProfileScreen({required this.profile});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.profile.name);
    emailController = TextEditingController(text: widget.profile.email);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Sfondo grigio chiaro
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Modifica Profilo',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: const Color(0xFFF5F5F5), // Testo bianco
          ),
        ),
        backgroundColor: const Color(0xFF2C2C2C), // Grigio scuro per la barra
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Nome",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF2C2C2C), // Grigio scuro
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Inserisci il nome",
              ),
            ),
            SizedBox(height: 16),
            Text(
              "Email",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF2C2C2C), // Grigio scuro
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Inserisci l'email",
              ),
            ),
            SizedBox(height: 24),
            Center(
              child: OutlinedButton(
                onPressed: () {
                  setState(() {
                    widget.profile.name = nameController.text;
                    widget.profile.email = emailController.text;
                  });
                  Navigator.pop(context);
                },
                child: Text(
                  "Salva Modifiche",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF2C2C2C), // Grigio scuro
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: const Color(0xFF2C2C2C), // Grigio scuro
                    width: 2,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 14),
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
