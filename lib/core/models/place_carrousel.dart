class PlaceCarrousel {
  final String id;
  final String name;
  final String location;
  final String imageUrl;

  PlaceCarrousel({
    required this.id,
    required this.name,
    required this.location,
    required this.imageUrl,
  });

  factory PlaceCarrousel.fromFirestore(Map<String, dynamic> data, String id) {
    return PlaceCarrousel(
      id: id,
      name: data['name'] ?? '',
      location: data['location'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
    );
  }
}
