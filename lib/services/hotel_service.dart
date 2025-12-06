import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import '../models/hotel_model.dart';

class HotelService {
  // Overpass API - GRATUIT et sans clé API
  static const String overpassUrl = 'https://overpass-api.de/api/interpreter';

  // Nominatim pour géocodage (convertir ville en coordonnées)
  static const String nominatimUrl = 'https://nominatim.openstreetmap.org/search';

  // Obtenir les coordonnées d'une ville
  Future<LatLng?> getCityCoordinates(String cityName) async {
    try {
      final url = Uri.parse('$nominatimUrl?q=$cityName&format=json&limit=1');
      final response = await http.get(
        url,
        headers: {'User-Agent': 'HotelFinderApp/1.0'},
      );

      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        if (data.isNotEmpty) {
          final lat = double.parse(data[0]['lat']);
          final lon = double.parse(data[0]['lon']);
          return LatLng(lat, lon);
        }
      }
    } catch (e) {
      print('Erreur géocodage: $e');
    }
    return null;
  }

  // Rechercher des hôtels dans une zone (rayon en mètres)
  Future<List<Hotel>> searchHotelsInArea({
    required LatLng center,
    int radiusMeters = 5000,
  }) async {
    // Requête Overpass QL pour trouver les hôtels
    final query = '''
    [out:json][timeout:25];
    (
      node["tourism"="hotel"](around:$radiusMeters,${center.latitude},${center.longitude});
      way["tourism"="hotel"](around:$radiusMeters,${center.latitude},${center.longitude});
      node["tourism"="guest_house"](around:$radiusMeters,${center.latitude},${center.longitude});
      way["tourism"="guest_house"](around:$radiusMeters,${center.latitude},${center.longitude});
    );
    out center;
    ''';

    try {
      final response = await http.post(
        Uri.parse(overpassUrl),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {'data': query},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List elements = data['elements'] ?? [];

        return elements
            .map((json) => Hotel.fromOverpassJson(json))
            .where((hotel) => hotel.name != 'Hôtel sans nom')
            .toList();
      } else {
        throw Exception('Erreur API Overpass: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erreur de connexion: $e');
    }
  }

  // Rechercher des hôtels par ville
  Future<List<Hotel>> searchHotelsByCity(String cityName) async {
    final coords = await getCityCoordinates(cityName);
    if (coords == null) {
      throw Exception('Ville non trouvée');
    }
    return searchHotelsInArea(center: coords, radiusMeters: 8000);
  }
}