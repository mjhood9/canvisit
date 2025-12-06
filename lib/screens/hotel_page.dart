import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';
import '../services/hotel_service.dart';
import '../models/hotel_model.dart';
import '../widgets/custom_appbar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class HotelPage extends StatefulWidget {
  const HotelPage({super.key});

  @override
  State<HotelPage> createState() => _HotelPageState();
}

class _HotelPageState extends State<HotelPage> with SingleTickerProviderStateMixin {
  final HotelService _hotelService = HotelService();
  final TextEditingController _searchController = TextEditingController();
  final MapController _mapController = MapController();

  List<Hotel> _hotels = [];
  bool _isLoading = false;
  String? _errorMessage;
  Hotel? _selectedHotel;

  LatLng _currentCenter = LatLng(33.5731, -7.5898);
  double _currentZoom = 13;

  bool _isMapView = true;
  late TabController _tabController;

  bool _mapReady = false;

  LatLng? _currentLocation;
  List<LatLng> _routePoints = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() => _isMapView = _tabController.index == 0);
    });

    _searchHotels('Casablanca');
  }

  Future<void> _searchHotels(String city) async {
    if (city.trim().isEmpty) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _selectedHotel = null;
      _routePoints.clear();
    });

    try {
      final hotels = await _hotelService.searchHotelsByCity(city);

      if (hotels.isNotEmpty) {
        final coords = await _hotelService.getCityCoordinates(city);
        if (coords != null) {
          setState(() {
            _currentCenter = coords;
            _currentZoom = 13;
          });

          if (_isMapView && _mapReady) {
            _mapController.move(_currentCenter, _currentZoom);
          }
        }
      }

      setState(() {
        _hotels = hotels;
        _isLoading = false;
      });

      if (hotels.isEmpty) {
        setState(() {
          _errorMessage = 'Aucun hôtel trouvé pour "$city"';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  void _onHotelTap(Hotel hotel) {
    setState(() {
      _selectedHotel = hotel;
      _routePoints.clear(); // clear previous route
    });

    if (_isMapView && _mapReady) {
      _mapController.move(hotel.location, 16);
    }

    _showHotelBottomSheet(hotel);
  }

  void _showHotelBottomSheet(Hotel hotel) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        builder: (context, scrollController) => Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10)],
          ),
          child: ListView(
            controller: scrollController,
            padding: const EdgeInsets.all(20),
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      hotel.name,
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  if (hotel.stars.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.amber.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        hotel.stars,
                        style: TextStyle(color: Colors.amber.shade900, fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(),
              _buildInfoRow(Icons.location_on, hotel.address, Colors.red.shade400),
              if (hotel.phone != null) ...[
                const SizedBox(height: 12),
                _buildInfoRow(Icons.phone, hotel.phone!, Colors.green.shade400),
              ],
              if (hotel.website != null) ...[
                const SizedBox(height: 12),
                InkWell(
                  onTap: () => _launchUrl(hotel.website!),
                  child: _buildInfoRow(Icons.language, hotel.website!, Colors.blue.shade400, isLink: true),
                ),
              ],
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.blue.shade50, Colors.blue.shade100]),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Gamme de prix : ', style: TextStyle(fontSize: 15)),
                    Text(
                      '€' * hotel.priceLevel,
                      style: TextStyle(color: Colors.blue.shade700, fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ],
                ),
              ),
              if (hotel.description != null) ...[
                const SizedBox(height: 16),
                const Text('Description', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(hotel.description!, style: TextStyle(color: Colors.grey.shade700)),
              ],
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _drawRouteToHotel(hotel),
                      icon: const Icon(Icons.directions),
                      label: const Text('Itinéraire'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade600,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                  if (hotel.phone != null) ...[
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => _callHotel(hotel.phone!),
                        icon: const Icon(Icons.phone),
                        label: const Text('Appeler'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text, Color color, {bool isLink = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 22),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 15,
              color: isLink ? Colors.blue : Colors.grey.shade800,
              decoration: isLink ? TextDecoration.underline : null,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _openInMaps(LatLng location) async {
    final url = Uri.parse(
      'https://www.openstreetmap.org/?mlat=${location.latitude}&mlon=${location.longitude}#map=16/${location.latitude}/${location.longitude}',
    );
    if (await canLaunchUrl(url)) await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  Future<void> _callHotel(String phone) async {
    final url = Uri.parse('tel:${phone.replaceAll(' ', '')}');
    if (await canLaunchUrl(url)) await launchUrl(url);
  }

  Future<void> _launchUrl(String urlString) async {
    final url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  // ---------------- Current Location ----------------
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
    await _fetchCurrentLocationMarkerOnly();
    if (_currentLocation == null) return;
    _mapController.move(_currentLocation!, 15.0);
  }

  Future<void> _drawRouteToHotel(Hotel hotel) async {
    if (_currentLocation == null) return;

    // Switch to Map tab
    _tabController.animateTo(0);

    // Close bottom sheet if open
    Navigator.of(context).maybePop();

    final apiKey = 'eyJvcmciOiI1YjNjZTM1OTc4NTExMTAwMDFjZjYyNDgiLCJpZCI6IjIxM2JjYjgzNGFkNjQ0ZGJhMzExNWUwOTMyYmE0ODc2IiwiaCI6Im11cm11cjY0In0=';
    final url = Uri.parse(
        'https://api.openrouteservice.org/v2/directions/driving-car?api_key=$apiKey'
            '&start=${_currentLocation!.longitude},${_currentLocation!.latitude}'
            '&end=${hotel.location.longitude},${hotel.location.latitude}');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final coordinates = data['features'][0]['geometry']['coordinates'] as List;

      // Convert [lng, lat] to LatLng
      _routePoints = coordinates
          .map((point) => LatLng(point[1] as double, point[0] as double))
          .toList();

      // Move map to fit all route points
      _moveMapToBounds(_routePoints);

      // Select hotel marker
      setState(() {
        _selectedHotel = hotel;
      });
    } else {
      print('Failed to fetch route: ${response.body}');
    }
  }


// Helper function to center & zoom map to fit points
  void _moveMapToBounds(List<LatLng> points) {
    if (points.isEmpty) return;

    double minLat = points.map((p) => p.latitude).reduce((a, b) => a < b ? a : b);
    double maxLat = points.map((p) => p.latitude).reduce((a, b) => a > b ? a : b);
    double minLng = points.map((p) => p.longitude).reduce((a, b) => a < b ? a : b);
    double maxLng = points.map((p) => p.longitude).reduce((a, b) => a > b ? a : b);

    final centerLat = (minLat + maxLat) / 2;
    final centerLng = (minLng + maxLng) / 2;

    final latDiff = maxLat - minLat;
    final lngDiff = maxLng - minLng;

    // Approximate zoom level based on diff
    double zoom = 13 - (latDiff + lngDiff) * 5; // tweak factor for best fit
    if (zoom > 18) zoom = 18;
    if (zoom < 5) zoom = 5;

    _mapController.move(LatLng(centerLat, centerLng), zoom);
  }
  Widget _buildMapView() {
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        minZoom: 5,
        maxZoom: 18,
        onMapReady: () {
          setState(() => _mapReady = true);
          // Move to initial center and zoom after map is ready
          _mapController.move(_currentCenter, _currentZoom);
        },
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.hotel_finder',
        ),
        if (_routePoints.isNotEmpty)
          PolylineLayer(
            polylines: [
              Polyline(
                points: _routePoints,
                color: Colors.blue,
                strokeWidth: 4,
              ),
            ],
          ),
        MarkerLayer(
          markers: [
            if (_currentLocation != null)
              Marker(
                point: _currentLocation!,
                width: 18,
                height: 18,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                    boxShadow: [BoxShadow(color: Colors.blue.withOpacity(0.4), blurRadius: 15, spreadRadius: 5)],
                  ),
                  child: Center(
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ..._hotels.map((hotel) {
              final isSelected = _selectedHotel?.id == hotel.id;
              return Marker(
                point: hotel.location,
                width: isSelected ? 50 : 40,
                height: isSelected ? 50 : 40,
                child: GestureDetector(
                  onTap: () => _onHotelTap(hotel),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.red : Colors.blue,
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 6, offset: const Offset(0, 3))],
                    ),
                    child: Icon(Icons.hotel, color: Colors.white, size: isSelected ? 28 : 24),
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ],
    );
  }


  Widget _buildListView() {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: _hotels.length,
      itemBuilder: (context, index) {
        final hotel = _hotels[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: InkWell(
            onTap: () => _onHotelTap(hotel),
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12)),
                        child: Icon(Icons.hotel, color: Colors.blue.shade600, size: 28),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              hotel.name,
                              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (hotel.stars.isNotEmpty) ...[
                              const SizedBox(height: 4),
                              Text(hotel.stars, style: TextStyle(color: Colors.amber.shade700, fontSize: 14)),
                            ],
                          ],
                        ),
                      ),
                      Icon(Icons.chevron_right, color: Colors.grey.shade400),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 16, color: Colors.grey.shade600),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(hotel.address, style: TextStyle(color: Colors.grey.shade700, fontSize: 14), maxLines: 1, overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                  if (hotel.phone != null) ...[
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.phone, size: 16, color: Colors.grey.shade600),
                        const SizedBox(width: 4),
                        Text(hotel.phone!, style: TextStyle(color: Colors.grey.shade700, fontSize: 14)),
                      ],
                    ),
                  ],
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
                    child: Text('Prix : ${'€' * hotel.priceLevel}', style: TextStyle(color: Colors.blue.shade700, fontWeight: FontWeight.w600, fontSize: 13)),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(tabController: _tabController),
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF7A0C0F),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8, offset: const Offset(0, 2))],
                ),
                child: TextField(
                  controller: _searchController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Rechercher une ville...',
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                    prefixIcon: const Icon(Icons.search, color: Colors.white),
                    suffixIcon: _isLoading
                        ? const Padding(
                      padding: EdgeInsets.all(12),
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                      ),
                    )
                        : IconButton(icon: const Icon(Icons.send, color: Colors.white), onPressed: () => _searchHotels(_searchController.text)),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.2),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
                  ),
                  onSubmitted: _searchHotels,
                ),
              ),
              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _errorMessage != null
                    ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline, size: 64, color: Colors.orange.shade300),
                        const SizedBox(height: 16),
                        Text(_errorMessage!, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: () => _searchHotels(_searchController.text.isEmpty ? 'Casablanca' : _searchController.text),
                          icon: const Icon(Icons.refresh),
                          label: const Text('Réessayer'),
                        ),
                      ],
                    ),
                  ),
                )
                    : _hotels.isEmpty
                    ? const Center(child: Text('Aucun hôtel trouvé', style: TextStyle(fontSize: 16, color: Colors.grey)))
                    : TabBarView(controller: _tabController, children: [_buildMapView(), _buildListView()]),
              ),
            ],
          ),
          if (_hotels.isNotEmpty && !_isLoading && _isMapView)
            Positioned(
              bottom: 20,
              left: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.blue.shade700,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 8)],
                ),
                child: Text('${_hotels.length} hôtel${_hotels.length > 1 ? 's' : ''}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        shape: const CircleBorder(),
        onPressed: _goToMyLocation,
        child: const Icon(Icons.my_location, color: Colors.blue),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }
}
