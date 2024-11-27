import 'package:flutter/material.dart';
import 'package:frontend/screens/welcome_screen.dart';

class ClientHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'VetAI',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto',
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WelcomeScreen(),
              ),
            );
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icona principale
            Icon(
              Icons.construction, // Icona lavori in corso
              size: 100,
              color: Colors.orange,
            ),
            SizedBox(height: 20),
            // Testo principale
            Text(
              'In Progress',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            // Testo secondario
            Text(
              'Stiamo lavorando per migliorare questa pagina!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 30),
            // Aggiunta di icone extra per un tocco estetico
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.build,
                  size: 50,
                  color: Colors.blue,
                ),
                SizedBox(width: 20),
                Icon(
                  Icons.engineering,
                  size: 50,
                  color: Colors.green,
                ),
                SizedBox(width: 20),
                Icon(
                  Icons.lightbulb,
                  size: 50,
                  color: Colors.yellow[700],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
