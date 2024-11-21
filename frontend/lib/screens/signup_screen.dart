import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'welcome_screen.dart';
import 'home_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  // Stato dei criteri per la password
  bool hasMinLength = false;
  bool hasNumber = false;
  bool hasSpecialChar = false;

  // Funzione per validare la password
  void _validatePassword(String password) {
    setState(() {
      hasMinLength = password.length >= 8;
      hasNumber = RegExp(r'\d').hasMatch(password);
      hasSpecialChar = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);
    });
  }

  // Funzione per registrare l'utente
  void _signUp() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<AuthProvider>(context, listen: false).signUp(
        _usernameController.text,
        _emailController.text,
        _passwordController.text,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registrazione fallita: ${error.toString()}'),
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
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
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

              // Logo
              SizedBox(
                height: 100,
                child: Image.asset('assets/images/logo.png'),
              ),
              SizedBox(height: 20),

              // Nome del progetto
              Text(
                'Nome del progetto',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),

              // Campo Username
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),

              // Campo Email
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20),

              // Campo Password
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                onChanged: _validatePassword,
              ),
              SizedBox(height: 20),

              // Criteri password
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        hasMinLength ? Icons.check_circle : Icons.cancel,
                        color: hasMinLength ? Colors.green : Colors.red,
                      ),
                      SizedBox(width: 8),
                      Text('Almeno 8 caratteri'),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        hasNumber ? Icons.check_circle : Icons.cancel,
                        color: hasNumber ? Colors.green : Colors.red,
                      ),
                      SizedBox(width: 8),
                      Text('Almeno 1 numero'),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        hasSpecialChar ? Icons.check_circle : Icons.cancel,
                        color: hasSpecialChar ? Colors.green : Colors.red,
                      ),
                      SizedBox(width: 8),
                      Text('Almeno 1 carattere speciale'),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Bottone Registrati
              ElevatedButton(
                onPressed: hasMinLength &&
                        hasNumber &&
                        hasSpecialChar &&
                        !_isLoading
                    ? _signUp
                    : null, // Disabilita il bottone se i criteri non sono soddisfatti
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isLoading
                    ? CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : Text(
                        'Registrati',
                        style: TextStyle(fontSize: 18),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
