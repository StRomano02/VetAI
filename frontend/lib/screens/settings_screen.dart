import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Impostazioni'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          SwitchListTile(
            title: Text('Notifiche'),
            value: true,
            onChanged: (value) {
              // Gestione delle notifiche
            },
          ),
          ListTile(
            title: Text('Lingua'),
            subtitle: Text('Italiano'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Naviga a una schermata per modificare la lingua
            },
          ),
          ListTile(
            title: Text('Tema'),
            subtitle: Text('Chiaro'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Naviga a una schermata per modificare il tema
            },
          ),
        ],
      ),
    );
  }
}
