class Profile {
  String name;
  String role;
  String email;
  String password;
  String? imageUrl;

  Profile({
    required this.name,
    required this.role,
    required this.email,
    required this.password,
    this.imageUrl,
  });
}

// Esempi di profili
final List<Profile> exampleProfiles = [
  Profile(
    name: "Stefano Romano",
    role: "vet",
    email: "stefano.romano02@outlook.com",
    password: "1234567&",
    imageUrl: null,
  ),
  Profile(
    name: "Dr. Marco Rossi",
    role: "vet",
    email: "marco.rossi@clinicavet.com",
    password: "1234567&",
    imageUrl: null,
  ),
  Profile(
    name: "Giulia Bianchi",
    role: "client",
    email: "giulia.bianchi@example.com",
    password: "1234567&",
    imageUrl: null,
  ),
];
