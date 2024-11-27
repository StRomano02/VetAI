class Profile {
  String name;
  String email;
  String? imageUrl;

  Profile({
    required this.name,
    required this.email,
    this.imageUrl,
  });
}

// Esempi di profili
final List<Profile> exampleProfiles = [
  Profile(
    name: "Luca Verdi",
    email: "luca.verdi@example.com",
    imageUrl: "https://example.com/image1.jpg",
  ),
  Profile(
    name: "Dr. Marco Rossi",
    email: "marco.rossi@clinicavet.com",
    imageUrl: null, // Nessuna immagine, usa l'icona predefinita
  ),
  Profile(
    name: "Giulia Bianchi",
    email: "giulia.bianchi@example.com",
    imageUrl: "https://example.com/image2.jpg",
  ),
];
