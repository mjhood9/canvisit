import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart'; // Contient MapOptions et FitBoundsOptions
import 'package:latlong2/latlong.dart'; // Contient LatLngBounds
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';
import '../widgets/custom_appbar.dart';

// --- Data Structure for Marker Information ---
class MarkerData {
  final LatLng point;
  final String name;
  final String city;
  final String description;
  final String imageUrl;

  MarkerData({
    required this.point,
    required this.name,
    required this.city,
    this.description = 'No detailed description available.',
    this.imageUrl = 'assets/images/placeholder.png',
  });
}

// ====================================================================
// ========================== Marker Data Lists =======================
// ====================================================================

final List<MarkerData> stadiumData = [
  // ... (Liste stadiumData inchangée) ...
  MarkerData(
    point: LatLng(33.9599, -6.8891),
    name: 'Complexe Moulay Abdellah',
    city: 'Rabat',
    description: "Le Complexe Sportif Prince Moulay Abdellah est le plus grand stade de Rabat. "
        "Il accueille régulièrement des matches internationaux, la Coupe du Trône, "
        "ainsi que de nombreux événements sportifs et culturels. Le stade est en "
        "phase de modernisation majeure dans le cadre de la préparation de la CAN "
        "et de la Coupe du Monde 2030.",
    imageUrl: 'assets/images/rabat/stade_abdellah.jpg',
  ),
  MarkerData(
    point: LatLng(34.0052165, -6.8453562),
    name: 'Stade Al Barid',
    city: 'Rabat',
    description: "Le Stade Al Barid est un stade historique de Rabat, principalement utilisé "
        "pour les entraînements et les compétitions locales. Bien qu'il soit de "
        "taille modeste, il occupe une place importante dans le sport régional.",
    imageUrl: 'assets/images/rabat/stade_barid.jpg',
  ),
  MarkerData(
    point: LatLng(33.5829, -7.6468),
    name: 'Mohammed V',
    city: 'Casablanca',
    description: "Le Complexe Sportif Mohammed V est le stade principal de Casablanca. "
        "Inauguré en 1955 et rénové à plusieurs reprises, il accueille les "
        "grands matchs du Wydad AC et du Raja CA ainsi que de nombreux événements sportifs.",
    imageUrl: 'assets/images/casablanca/stade.jpg',
  ),
  MarkerData(
    point: LatLng(33.9573, -6.8913),
    name: 'Stade Olympique (annexe)',
    city: 'Rabat',
    description: "Situé à côté du Complexe Prince Moulay Abdellah, ce stade annexe est utilisé "
        "pour les entraînements professionnels, les préparations d’avant-match et "
        "les compétitions d’athlétisme. Il dispose d’une piste rénovée et d’un "
        "terrain synthétique de qualité.",
    imageUrl: 'assets/images/rabat/stade_olympique.jpg',),
  MarkerData(
    point: LatLng(33.9758, -6.8238),
    name: 'Complexe Sportif Prince Héritier Moulay EL Hassan',
    city: 'Rabat',
    description: "Le Complexe Sportif Prince Héritier Moulay El Hassan est le stade officiel "
        "du FUS Rabat. Il est apprécié pour son ambiance, ses installations "
        "modernisées et son rôle majeur dans la formation des jeunes joueurs.",
    imageUrl: 'assets/images/rabat/stade_hassan.jpg',
  ),
  MarkerData(
    point: LatLng(31.7067, -7.9806),
    name: 'Grand Stade Marrakech', city: 'Marrakech',
    description: "Le Grand Stade de Marrakech, inauguré en 2011, est l’un des plus "
        "imposants stades du Maroc. Situé à environ 11 km du centre-ville, "
        "il se distingue par son architecture moderne inspirée du style "
        "traditionnel marocain. Le stade a accueilli de nombreux événements "
        "nationaux et internationaux, dont des matchs de la Coupe du Monde "
        "des Clubs FIFA.",
    imageUrl: 'assets/images/marrakech/stade.jpg',),
  MarkerData(
    point: LatLng(34.0028, -4.9689),
    name: 'Complexe Sportif de Fès', city: 'Fès',
    description: "Le Complexe Sportif de Fès est l’une des plus grandes installations "
        "sportives de la région. Construit pour répondre aux normes "
        "internationales, il accueille principalement les matchs du MAS Fès "
        "(Maghreb Association Sportive de Fès). Le stade est également utilisé "
        "pour divers événements sportifs et culturels tout au long de l'année.",
    imageUrl: 'assets/images/fes/stade.jpg',),
  MarkerData(
    point: LatLng(30.427214, -9.540424),
    name: 'Grand Stade d’Agadir', city: 'Agadir',
    description: "Le Grand Stade d’Agadir, également appelé Stade Adrar, est l’un des "
        "plus grands et plus modernes stades du Maroc. Inauguré en 2013, il "
        "a accueilli plusieurs événements internationaux dont la Coupe du Monde "
        "des Clubs FIFA. Sa conception moderne et son architecture inspirée de "
        "la région du Souss en font un édifice emblématique.",
    imageUrl: 'assets/images/agadir/stade.jpg',),
  MarkerData(
    point: LatLng(35.741211, -5.858105),
    name: 'Grand Stade de Tanger', city: 'Tanger',
    description: "Le Grand Stade de Tanger, également appelé Stade Ibn Battouta, est "
        "l’un des stades les plus modernes du Maroc. Construit en 2011, il a "
        "bénéficié d’importantes rénovations récentes en 2023–2025 afin de "
        "répondre aux standards internationaux pour les grandes compétitions "
        "comme la Coupe du Monde des Clubs de la FIFA et la CAN.\n\n"

        "Aujourd'hui, le stade est considéré comme l’un des plus beaux "
        "complexes sportifs d’Afrique du Nord.",
    imageUrl: 'assets/images/tangier/stade.jpg',),
];

final List<MarkerData> fanZoneData = [
  // ... (Liste fanZoneData inchangée) ...
  MarkerData(
    point: LatLng(33.60609, -7.65345),
    name: 'Espace Torro',
    city: 'Casablanca',
    description: "Lieu événementiel majeur et une grande place dans le quartier d'Aïn Diab à Casablanca. Il est principalement utilisé pour accueillir de vastes manifestations, festivals (comme WeCasablanca) et salons commerciaux (comme le salon de l'automobile d'occasion), grâce à sa capacité à gérer un large public. Cet endroit central est incontournable pour les grands rassemblements en plein air de la métropole.",
    imageUrl: 'assets/images/casablanca/fanzone1.jpg',
  ),
  MarkerData(
    point: LatLng(33.56344, -7.65718),
    name: 'Anfa Park',
    city: 'Casablanca',
    description: "Immense parc urbain moderne et paysager, situé sur l'ancien site de l'aéroport d'Anfa, offrant un vaste espace de loisirs, de détente et de rassemblement, souvent utilisé pour des événements majeurs.",
    imageUrl: 'assets/images/casablanca/fanzone2.jpg',
  ),
  MarkerData(
    point: LatLng(33.99242, -6.83601),
    name: 'Esplanade OLM Souissi',
    city: 'Rabat',
    description: "Vaste terrain en plein air situé dans le quartier de Souissi, mondialement célèbre pour être le site principal qui accueille chaque année le festival de musique international Mawazine, en faisant l'une des plus grandes scènes de concerts au Maroc.",
    imageUrl: 'assets/images/rabat/fanzone1.jpg',),
  MarkerData(
    point: LatLng(33.92653, -6.91365),
    name: 'Place de Kasbah de Temara',
    city: 'Rabat',
    description: "Lieu historique et un point de rassemblement central de la ville, souvent utilisé pour des événements communautaires, culturels et, plus récemment, comme l'une des Fan Zones officielles pour les grands événements sportifs comme la CAN 2025.",
    imageUrl: 'assets/images/rabat/kasbah_oudayas.jpg',),
  MarkerData(
    point: LatLng(35.78309, -5.76524),
    name: 'Villa Harris Park',
    city: 'Tanger',
    description: "Magnifique parc public et une ancienne résidence historique, offrant une oasis de verdure sur le boulevard Mohamed VI, et un lieu prisé pour la détente, l'histoire et les événements, servant notamment de Fan Zone pour des compétitions sportives.",
    imageUrl: 'assets/images/tangier/fanzone.jpg',),
  MarkerData(
    point: LatLng(34.04954, -5.02695),
    name: 'Jardin Botanique',
    city: 'Fes',
    description: "L'un des plus anciens et des plus beaux jardins publics de Fès, créé au XIXe siècle, reconnu pour ses étangs, ses espaces luxuriants et sa collection de plus de 3 000 espèces de plantes.",
    imageUrl: 'assets/images/fes/fanzone.jpg',),
  MarkerData(
    point: LatLng(31.63447, -8.00041),
    name: 'Place Bab Doukkala',
    city: 'Marrakech',
    description: "Place historique et un carrefour très fréquenté à Marrakech, située à l'une des portes principales de la Médina, servant de nœud de transport et de lieu de vie communautaire, ainsi que de lieu de rassemblement pour des événements (elle a été désignée comme une Fan Zone pour la CAN 2025).",
    imageUrl: 'assets/images/marrakech/fanzone.jpg',),
  MarkerData(
    point: LatLng(30.42314, -9.61437),
    name: 'Place Agadir ( La Marina )',
    city: 'Agadir',
    description: "Un complexe touristique, résidentiel et de plaisance de luxe, situé au pied de la Kasbah, offrant un port de plaisance, des boutiques, des restaurants, des cafés et des appartements, constituant un lieu de vie et de loisirs incontournable de la ville.",
    imageUrl: 'assets/images/agadir/marina.jpg',),
];

// ====================================================================
// =========================== MapPage Class ==========================
// ====================================================================

class MapPage extends StatefulWidget {
  const MapPage({super.key});
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with TickerProviderStateMixin {
  LatLng? _currentLocation;
  late final AnimatedMapController _animatedMapController;

  String _searchQuery = '';
  bool _showStadiums = true;
  bool _showFanZones = true;
  bool _isPanelOpen = false;

  // State variable for route polyline
  List<LatLng> _routePoints = [];

  // OpenRouteService API Key (Using the provided key)
  final String _openRouteServiceApiKey = 'eyJvcmciOiI1YjNjZTM1OTc4NTExMTAwMDFjZjYyNDgiLCJpZCI6IjIxM2JjYjgzNGFkNjQ0ZGJhMzExNWUwOTMyYmE0ODc2IiwiaCI6Im11cm11cjY0In0=';

  @override
  void initState() {
    super.initState();
    _animatedMapController = AnimatedMapController(vsync: this);
    _fetchCurrentLocationMarkerOnly();
  }

  // --- Location Logic (Unchanged) ---
  Future<void> _fetchCurrentLocationMarkerOnly() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }
    if (permission == LocationPermission.deniedForever) return;

    final pos = await Geolocator.getCurrentPosition();
    setState(() {
      _currentLocation = LatLng(pos.latitude, pos.longitude);
    });
  }

  void _goToMyLocation() async {
    // Clear route when moving to my location
    setState(() {
      _routePoints = [];
    });

    await _fetchCurrentLocationMarkerOnly();
    if (_currentLocation == null) return;

    _animatedMapController.animateTo(
      dest: _currentLocation!,
      zoom: 15.0,
      curve: Curves.fastOutSlowIn,
      duration: const Duration(milliseconds: 900),
    );
  }

  // --- CORRECTION: Fonction pour animer la carte pour s'adapter à une liste de points LatLng ---
  void _moveMapToBounds(List<LatLng> points) {
    if (points.isEmpty) return;

    double minLat = points.first.latitude;
    double maxLat = points.first.latitude;
    double minLng = points.first.longitude;
    double maxLng = points.first.longitude;

    for (final p in points) {
      minLat = min(minLat, p.latitude);
      maxLat = max(maxLat, p.latitude);
      minLng = min(minLng, p.longitude);
      maxLng = max(maxLng, p.longitude);
    }

    final center = LatLng(
      (minLat + maxLat) / 2,
      (minLng + maxLng) / 2,
    );

    final latDiff = (maxLat - minLat).abs();
    final lngDiff = (maxLng - minLng).abs();
    final maxDiff = max(latDiff, lngDiff);

    // Simple zoom heuristic for world map
    double zoom = 15;
    if (maxDiff > 5) zoom = 5;
    else if (maxDiff > 2) zoom = 6;
    else if (maxDiff > 1) zoom = 7;
    else if (maxDiff > 0.5) zoom = 9;
    else if (maxDiff > 0.25) zoom = 11;
    else if (maxDiff > 0.1) zoom = 13;

    _animatedMapController.animateTo(
      dest: center,
      zoom: zoom,
      curve: Curves.easeInOut,
      duration: const Duration(seconds: 1),
    );
  }

  // --- Fonction générique pour calculer l'itinéraire ---
  Future<void> _calculateAndDrawRoute(LatLng destinationPoint) async {
    if (_currentLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez activer votre géolocalisation pour calculer l\'itinéraire.')),
      );
      return;
    }

    // Clear previous route
    setState(() {
      _routePoints = [];
    });

    final startLng = _currentLocation!.longitude;
    final startLat = _currentLocation!.latitude;
    final endLng = destinationPoint.longitude;
    final endLat = destinationPoint.latitude;

    final url = Uri.parse(
        'https://api.openrouteservice.org/v2/directions/driving-car'
            '?api_key=$_openRouteServiceApiKey'
            '&start=$startLng,$startLat'
            '&end=$endLng,$endLat');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final coordinates = data['features'][0]['geometry']['coordinates'] as List;

        // Convert ORS [longitude, latitude] pairs to Flutter Map LatLng
        final List<LatLng> points = coordinates.map((coord) {
          return LatLng(coord[1] as double, coord[0] as double);
        }).toList();

        setState(() {
          _routePoints = points;
        });

        // Use the corrected helper function to move the map
        _moveMapToBounds(_routePoints);

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur API (${response.statusCode}): Impossible de calculer l\'itinéraire. (Code: ${response.statusCode})')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Une erreur s\'est produite lors du calcul de l\'itinéraire: $e')),
      );
    }
  }


  // --- Bottom Sheet Logic for Marker Details (Unchanged) ---
  void _showMarkerDetails(MarkerData data) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.5,
          minChildSize: 0.3,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. Image and Drag Handle
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        // Image
                        SizedBox(
                          height: 200,
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                            child: Image.asset(
                              data.imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Center(
                                  child: Icon(
                                    Icons.error_outline,
                                    size: 50,
                                    color: Colors.grey,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        // Drag Handle
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Container(
                            width: 40,
                            height: 5,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(2.5),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // 2. Details
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Name
                          Text(
                            data.name,
                            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          // Location (City)
                          Row(
                            children: [
                              const Icon(Icons.location_city, size: 16, color: Colors.grey),
                              const SizedBox(width: 4),
                              Text(
                                data.city,
                                style: const TextStyle(fontSize: 18, color: Colors.grey),
                              ),
                            ],
                          ),
                          const Divider(height: 24),
                          // Description
                          Text(
                            data.description,
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 32),

                          // 3. Action Buttons
                          Row(
                            children: [
                              // Button to close the bottom sheet
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () => Navigator.pop(context), // <--- CLOSE ACTION
                                  icon: const Icon(Icons.close),
                                  label: const Text('Fermer'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey[300],
                                    foregroundColor: Colors.black,
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),

                              // Button to calculate and draw route
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.pop(context); // Close the sheet
                                    _calculateAndDrawRoute(data.point); // Calculate route
                                  },
                                  icon: const Icon(Icons.directions),
                                  label: const Text('Itinéraire'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // --- Marker Building and Filtering Logic (Unchanged) ---

  // Helper function to create a Marker widget from MarkerData
  Marker _buildMarker(MarkerData data, {required bool isStadium}) {
    final color = isStadium ? const Color(0xFF7A0C0F) : const Color(0xFF2E7D32);
    final iconChild = isStadium
        ? const Icon(Icons.stadium, color: Colors.white, size: 24)
        : Image.asset('assets/images/supporters.png', width: 24, height: 24, color: Colors.white);

    // Marker is now wrapped in GestureDetector
    return Marker(
      point: data.point,
      width: 40,
      height: 40,
      child: GestureDetector(
        onTap: () => _showMarkerDetails(data), // <-- Tap handler
        child: Container(
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Center(child: iconChild),
        ),
      ),
    );
  }

  // Combines and filters all marker lists (Unchanged)
  List<Marker> _getFilteredMarkers() {
    final List<Marker> filtered = [];
    final query = _searchQuery.toLowerCase();

    // 1. Filter and Add Stadium Markers
    if (_showStadiums) {
      filtered.addAll(
        stadiumData
            .where((data) => data.name.toLowerCase().contains(query) || data.city.toLowerCase().contains(query))
            .map((data) => _buildMarker(data, isStadium: true)),
      );
    }

    // 2. Filter and Add Fan Zone Markers
    if (_showFanZones) {
      filtered.addAll(
        fanZoneData
            .where((data) => data.name.toLowerCase().contains(query) || data.city.toLowerCase().contains(query))
            .map((data) => _buildMarker(data, isStadium: false)),
      );
    }

    // 3. Add Current Location Marker
    if (_currentLocation != null) {
      filtered.add(
        Marker(
          point: _currentLocation!,
          width: 18,
          height: 18,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.4),
                  blurRadius: 15,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Center(
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return filtered;
  }

  // --- Widget for the Control Panel (Hub) (Unchanged) ---
  Widget _buildControlPanel() {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      top: 0,
      bottom: 0,
      left: _isPanelOpen ? 0 : -280, // Ajusté pour 280
      child: Container(
        width: 280,
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0, right: 8.0, bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => setState(() => _isPanelOpen = false),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Search location or city',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                'Filtrer Marqueux',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              title: const Text('Stades (Rouge)'),
              trailing: Switch(
                value: _showStadiums,
                onChanged: (bool value) {
                  setState(() {
                    _showStadiums = value;
                  });
                },
                activeColor: const Color(0xFF7A0C0F),
              ),
            ),
            ListTile(
              title: const Text('Fan Zones (Vert)'),
              trailing: Switch(
                value: _showFanZones,
                onChanged: (bool value) {
                  setState(() {
                    _showFanZones = value;
                  });
                },
                activeColor: const Color(0xFF2E7D32),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Stack(
        children: [
          // 1. FlutterMap
          FlutterMap(
            mapController: _animatedMapController.mapController,
            options: const MapOptions(
              initialCenter: LatLng(33.5731, -7.5898),
              initialZoom: 5.5,
            ),
            children: [
              TileLayer(
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                userAgentPackageName: 'com.example.canvisit',
              ),

              // Polyline Layer to draw the route
              PolylineLayer(
                polylines: [
                  if (_routePoints.isNotEmpty)
                    Polyline(
                      points: _routePoints,
                      color: Colors.blue,
                      strokeWidth: 5.0,
                    ),
                ],
              ),

              // Marker Layer
              MarkerLayer(
                markers: _getFilteredMarkers(),
              ),
            ],
          ),

          // 2. Map Control Hub Button (Top Left)
          Positioned(
            top: 10,
            left: 10,
            child: FloatingActionButton(
              mini: true,
              backgroundColor: Colors.white,
              onPressed: () => setState(() => _isPanelOpen = true),
              heroTag: 'mapHub',
              child: const Icon(Icons.filter_list, color: Colors.black54),
            ),
          ),

          // 3. The Control Panel (Slide-in UI)
          _buildControlPanel(),
        ],
      ),
      // 4. My Location Button (Bottom Right)
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        shape: const CircleBorder(),
        onPressed: _goToMyLocation,
        heroTag: 'myLocation',
        child: const Icon(Icons.my_location, color: Colors.blue),
      ),
    );
  }
}