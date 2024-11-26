class Animal {
  final String name;
  final String species;
  final String status;
  final String? breed;
  final String? gender;
  final String? birthDateOrAge;
  final String? colorOrMarks;
  final String? microchipNumber;
  final String? currentWeight;
  final String? ownerName;
  final String? ownerContact;
  final String? ownerAddress;
  final List<String>? ownerAppointments;
  final Map<String, dynamic>? medicalHistory;
  final String? dietNotes;
  final String? reproductionNotes;
  final List<Map<String, String>>? prescribedDrugs;
  final List<Map<String, String>>? diagnosticTests;
  final String? photoUrl; // Nuovo campo per la foto

  Animal({
    required this.name,
    required this.species,
    required this.status,
    this.breed,
    this.gender,
    this.birthDateOrAge,
    this.colorOrMarks,
    this.microchipNumber,
    this.currentWeight,
    this.ownerName,
    this.ownerContact,
    this.ownerAddress,
    this.ownerAppointments,
    this.medicalHistory,
    this.dietNotes,
    this.reproductionNotes,
    this.prescribedDrugs,
    this.diagnosticTests,
    this.photoUrl, // Aggiunto al costruttore
  });

  // Metodo per creare un oggetto Animal da una mappa
  factory Animal.fromMap(Map<String, dynamic> map) {
    String mapToCategory(String species) {
      if (['Cane', 'Cagna'].contains(species)) {
        return 'Cani';
      } else if (['Gatto', 'Gattina'].contains(species)) {
        return 'Gatti';
      } else {
        return 'Altri';
      }
    }

    return Animal(
      name: map['name'],
      species: mapToCategory(map['species']), // Mappa la specie alla categoria
      status: map['status'],
      breed: map['breed'],
      gender: map['gender'],
      birthDateOrAge: map['birthDateOrAge'],
      colorOrMarks: map['colorOrMarks'],
      microchipNumber: map['microchipNumber'],
      currentWeight: map['currentWeight'],
      ownerName: map['ownerName'],
      ownerContact: map['ownerContact'],
      ownerAddress: map['ownerAddress'],
      ownerAppointments: List<String>.from(map['ownerAppointments'] ?? []),
      medicalHistory: Map<String, dynamic>.from(map['medicalHistory'] ?? {}),
      dietNotes: map['dietNotes'],
      reproductionNotes: map['reproductionNotes'],
      prescribedDrugs:
          List<Map<String, String>>.from(map['prescribedDrugs'] ?? []),
      diagnosticTests:
          List<Map<String, String>>.from(map['diagnosticTests'] ?? []),
      photoUrl: map['photoUrl'], // Aggiunto per la foto
    );
  }
}
