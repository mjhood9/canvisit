class Attraction {
  final String id;
  final String name;
  final String category; // "attraction", "restaurant", "activity"
  final String imagePath;
  final String details;
  final String googleMapsUrl;

  Attraction({
    required this.id,
    required this.name,
    required this.category,
    required this.imagePath,
    required this.details,
    required this.googleMapsUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'imagePath': imagePath,
      'details': details,
      'googleMapsUrl': googleMapsUrl,
    };
  }

  factory Attraction.fromMap(Map<String, dynamic> map) {
    return Attraction(
      id: map['id'],
      name: map['name'],
      category: map['category'],
      imagePath: map['imagePath'],
      details: map['details'],
      googleMapsUrl: map['googleMapsUrl'],
    );
  }
}
