import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = 'Nome Utente';
  String email = 'email@example.com';

  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profilo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage:
                  AssetImage('assets/images/profile_placeholder.png'),
            ),
            SizedBox(height: 20),
            Text(
              'Nome',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            isEditing
                ? TextField(
                    decoration: InputDecoration(
                      hintText: 'Inserisci il tuo nome',
                    ),
                    onChanged: (value) {
                      setState(() {
                        name = value;
                      });
                    },
                  )
                : Text(name, style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Text(
              'Email',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            isEditing
                ? TextField(
                    decoration: InputDecoration(
                      hintText: 'Inserisci la tua email',
                    ),
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                  )
                : Text(email, style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isEditing = !isEditing;
                });
              },
              child: Text(isEditing ? 'Salva' : 'Modifica Profilo'),
            ),
          ],
        ),
      ),
    );
  }
}
