import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/attraction_card.dart';
import '../widgets/custom_back_appbar.dart';

class RabatPage extends StatefulWidget {
  const RabatPage({super.key});

  @override
  State<RabatPage> createState() => _RabatPageState();
}

class _RabatPageState extends State<RabatPage> {
  int selectedTab = 0; // 0 = Info, 1 = Stade, 2 = Activité
  Widget _buildStadeExpansion({
    required String title,
    required String image,
    required String description,
    required List<List<String>> tableRows,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.white, width: 1)),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        backgroundColor: const Color(0xFF7A0C0F),
        collapsedBackgroundColor: const Color(0xFF7A0C0F),
        iconColor: Colors.white,
        collapsedIconColor: Colors.white,
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 18,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
        ),
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  image,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 12),
                Text(
                  description,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(fontSize: 16, height: 1.5),
                ),
                const SizedBox(height: 12),

                /// Table
                Table(
                  border: TableBorder.all(color: Colors.black26),
                  columnWidths: const {
                    0: FlexColumnWidth(1),
                    1: FlexColumnWidth(2),
                  },
                  children: tableRows
                      .map(
                        (row) => TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            row[0],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(row[1]),
                        ),
                      ],
                    ),
                  )
                      .toList(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomBackAppBar(title: "Rabat"),
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
          Expanded(child: _buildTabContent()),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // BUTTON BUILDER
  // ---------------------------------------------------------------------------
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
            border:
            isActive ? null : Border.all(color: Colors.black54, width: 1),
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

  // ---------------------------------------------------------------------------
  // TAB CONTENT SWITCHER
  // ---------------------------------------------------------------------------
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

  // ---------------------------------------------------------------------------
  // INFO TAB
  // ---------------------------------------------------------------------------
  Widget _buildInfoTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              'assets/images/rabat/info.jpg',
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "Rabat est la capitale politique du Maroc. Connue pour sa propreté, "
                "son calme et son riche patrimoine historique, elle abrite des sites "
                "emblématiques comme la Kasbah des Oudayas, la Tour Hassan et le "
                "Mausolée Mohammed V. Située au bord de l’Atlantique, Rabat offre un "
                "équilibre parfait entre tradition, administration et modernité.",
            style: TextStyle(fontSize: 16, height: 1.5),
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 24),
          Table(
            border: TableBorder.all(color: Colors.black26),
            columnWidths: const {
              0: FlexColumnWidth(1),
              1: FlexColumnWidth(2),
            },
            children: const [
              TableRow(children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child:
                  Text("Pays", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Maroc"),
                ),
              ]),
              TableRow(children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Population",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("≈ 580 000"),
                ),
              ]),
              TableRow(children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Superficie",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("≈ 117 km²"),
                ),
              ]),
              TableRow(children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Langue",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Arabe, Français"),
                ),
              ]),
              TableRow(children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Fuseau horaire",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("GMT+1"),
                ),
              ]),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // STADE TAB
  // ---------------------------------------------------------------------------
  Widget _buildStadeTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // ---------- 1. Complexe Sportif Prince Moulay Abdellah ----------
          _buildStadeExpansion(
            title: "Complexe Sportif Prince Moulay Abdellah",
            image: "assets/images/rabat/stade_abdellah.jpg",
            description:
            "Le Complexe Sportif Prince Moulay Abdellah est le plus grand stade de Rabat. "
                "Il accueille régulièrement des matches internationaux, la Coupe du Trône, "
                "ainsi que de nombreux événements sportifs et culturels. Le stade est en "
                "phase de modernisation majeure dans le cadre de la préparation de la CAN "
                "et de la Coupe du Monde 2030.",
            tableRows: const [
              ["Nom", "Complexe Sportif Prince Moulay Abdellah"],
              ["Ville", "Rabat"],
              ["Catégorie", "Stade principal"],
              ["Capacité", "69,500"],
            ],
          ),

          // ---------- 2. Stade Al Barid ----------
          _buildStadeExpansion(
            title: "Stade Al Barid",
            image: "assets/images/rabat/stade_barid.jpg",
            description:
            "Le Stade Al Barid est un stade historique de Rabat, principalement utilisé "
                "pour les entraînements et les compétitions locales. Bien qu'il soit de "
                "taille modeste, il occupe une place importante dans le sport régional.",
            tableRows: const [
              ["Nom", "Stade Al Barid"],
              ["Ville", "Rabat"],
              ["Catégorie", "Stade secondaire"],
              ["Capacité", "18,000"],
            ],
          ),

          // ---------- 3. Stade Olympique Annexe ----------
          _buildStadeExpansion(
            title: "Stade Olympique Annexe Complexe Sportif Prince Moulay Abdellah",
            image: "assets/images/rabat/stade_olympique.jpg",
            description:
            "Situé à côté du Complexe Prince Moulay Abdellah, ce stade annexe est utilisé "
                "pour les entraînements professionnels, les préparations d’avant-match et "
                "les compétitions d’athlétisme. Il dispose d’une piste rénovée et d’un "
                "terrain synthétique de qualité.",
            tableRows: const [
              ["Nom", "Stade Olympique Annexe"],
              ["Ville", "Rabat"],
              ["Catégorie", "Stade Annexe"],
              ["Capacité", "21,000"],
            ],
          ),

          // ---------- 4. Complexe Sportif Prince Héritier Moulay El Hassan ----------
          _buildStadeExpansion(
            title: "Complexe Sportif Prince Héritier Moulay El Hassan",
            image: "assets/images/rabat/stade_hassan.jpg",
            description:
            "Le Complexe Sportif Prince Héritier Moulay El Hassan est le stade officiel "
                "du FUS Rabat. Il est apprécié pour son ambiance, ses installations "
                "modernisées et son rôle majeur dans la formation des jeunes joueurs.",
            tableRows: const [
              ["Nom", "Complexe Sportif Prince Héritier Moulay El Hassan"],
              ["Ville", "Rabat"],
              ["Catégorie", "Stade du club FUS Rabat"],
              ["Capacité", "22,000"],
            ],
          ),
        ],
      ),
    );
  }
// ---------------------------------------------------------------------------
  // FIRESTORE TAB
  // ---------------------------------------------------------------------------
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
                .collection('rabat_attractions')
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
