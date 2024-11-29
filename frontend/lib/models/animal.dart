class Animal {
  String? id;
  String name;
  String species;
  String status;
  String? breed;
  String? gender;
  String? birthDateOrAge;
  String? colorOrMarks;
  String? microchipNumber;
  String? currentWeight;
  String? ownerName;
  String? ownerContact;
  String? ownerAddress;
  List<String>? ownerAppointments;
  Map<String, dynamic>? medicalHistory;
  String? dietNotes;
  String? reproductionNotes;
  List<Map<String, String>>? prescribedDrugs;
  List<Map<String, String>>? diagnosticTests;
  String? photoUrl; // Nuovo campo per la foto

  Animal({
    this.id,
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
    return Animal(
      name: map['name'],
      species: map['species'], // Mappa la specie alla categoria
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

void addAnimal({
  required String name,
  required String species,
  required String status,
  String? breed,
  String? gender,
  String? birthDateOrAge,
  String? colorOrMarks,
  String? microchipNumber,
  String? currentWeight,
  String? ownerName,
  String? ownerContact,
  String? ownerAddress,
  List<String>? ownerAppointments,
  Map<String, dynamic>? medicalHistory,
  String? dietNotes,
  String? reproductionNotes,
  List<Map<String, String>>? prescribedDrugs,
  List<Map<String, String>>? diagnosticTests,
  String? photoUrl,
}) {
  final newAnimal = Animal(
    name: name,
    species: species,
    status: status,
    breed: breed,
    gender: gender,
    birthDateOrAge: birthDateOrAge,
    colorOrMarks: colorOrMarks,
    microchipNumber: microchipNumber,
    currentWeight: currentWeight,
    ownerName: ownerName,
    ownerContact: ownerContact,
    ownerAddress: ownerAddress,
    ownerAppointments: ownerAppointments,
    medicalHistory: medicalHistory,
    dietNotes: dietNotes,
    reproductionNotes: reproductionNotes,
    prescribedDrugs: prescribedDrugs,
    diagnosticTests: diagnosticTests,
    photoUrl: photoUrl,
  );

  exampleAnimals.add(newAnimal);
}

final List<Animal> exampleAnimals = [
  Animal(
    name: 'Shaky',
    species: 'Cane',
    status: 'In cerca di casa',
    breed: 'Golden Retriever',
    gender: 'Maschio',
    birthDateOrAge: '2 anni',
    colorOrMarks: 'Dorato con macchie bianche',
    microchipNumber: '1234567890',
    currentWeight: '25 kg',
    ownerName: 'Mario Rossi',
    ownerContact: '+39 345 678 910',
    ownerAddress: 'Via Roma 10, Milano, Italia',
    ownerAppointments: [
      'Visita generale - 10/10/2024',
      'Vaccino antirabbico - 01/11/2024',
    ],
    medicalHistory: {
      '2023-09-15': 'Intervento chirurgico per rimozione massa tumorale.',
      '2024-02-10': 'Diagnosi di allergia alimentare.',
    },
    dietNotes: 'Mangime ipoallergenico consigliato.',
    reproductionNotes: 'Sterilizzato il 20/03/2024.',
    prescribedDrugs: [
      {
        'name': 'Antibiotico',
        'dose': '1 compressa al giorno',
        'duration': '10 giorni'
      },
      {
        'name': 'Antistaminico',
        'dose': '2 compresse al giorno',
        'duration': '5 giorni'
      },
    ],
    diagnosticTests: [
      {
        'type': 'Radiografia',
        'date': '15/09/2024',
        'result': 'Nessuna anomalia rilevata.'
      },
      {
        'type': 'Esame del sangue',
        'date': '01/11/2024',
        'result': 'Livelli di glucosio normali.'
      },
    ],
    photoUrl: 'assets/images/shakina.jpeg',
  ),
  Animal(
    name: 'Sophie',
    species: 'Gatto',
    status: 'In cerca di casa',
    breed: 'Maine Coon',
    gender: 'Femmina',
    birthDateOrAge: '3 anni',
    colorOrMarks: 'Grigia con occhi verdi',
    microchipNumber: '0987654321',
    currentWeight: '7 kg',
    ownerName: 'Luisa Bianchi',
    ownerContact: '+39 333 123 456',
    ownerAddress: 'Via Napoli 5, Roma, Italia',
    ownerAppointments: [
      'Controllo annuale - 15/02/2024',
      'Pulizia dentale - 20/04/2024',
    ],
    medicalHistory: {
      '2023-06-12': 'Asportazione dente danneggiato.',
    },
    dietNotes: 'Alimentazione bilanciata consigliata.',
    reproductionNotes: 'Non sterilizzata.',
    prescribedDrugs: [],
    diagnosticTests: [],
    photoUrl: 'https://example.com/photos/sophie.jpg',
  ),
  Animal(
    name: 'Tosca',
    species: 'Cane',
    status: 'In cerca di casa',
    breed: 'Labrador',
    gender: 'Femmina',
    birthDateOrAge: '5 anni',
    colorOrMarks: 'Nera',
    microchipNumber: '1122334455',
    currentWeight: '30 kg',
    ownerName: 'Giovanni Verdi',
    ownerContact: '+39 328 987 654',
    ownerAddress: 'Via Firenze 20, Bologna, Italia',
    ownerAppointments: [
      'Visita generale - 01/03/2024',
    ],
    medicalHistory: {
      '2022-12-01': 'Infortunio alla zampa destra.',
    },
    dietNotes: 'Porzioni ridotte per controllo peso.',
    reproductionNotes: 'Sterilizzata il 10/08/2022.',
    prescribedDrugs: [],
    diagnosticTests: [],
    photoUrl: 'https://example.com/photos/tosca.jpg',
  ),
  Animal(
    name: 'Domi',
    species: 'Gatto',
    status: 'In cura',
    breed: 'Siamese',
    gender: 'Maschio',
    birthDateOrAge: '1 anno',
    colorOrMarks: 'Crema con macchie scure',
    microchipNumber: '6677889900',
    currentWeight: '5 kg',
    ownerName: 'Elena Neri',
    ownerContact: '+39 320 456 789',
    ownerAddress: 'Via Torino 8, Venezia, Italia',
    ownerAppointments: [],
    medicalHistory: {},
    dietNotes: 'Cibo specifico per gatti giovani.',
    reproductionNotes: 'Non sterilizzato.',
    prescribedDrugs: [],
    diagnosticTests: [],
    photoUrl: 'https://example.com/photos/domi.jpg',
  ),
  Animal(
    name: 'Squalo',
    species: 'Coniglio',
    status: 'In cura',
    breed: 'Nano',
    gender: 'Maschio',
    birthDateOrAge: '6 mesi',
    colorOrMarks: 'Bianco',
    microchipNumber: '4433221100',
    currentWeight: '1.5 kg',
    ownerName: 'Francesca Blu',
    ownerContact: '+39 389 987 123',
    ownerAddress: 'Via Bari 3, Torino, Italia',
    ownerAppointments: [],
    medicalHistory: {
      '2024-04-01': 'Vaccinazione per mixomatosi.',
    },
    dietNotes: 'Verdure fresche giornaliere consigliate.',
    reproductionNotes: 'Non sterilizzato.',
    prescribedDrugs: [],
    diagnosticTests: [],
    photoUrl: 'https://example.com/photos/squalo.jpg',
  ),
];
