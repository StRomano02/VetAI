import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/gradient_background.dart';
import 'vet_home_screen.dart';
import 'client_home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  void _login() async {
    final email = _emailController.text;

    // Controlla se le credenziali corrispondono a quelle hardcoded
    if (email == 'vet@vetai.com') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => VetHomeScreen()),
      );
      return; // Esci dal metodo, evitando di eseguire il resto della logica
    } else if (email == 'client@vetai.com') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ClientHomeScreen()),
      );
      return; // Esci dal metodo
    }

    setState(() {
      _isLoading = true; // Mostra il caricamento
    });

    try {
      // Login tramite il provider
      final role = await Provider.of<AuthProvider>(context, listen: false)
          .login(_emailController.text, _passwordController.text);

      // Naviga alla pagina appropriata in base al ruolo
      if (role == 'vet') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => VetHomeScreen()),
        );
      } else if (role == 'client') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ClientHomeScreen()),
        );
      }
    } on Exception catch (e) {
      // Gestione dettagliata degli errori
      String errorMessage = 'Errore sconosciuto. Riprova più tardi.';
      if (e.toString().contains('Invalid credentials')) {
        errorMessage = 'Email o password non validi.';
      } else if (e.toString().contains('Network')) {
        errorMessage = 'Errore di rete. Controlla la tua connessione.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false; // Nasconde il caricamento
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 255, 255, 255),
                Color.fromARGB(255, 242, 242, 242),
              ],
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Bottone Indietro
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.grey),
                      onPressed: () {
                        Navigator.pop(context); // Torna alla Welcome Page
                      },
                    ),
                  ),
                  SizedBox(height: 20), // Spazio tra il bottone e il form

                  // Logo
                  SizedBox(
                    height: 100,
                    child: Image.asset('assets/images/logo.png'),
                  ),
                  SizedBox(height: 20),

                  // Nome del progetto
                  Text(
                    'VetAI',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Cambia il colore in nero
                    ),
                  ),
                  SizedBox(height: 40),

                  // Campo Username (Email)
                  _buildTextField(
                    controller: _emailController,
                    labelText: 'Email',
                    icon: Icons.email,
                  ),
                  SizedBox(height: 20),

                  // Campo Password
                  _buildTextField(
                    controller: _passwordController,
                    labelText: 'Password',
                    icon: Icons.lock,
                    obscureText: true,
                  ),
                  SizedBox(height: 20),

                  // Bottone Login
                  _isLoading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: _login,
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Login',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.grey[600]),
        prefixIcon: Icon(icon, color: Colors.grey[600]),
        filled: true,
        fillColor: Colors.white.withOpacity(0.8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
