import 'package:latlong2/latlong.dart';

class Hotel {
  final String id;
  final String name;
  final String address;
  final LatLng location;
  final String? phone;
  final String? website;
  final String? type;
  final Map<String, dynamic>? tags;

  Hotel({
    required this.id,
    required this.name,
    required this.address,
    required this.location,
    this.phone,
    this.website,
    this.type,
    this.tags,
  });

  factory Hotel.fromOverpassJson(Map<String, dynamic> json) {
    final tags = json['tags'] as Map<String, dynamic>? ?? {};
    final lat = json['lat']?.toDouble() ?? json['center']?['lat']?.toDouble() ?? 0.0;
    final lon = json['lon']?.toDouble() ?? json['center']?['lon']?.toDouble() ?? 0.0;

    return Hotel(
      id: json['id'].toString(),
      name: tags['name'] ?? 'Hôtel sans nom',
      address: _buildAddress(tags),
      location: LatLng(lat, lon),
      phone: tags['phone'] ?? tags['contact:phone'],
      website: tags['website'] ?? tags['contact:website'],
      type: tags['tourism'] ?? tags['building'],
      tags: tags,
    );
  }

  static String _buildAddress(Map<String, dynamic> tags) {
    final parts = <String>[];
    if (tags['addr:street'] != null) parts.add(tags['addr:street']);
    if (tags['addr:housenumber'] != null) parts.add(tags['addr:housenumber']);
    if (tags['addr:city'] != null) parts.add(tags['addr:city']);
    if (parts.isEmpty && tags['addr:full'] != null) return tags['addr:full'];
    return parts.isEmpty ? 'Adresse non disponible' : parts.join(', ');
  }

  String get stars {
    final starsTag = tags?['stars'];
    if (starsTag != null) return '$starsTag⭐';
    return '';
  }

  String? get description => tags?['description'];

  int get priceLevel {
    // Estimation basée sur les étoiles ou autres tags
    final starsTag = tags?['stars'];
    if (starsTag != null) {
      try {
        final stars = int.parse(starsTag.toString());
        return (stars / 5 * 4).round().clamp(1, 4);
      } catch (_) {}
    }
    return 2; // Prix moyen par défaut
  }
}