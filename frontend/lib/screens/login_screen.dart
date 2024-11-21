import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/gradient_background.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'vet_home_screen.dart';
import 'client_home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  void _login() async {
    setState(() {
      _isLoading = true;
    });
    try {
      // Login e ottieni il ruolo
      final role = await Provider.of<AuthProvider>(context, listen: false)
          .login(_usernameController.text, _passwordController.text);

      // Salva lo stato di login e il ruolo
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('userRole', role);

      // Naviga alla home page specifica
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
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Errore: Username o password non validi'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
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
                Color(0xFFBBDEFB),
                Color(0xFFE3F2FD),
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
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 40),

                  // Campo Username
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Campo Password
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                    ),
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
}
