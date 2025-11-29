import 'package:flutter/material.dart';
import '../widgets/custom_back_appbar.dart';

class FesPage extends StatefulWidget {
  const FesPage({super.key});

  @override
  State<FesPage> createState() => _FesPageState();
}

class _FesPageState extends State<FesPage> {
  int selectedTab = 0; // 0 = Info (default), 1 = Stade, 2 = Activité

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomBackAppBar(title: "Fes"),
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
            child: Center(
              child: _buildTabContent(),
            ),
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

      case 1:
        return const Text(
          "Stades à Fes",
          style: TextStyle(fontSize: 18),
        );

      case 2:
        return const Text(
          "Activités à Fes",
          style: TextStyle(fontSize: 18),
        );

      default:
        return const SizedBox();
    }
  }
}
