import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'vet_home_screen.dart';
import 'client_home_screen.dart';
import 'welcome_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _selectedRole = 'client';
  bool _isLoading = false;

  bool hasMinLength = false;
  bool hasNumber = false;
  bool hasSpecialChar = false;

  void _validatePassword(String password) {
    setState(() {
      hasMinLength = password.length >= 8;
      hasNumber = RegExp(r'\d').hasMatch(password);
      hasSpecialChar = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);
    });
  }

  void _signUp() async {
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
      // Chiama il metodo signUp del provider
      await Provider.of<AuthProvider>(context, listen: false).signUp(
        _nameController.text,
        _surnameController.text,
        _emailController.text,
        _passwordController.text,
        _selectedRole,
      );

      // Naviga alla schermata di login o alla home dopo la registrazione
      if (_selectedRole == 'vet') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => VetHomeScreen()),
        );
      } else if (_selectedRole == 'client') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ClientHomeScreen()),
        );
      }
    } catch (error) {
      // Mostra un messaggio di errore
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registrazione fallita: ${error.toString()}'),
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
      backgroundColor: Colors.white, // Sfondo bianco
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.grey),
                  onPressed: () {
                    // Torna alla WelcomePage
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => WelcomeScreen()),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 100,
                child: Image.asset('assets/images/logo.png'), // Logo
              ),
              SizedBox(height: 20),
              Text(
                'Crea un Account',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800], // Testo grigio scuro
                ),
              ),
              SizedBox(height: 20),
              DropdownButton<String>(
                value: _selectedRole,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedRole = newValue!;
                  });
                },
                items: <String>['client', 'vet']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value == 'client'
                          ? ' Cerco un animale'
                          : ' Sono un veterinario',
                      style: TextStyle(color: Colors.grey[800]),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              SizedBox(height: 20),
              _buildTextField(
                controller: _nameController,
                labelText: 'Nome',
                icon: Icons.person,
              ),
              SizedBox(height: 20),
              _buildTextField(
                controller: _surnameController,
                labelText: 'Cognome',
                icon: Icons.person_outline,
              ),
              SizedBox(height: 20),
              _buildTextField(
                controller: _emailController,
                labelText: 'Email',
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20),
              _buildTextField(
                controller: _passwordController,
                labelText: 'Password',
                icon: Icons.lock,
                obscureText: true,
                onChanged: _validatePassword,
              ),
              SizedBox(height: 20),
              _buildPasswordCriteria(),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed:
                    hasMinLength && hasNumber && hasSpecialChar && !_isLoading
                        ? _signUp
                        : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.grey[800], // Colore grigio scuro per il bottone
                  disabledBackgroundColor:
                      Colors.grey[400], // Colore bottone disabilitato
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text(
                        'Registrati',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    Function(String)? onChanged,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.grey[600]), // Testo grigio chiaro
        prefixIcon: Icon(icon, color: Colors.grey[600]),
        filled: true,
        fillColor: Colors.grey[200], // Sfondo chiaro del campo
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      keyboardType: keyboardType,
      obscureText: obscureText,
      onChanged: onChanged,
    );
  }

  Widget _buildPasswordCriteria() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCriteriaRow('Almeno 8 caratteri', hasMinLength),
        _buildCriteriaRow('Almeno 1 numero', hasNumber),
        _buildCriteriaRow('Almeno 1 carattere speciale', hasSpecialChar),
      ],
    );
  }

  Widget _buildCriteriaRow(String text, bool isValid) {
    return Row(
      children: [
        Icon(
          isValid ? Icons.check_circle : Icons.cancel,
          color: isValid ? Colors.green : Colors.red,
        ),
        SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(color: Colors.grey[800]),
        ),
      ],
    );
  }
}
