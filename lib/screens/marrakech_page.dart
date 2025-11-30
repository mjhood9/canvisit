import 'package:flutter/material.dart';
import '../widgets/custom_back_appbar.dart';

class MarrakechPage extends StatefulWidget {
  const MarrakechPage({super.key});

  @override
  State<MarrakechPage> createState() => _MarrakechPageState();
}

class _MarrakechPageState extends State<MarrakechPage> {
  int selectedTab = 0; // 0 = Info (default), 1 = Stade, 2 = Activité

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomBackAppBar(title: "Marrakech"),
      body: Column(
        children: [
          const SizedBox(height: 20),

          /// ------- BUTTON ROW -------
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

          /// -------- TAB CONTENT --------
          Expanded(
            child: _buildTabContent(), // removed Center widget
          ),
        ],
      ),
    );
  }

  /// ---------------- TAB BUTTON BUILDER ----------------
  Widget _buildTabButton(String text, int index) {
    final bool isActive = selectedTab == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() => selectedTab = index);
        },
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

  /// ---------------- TAB CONTENT AREA ----------------
  Widget _buildTabContent() {
    switch (selectedTab) {
      case 0:
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ---------- IMAGE ----------
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/images/marrakech/info.jpg',
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 16),

              // ---------- TEXT ----------
              const Text(
                "Marrakech est une ville impériale du Maroc, célèbre pour sa médina, la place Jemaa el-Fna, "
                    "ses jardins et palais historiques. Elle est un centre culturel et touristique majeur, "
                    "allant des souks animés aux monuments historiques.",
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
                        child: Text("≈ 928,850"),
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
                        child: Text("≈ 230 km²"),
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

      case 1:
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ---------- IMAGE ----------
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/images/marrakech/stade.jpg',
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 16),

              // ---------- DESCRIPTION ----------
              const Text(
                "Le Grand Stade de Marrakech, inauguré en 2011, est l’un des plus "
                    "imposants stades du Maroc. Situé à environ 11 km du centre-ville, "
                    "il se distingue par son architecture moderne inspirée du style "
                    "traditionnel marocain. Le stade a accueilli de nombreux événements "
                    "nationaux et internationaux, dont des matchs de la Coupe du Monde "
                    "des Clubs FIFA.",
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
                        child: Text("Grand Stade de Marrakech"),
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
                        child: Text("Marrakech"),
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
                        child: Text("2011"),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );


      case 2:
        return const Text(
          "Activités à Marrakech",
          style: TextStyle(fontSize: 18),
        );

      default:
        return const SizedBox();
    }
  }
}
