import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import '../widgets/custom_appbar.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with TickerProviderStateMixin {
  LatLng? _currentLocation;
  late final AnimatedMapController _animatedMapController;

  final List<Marker> _stadiumMarkers = [
    // Rabat — Complexe Moulay Abdellah
    Marker(
      point: LatLng(33.9599, -6.8891),
      width: 40, height: 40,
      child: const Icon(Icons.location_on, color: Colors.red, size: 36),
    ),
    // Rabat - Stade Al Barid
    Marker(
      point: LatLng(34.0052165, -6.8453562),
      width: 40,
      height: 40,
      child: const Icon(
        Icons.location_on,
        color: Colors.orange,
        size: 36,
      ),
    ),
    // Rabat — Stade Olympique (annexe)
    Marker(
      point: LatLng(33.9573, -6.8913),
      width: 40, height: 40,
      child: const Icon(Icons.location_on, color: Colors.redAccent, size: 36),
    ),
    // Rabat - Complexe Sportif Prince Héritier Moulay EL Hassan
    Marker(
      point: LatLng(33.9758, -6.8238),
      width: 40,
      height: 40,
      child: const Icon(
        Icons.location_on,
        color: Colors.orange,
        size: 36,
      ),
    ),
    // Casablanca — Mohammed V
    Marker(
      point: LatLng(33.5829, -7.6468),
      width: 40, height: 40,
      child: const Icon(Icons.location_on, color: Colors.blue, size: 36),
    ),
    // Marrakech — Grand Stade Marrakech
    Marker(
      point: LatLng(31.7067, -7.9806),
      width: 40, height: 40,
      child: const Icon(Icons.location_on, color: Colors.green, size: 36),
    ),
    // Fès — Complexe Sportif de Fès
    Marker(
      point: LatLng(34.0028, -4.9689),
      width: 40, height: 40,
      child: const Icon(Icons.location_on, color: Colors.purple, size: 36),
    ),
    // Agadir — Grand Stade d’Agadir (approx)
    Marker(
      point: LatLng(30.427214, -9.540424),
      width: 40, height: 40,
      child: const Icon(Icons.location_on, color: Colors.orange, size: 36),
    ),
    // Tanger — Grand Stade de Tanger (approx)
    Marker(
      point: LatLng(35.741211, -5.858105),
      width: 40, height: 40,
      child: const Icon(Icons.location_on, color: Colors.teal, size: 36),
    ),
    // Add more if you get reliable coordinates for Stade Al Barid, Moulay El Hassan, etc.
  ];

  @override
  void initState() {
    super.initState();
    _animatedMapController = AnimatedMapController(vsync: this);
    // Only fetch current location to show marker, but do NOT animate map on load
    _fetchCurrentLocationMarkerOnly();
  }

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
    // Notice: No animation to current location on init
  }

  void _goToMyLocation() async {
    await _fetchCurrentLocationMarkerOnly(); // Update marker just in case
    if (_currentLocation == null) return;

    _animatedMapController.animateTo(
      dest: _currentLocation!,
      zoom: 15.0,
      curve: Curves.fastOutSlowIn,
      duration: const Duration(milliseconds: 900),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        shape: const CircleBorder(),
        onPressed: _goToMyLocation,
        child: const Icon(Icons.my_location, color: Colors.blue),
      ),
      body: FlutterMap(
        mapController: _animatedMapController.mapController,
        options: MapOptions(
          initialCenter: LatLng(33.5731, -7.5898), // Default: Casablanca
          initialZoom: 5.5,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            userAgentPackageName: 'com.example.canvisit',
          ),
          MarkerLayer(
            markers: [
              // Show current location marker only
              if (_currentLocation != null)
                Marker(
                  point: _currentLocation!,
                  width: 18,
                  height: 18,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue, // inner dot
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.4),
                          blurRadius: 15,
                          spreadRadius: 5, // glow effect
                        ),
                      ],
                    ),
                    child: Center(
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white, // small white center
                        ),
                      ),
                    ),
                  ),
                ),

              ..._stadiumMarkers,
            ],
          ),
        ],
      ),
    );
  }
}