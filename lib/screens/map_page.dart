import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../widgets/custom_appbar.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(33.5731, -7.5898), // Casablanca
          initialZoom: 5.5, // <-- use initialZoom instead of zoom
        ),
        children: [
          TileLayer(
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            userAgentPackageName: 'com.example.canvisit', // Replace with your package name
          ),
          MarkerLayer(
            markers: [
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
