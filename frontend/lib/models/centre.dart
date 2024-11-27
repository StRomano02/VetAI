class Centre {
  final String name;
  final String address;
  final String phoneNumber;
  final String imageUrl;

  Centre({
    required this.name,
    required this.address,
    required this.phoneNumber,
    required this.imageUrl,
  });
}

final Centre exampleCentre = Centre(
  name: "Ambulatorio Cimarosa",
  address: "Via Cimarosa Domenico, 37 80127 Napoli (NA)",
  phoneNumber: "081 5565933",
  imageUrl: "https://via.placeholder.com/150",
);

final List<Centre> sampleCentres = [
  Centre(
    name: "Clinica Veterinaria Milano",
    address: "Via Roma 10, Milano",
    phoneNumber: "02 12345678",
    imageUrl: "https://via.placeholder.com/150",
  ),
  Centre(
    name: "Ambulatorio Veterinario Roma",
    address: "Piazza Venezia 5, Roma",
    phoneNumber: "06 87654321",
    imageUrl: "https://via.placeholder.com/150",
  ),
];

class Resource {
  final String name;
  final int quantity;
  final int threshold;

  Resource({
    required this.name,
    required this.quantity,
    required this.threshold,
  });
}
