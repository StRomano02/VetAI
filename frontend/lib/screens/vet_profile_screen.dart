import 'package:flutter/material.dart';
import 'welcome_screen.dart'; // Assicurati di avere questa schermata nel tuo progetto

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profilo',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green,
      ),
      body: ListView(
        children: [
          // Sezione Profilo
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.grey[200],
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(
                      'assets/images/default_user.png'), // Sostituisci con il path della tua immagine
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nome Utente',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'email@esempio.com',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Divider
          Divider(thickness: 1),

          // Lista delle opzioni
          ProfileOption(
            icon: Icons.settings,
            text: 'Impostazioni',
            onTap: () {
              // Logica per la pagina delle impostazioni
            },
          ),
          ProfileOption(
            icon: Icons.info,
            text: 'Guida',
            onTap: () {
              // Logica per aprire la guida
            },
          ),
          ProfileOption(
            icon: Icons.gavel,
            text: 'Termini e Condizioni',
            onTap: () {
              // Logica per aprire Termini e Condizioni
            },
          ),
          ProfileOption(
            icon: Icons.feedback,
            text: 'Manda un Feedback',
            onTap: () {
              // Logica per inviare feedback
            },
          ),
          ProfileOption(
            icon: Icons.help,
            text: 'Centro Assistenza',
            onTap: () {
              // Logica per aprire il Centro Assistenza
            },
          ),
          Divider(thickness: 1),
          ProfileOption(
            icon: Icons.logout,
            text: 'Esci',
            onTap: () {
              // Torna alla WelcomePage
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => WelcomeScreen()),
                (Route<dynamic> route) => false,
              );
            },
          ),
          ProfileOption(
            icon: Icons.delete_forever,
            text: 'Elimina Account',
            onTap: () {
              // Logica per eliminare l'account
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Conferma Eliminazione'),
                    content: Text(
                        'Sei sicuro di voler eliminare il tuo account? Questa azione è irreversibile.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Annulla'),
                      ),
                      TextButton(
                        onPressed: () {
                          // Logica per eliminare l'account
                          Navigator.pop(context);
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WelcomeScreen()),
                            (Route<dynamic> route) => false,
                          );
                        },
                        child: Text(
                          'Elimina',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class ProfileOption extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const ProfileOption({
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.green),
      title: Text(
        text,
        style: TextStyle(fontSize: 16),
      ),
      onTap: onTap,
    );
  }
}
