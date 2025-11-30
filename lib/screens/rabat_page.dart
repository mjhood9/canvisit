import 'package:flutter/material.dart';
import '../widgets/custom_back_appbar.dart';

class RabatPage extends StatefulWidget {
  const RabatPage({super.key});

  @override
  State<RabatPage> createState() => _RabatPageState();
}

class _RabatPageState extends State<RabatPage> {
  int selectedTab = 0; // 0 = Info (default), 1 = Stade, 2 = Activité

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomBackAppBar(title: "Rabat"),
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
                  'assets/images/rabat/info.jpg',
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 16),

              // ---------- TEXT ----------
              const Text(
                "Rabat est la capitale du Maroc et siège du gouvernement. "
                    "Située sur la côte atlantique, elle combine modernité et héritage historique avec sa médina, "
                    "la Kasbah des Oudayas et la Tour Hassan. La ville est connue pour ses institutions politiques, "
                    "universités, et événements culturels. Rabat offre un cadre paisible tout en restant un centre administratif et culturel majeur du pays.",
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
                        child: Text("≈ 580,000"),
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
                        child: Text("≈ 117 km²"),
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
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // ---------- 1. Complexe Sportif Prince Moulay Abdellah ----------
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.white, width: 1),
                  ),
                ),
                child: ExpansionTile(
                  tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  backgroundColor: const Color(0xFF7A0C0F),                     // content background
                  collapsedBackgroundColor: const Color(0xFF7A0C0F), // header background
                  iconColor: Colors.white,                           // arrow expanded
                  collapsedIconColor: Colors.white,                 // arrow collapsed
                  title: const Text(
                    "Complexe Sportif Prince Moulay Abdellah",
                    style: TextStyle(
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
                            "assets/images/rabat/stade_abdellah.jpg",
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            "Le Complexe Sportif Prince Moulay Abdellah est le plus grand stade de Rabat. "
                                "Il accueille régulièrement des matches internationaux, la Coupe du Trône, "
                                "ainsi que de nombreux événements sportifs et culturels. Le stade est en "
                                "phase de modernisation majeure dans le cadre de la préparation de la CAN "
                                "et de la Coupe du Monde 2030.",
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontSize: 16, height: 1.5),
                          ),
                          const SizedBox(height: 12),
                          Table(
                            border: TableBorder.all(color: Colors.black26),
                            columnWidths: const {0: FlexColumnWidth(1), 1: FlexColumnWidth(2)},
                            children: const [
                              TableRow(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text("Nom", style: TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text("Complexe Sportif Prince Moulay Abdellah"),
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
                                    child: Text("Rabat"),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text("Catégorie", style: TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text("Stade principal"),
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
                                    child: Text("69,500"),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // ---------- 2. Stade Al Barid ----------
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.white, width: 1),
                  ),
                ),
                child: ExpansionTile(
                  tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  backgroundColor: const Color(0xFF7A0C0F),
                  collapsedBackgroundColor: const Color(0xFF7A0C0F),
                  iconColor: Colors.white,
                  collapsedIconColor: Colors.white,
                  title: const Text(
                    "Stade Al Barid",
                    style: TextStyle(
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
                            "assets/images/rabat/stade_barid.jpg",
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            "Le Stade Al Barid est un stade historique de Rabat, principalement utilisé "
                                "pour les entraînements et les compétitions locales. Bien qu'il soit de "
                                "taille modeste, il occupe une place importante dans le sport régional.",
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontSize: 16, height: 1.5),
                          ),
                          const SizedBox(height: 12),
                          Table(
                            border: TableBorder.all(color: Colors.black26),
                            columnWidths: const {0: FlexColumnWidth(1), 1: FlexColumnWidth(2)},
                            children: const [
                              TableRow(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text("Nom", style: TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text("Stade Al Barid"),
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
                                    child: Text("Rabat"),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text("Catégorie", style: TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text("Stade secondaire"),
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
                                    child: Text("18,000"),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // ---------- 3. Stade Olympique Annexe ----------
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.white, width: 1),
                  ),
                ),
                child: ExpansionTile(
                  tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  backgroundColor: const Color(0xFF7A0C0F),
                  collapsedBackgroundColor: const Color(0xFF7A0C0F),
                  iconColor: Colors.white,
                  collapsedIconColor: Colors.white,
                  title: const Text(
                    "Stade Olympique Annexe Complexe Sportif Prince Moulay Abdellah",
                    style: TextStyle(
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
                            "assets/images/rabat/stade_olympique.jpg",
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            "Situé à côté du Complexe Prince Moulay Abdellah, ce stade annexe est utilisé "
                                "pour les entraînements professionnels, les préparations d’avant-match et "
                                "les compétitions d’athlétisme. Il dispose d’une piste rénovée et d’un "
                                "terrain synthétique de qualité.",
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontSize: 16, height: 1.5),
                          ),
                          const SizedBox(height: 12),
                          Table(
                            border: TableBorder.all(color: Colors.black26),
                            columnWidths: const {0: FlexColumnWidth(1), 1: FlexColumnWidth(2)},
                            children: const [
                              TableRow(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text("Nom", style: TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text("Stade Olympique Annexe"),
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
                                    child: Text("Rabat"),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text("Catégorie", style: TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text("Stade Annexe"),
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
                                    child: Text("21,000"),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // ---------- 4. Complexe Sportif Prince Héritier Moulay El Hassan ----------
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.white, width: 1),
                  ),
                ),
                child: ExpansionTile(
                  tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  backgroundColor: const Color(0xFF7A0C0F),
                  collapsedBackgroundColor: const Color(0xFF7A0C0F),
                  iconColor: Colors.white,
                  collapsedIconColor: Colors.white,
                  title: const Text(
                    "Complexe Sportif Prince Héritier Moulay El Hassan",
                    style: TextStyle(
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
                            "assets/images/rabat/stade_hassan.jpg",
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            "Le Complexe Sportif Prince Héritier Moulay El Hassan est le stade officiel "
                                "du FUS Rabat. Il est apprécié pour son ambiance, ses installations "
                                "modernisées et son rôle majeur dans la formation des jeunes joueurs.",
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontSize: 16, height: 1.5),
                          ),
                          const SizedBox(height: 12),
                          Table(
                            border: TableBorder.all(color: Colors.black26),
                            columnWidths: const {0: FlexColumnWidth(1), 1: FlexColumnWidth(2)},
                            children: const [
                              TableRow(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text("Nom", style: TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text("Complexe Sportif Prince Héritier Moulay El Hassan"),
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
                                    child: Text("Rabat"),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text("Catégorie", style: TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text("Stade du club FUS Rabat"),
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
                                    child: Text("22,000"),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );

      case 2:
        return const Text(
          "Activités à Rabat",
          style: TextStyle(fontSize: 18),
        );

      default:
        return const SizedBox();
    }
  }
}
