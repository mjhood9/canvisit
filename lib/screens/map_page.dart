import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import '../widgets/custom_appbar.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  LatLng? _currentLocation;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    if (permission == LocationPermission.deniedForever) {
      return; // Permissions are permanently denied
    }

    final position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: _currentLocation ?? LatLng(33.5731, -7.5898), // fallback: Casablanca
          initialZoom: 5.5,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            userAgentPackageName: 'com.example.canvisit',
          ),
          MarkerLayer(
            markers: [
              // Current location marker
              if (_currentLocation != null)
                Marker(
                  point: _currentLocation!,
                  width: 40,
                  height: 40,
                  child: const Icon(
                    Icons.my_location,
                    color: Colors.red,
                    size: 36,
                  ),
                ),

              // Other city markers
              Marker(
                point: LatLng(33.5731, -7.5898), // Casablanca
                width: 40,
                height: 40,
                child: const Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 36,
                ),
              ),
              Marker(
                point: LatLng(34.020882, -6.841650), // Rabat
                width: 40,
                height: 40,
                child: const Icon(
                  Icons.location_on,
                  color: Colors.blue,
                  size: 36,
                ),
              ),
              Marker(
                point: LatLng(31.6295, -7.9811), // Marrakech
                width: 40,
                height: 40,
                child: const Icon(
                  Icons.location_on,
                  color: Colors.green,
                  size: 36,
                ),
              ),
              Marker(
                point: LatLng(35.7595, -5.83395), // Tangier
                width: 40,
                height: 40,
                child: const Icon(
                  Icons.location_on,
                  color: Colors.orange,
                  size: 36,
                ),
              ),
              Marker(
                point: LatLng(34.0333, -5.0000), // Fes
                width: 40,
                height: 40,
                child: const Icon(
                  Icons.location_on,
                  color: Colors.purple,
                  size: 36,
                ),
              ),
              Marker(
                point: LatLng(30.4278, -9.5981), // Agadir
                width: 40,
                height: 40,
                child: const Icon(
                  Icons.location_on,
                  color: Colors.teal,
                  size: 36,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
