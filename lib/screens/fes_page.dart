import 'package:flutter/material.dart';
import '../widgets/custom_back_appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/attraction_card.dart';

class FesPage extends StatefulWidget {
  const FesPage({super.key});

  @override
  State<FesPage> createState() => _FesPageState();
}

class _FesPageState extends State<FesPage> {
  int selectedTab = 0; // 0 = Info, 1 = Stade, 2 = Activité

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomBackAppBar(title: "Fes"),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _buildTabButton("Info", 0),
                const SizedBox(width: 10),
                _buildTabButton("Stade", 1),
                const SizedBox(width: 10),
                _buildTabButton("Activité", 2),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: _buildTabContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String text, int index) {
    final bool isActive = selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedTab = index),
        child: Container(
          height: 45,
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF7A0C0F) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: isActive
                ? null
                : Border.all(color: Colors.black54, width: 1),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.black87,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (selectedTab) {
      case 0:
        return _buildInfoTab();
      case 1:
        return _buildStadeTab();
      case 2:
        return _buildFirestoreTab();
      default:
        return const SizedBox();
    }
  }

  Widget _buildInfoTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ---------- IMAGE ----------
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              'assets/images/fes/info.jpg',
              height: 200,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height: 16),

          // ---------- TEXT ----------
          const Text(
            "Fès est l'une des villes impériales du Maroc, célèbre pour sa médina médiévale, ses mosquées historiques et ses artisanats traditionnels. "
                "C'est un centre culturel et spirituel majeur, avec un mélange unique d'histoire, d'architecture et de traditions.",
            style: TextStyle(fontSize: 16, height: 1.5),
            textAlign: TextAlign.justify,
          ),

          const SizedBox(height: 24),

          // ---------- TABLE ----------
          Table(
            border: TableBorder.all(color: Colors.black26),
            columnWidths: const {
              0: FlexColumnWidth(1),
              1: FlexColumnWidth(2),
            },
            children: const [
              TableRow(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Pays", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Maroc"),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Population", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("≈ 1,112,000"),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Superficie", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("≈ 306 km²"),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Langue", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Arabe, Français"),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Fuseau horaire", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("GMT+1"),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStadeTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ---------- IMAGE ----------
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              'assets/images/fes/stade.jpg',
              height: 200,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height: 16),

          // ---------- DESCRIPTION ----------
          const Text(
            "Le Complexe Sportif de Fès est l’une des plus grandes installations "
                "sportives de la région. Construit pour répondre aux normes "
                "internationales, il accueille principalement les matchs du MAS Fès "
                "(Maghreb Association Sportive de Fès). Le stade est également utilisé "
                "pour divers événements sportifs et culturels tout au long de l'année.",
            style: TextStyle(fontSize: 16, height: 1.5),
            textAlign: TextAlign.justify,
          ),

          const SizedBox(height: 24),

          // ---------- TABLE ----------
          Table(
            border: TableBorder.all(color: Colors.black26),
            columnWidths: const {
              0: FlexColumnWidth(1),
              1: FlexColumnWidth(2),
            },
            children: const [
              TableRow(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Nom", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Complexe Sportif de Fès"),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Ville", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Fès"),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Capacité", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("≈ 45 000 places"),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Inauguration", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("2003"),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFirestoreTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFirestoreSection("Top Attractions", "attraction"),
          const SizedBox(height: 25),
          _buildFirestoreSection("Restaurants", "restaurant"),
          const SizedBox(height: 25),
          _buildFirestoreSection("Activities", "activity"),
        ],
      ),
    );
  }

  Widget _buildFirestoreSection(String title, String category) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        SizedBox(
          height: 220,
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('fes_attractions')
                .where('category', isEqualTo: category)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Erreur: ${snapshot.error}'));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              final data = snapshot.data!.docs;

              if (data.isEmpty) {
                return const Center(child: Text('Aucun élément trouvé'));
              }

              return ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: data.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final item = data[index].data()! as Map<String, dynamic>;
                  return AttractionCard(
                    name: item['name'] ?? '',
                    imagePath: item['imagePath'] ?? '',
                    details: item['details'] ?? '',
                    googleMapsUrl: item['googleMapsUrl'] ?? '',
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
