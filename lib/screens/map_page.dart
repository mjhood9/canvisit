import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:url_launcher/url_launcher.dart'; // Import for destination button
import '../widgets/custom_appbar.dart';

// --- Data Structure for Marker Information ---
class MarkerData {
  final LatLng point;
  final String name;
  final String city;
  final String description; // Added description
  final String imageUrl;    // Added image URL/Asset path

  MarkerData({
    required this.point,
    required this.name,
    required this.city,
    this.description = 'No detailed description available.',
    this.imageUrl = 'assets/images/placeholder.png', // Default placeholder
  });
}

// ====================================================================
// ========================== Marker Data Lists =======================
// ====================================================================

// Define the Stadium Marker Data (Extended with Description/Image)
final List<MarkerData> stadiumData = [
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
  // NOTE: You should add description/image details for all other stadiums here.
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

// Define the Fan Zone Marker Data (Extended with Description/Image)
final List<MarkerData> fanZoneData = [
  MarkerData(
    point: LatLng(33.60609, -7.65345),
    name: 'Espace Torro',
    city: 'Casablanca',
    description: "L'Espace Toro est un lieu événementiel majeur et une grande place dans le quartier d'Aïn Diab à Casablanca. Il est principalement utilisé pour accueillir de vastes manifestations, festivals (comme WeCasablanca) et salons commerciaux (comme le salon de l'automobile d'occasion), grâce à sa capacité à gérer un large public. Cet endroit central est incontournable pour les grands rassemblements en plein air de la métropole.",
    imageUrl: 'assets/images/casablanca/fanzone1.jpg',
  ),
  MarkerData(
    point: LatLng(33.56344, -7.65718),
    name: 'Anfa Park',
    city: 'Casablanca',
    description: "A spacious urban park dedicated to fan activities.",
    imageUrl: 'assets/images/casablanca/fanzone2.jpg',
  ),
  // NOTE: You should add description/image details for all other fan zones here.
  MarkerData(
      point: LatLng(33.99242, -6.83601),
      name: 'Esplanade OLM Souissi',
      city: 'Rabat',
    description: 'A historic stadium often used for local league matches.',
    imageUrl: 'assets/images/rabat/fanzone1.jpg',),
  MarkerData(
      point: LatLng(33.92653, -6.91365),
      name: 'Place de Kasbah de Temara',
      city: 'Rabat',
    description: 'A historic stadium often used for local league matches.',
    imageUrl: 'assets/images/rabat/kasbah_oudayas.jpg',),
  MarkerData(
      point: LatLng(35.78309, -5.76524),
      name: 'Villa Harris Park',
      city: 'Tanger',
    description: 'A historic stadium often used for local league matches.',
    imageUrl: 'assets/images/tangier/fanzone.jpg',),
  MarkerData(
      point: LatLng(34.04954, -5.02695),
      name: 'Jardin Botanique',
      city: 'Fes',
    description: 'A historic stadium often used for local league matches.',
    imageUrl: 'assets/images/fes/fanzone.jpg',),
  MarkerData(
      point: LatLng(31.63447, -8.00041),
      name: 'Place Bab Doukkala',
      city: 'Marrakech',
    description: 'A historic stadium often used for local league matches.',
    imageUrl: 'assets/images/marrakech/fanzone.jpg',),
  MarkerData(
      point: LatLng(30.42314, -9.61437),
      name: 'Place Agadir ( La Marina )',
      city: 'Agadir',
    description: 'A historic stadium often used for local league matches.',
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

  @override
  void initState() {
    super.initState();
    _animatedMapController = AnimatedMapController(vsync: this);
    _fetchCurrentLocationMarkerOnly();
  }

  // --- Location Logic (Unchanged) ---
  Future<void> _fetchCurrentLocationMarkerOnly() async {
    // ... (Your existing location logic)
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
    await _fetchCurrentLocationMarkerOnly();
    if (_currentLocation == null) return;

    _animatedMapController.animateTo(
      dest: _currentLocation!,
      zoom: 15.0,
      curve: Curves.fastOutSlowIn,
      duration: const Duration(milliseconds: 900),
    );
  }

  // --- NEW: Bottom Sheet Logic for Marker Details ---
  void _showMarkerDetails(MarkerData data) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows content to take up more space
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.5, // Start height (50% of screen)
          minChildSize: 0.3,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
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
                        // Image (with fallback error handling)
                        Container(
                          height: 200,
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                            child: Image.asset(
                              data.imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Center(
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
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          // Location (City)
                          Row(
                            children: [
                              const Icon(Icons.location_city, size: 16, color: Colors.grey),
                              const SizedBox(width: 4),
                              Text(
                                data.city,
                                style: TextStyle(fontSize: 18, color: Colors.grey),
                              ),
                            ],
                          ),
                          const Divider(height: 24),
                          // Description
                          Text(
                            data.description,
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 32),

                          // 3. Destination Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () => _launchDestination(data.point),
                              icon: const Icon(Icons.navigation),
                              label: const Text("Get Directions"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 12),
                              ),
                            ),
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

  // --- NEW: Function to open Google Maps ---
  void _launchDestination(LatLng point) async {
    // Standard URL for launching directions on Google Maps
    final url =
        'https://www.google.com/maps/dir/?api=1&destination=${point.latitude},${point.longitude}';

    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch directions.')),
      );
    }
  }


  // --- Marker Building and Filtering Logic (Modified) ---

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
        onTap: () => _showMarkerDetails(data), // <-- NEW: Tap handler
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

  // Combines and filters all marker lists (Unchanged, but calls new _buildMarker)
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
      // ... (Rest of the _buildControlPanel implementation is the same)
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      top: 0,
      bottom: 0,
      left: _isPanelOpen ? 0 : -300,
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
                'Filter Markers',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              title: const Text('Stadiums (Red)'),
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
              title: const Text('Fan Zones (Green)'),
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