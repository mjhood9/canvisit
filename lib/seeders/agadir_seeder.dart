import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/attraction_model.dart';
import 'package:uuid/uuid.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;
final Uuid uuid = Uuid();

Future<void> seedAgadirAttractions() async {
  final List<Attraction> attractions = [
    // ---------------- TOP ATTRACTIONS ----------------
    Attraction(
      id: uuid.v4(),
      name: "Kasbah d’Agadir Oufella",
      category: "attraction",
      imagePath: "assets/images/agadir/kasbah.jpg",
      details:
      "Ancienne forteresse historique dominant Agadir avec une vue panoramique exceptionnelle.",
      googleMapsUrl: "https://maps.app.goo.gl/B66ZUrF6KTXbNFPW9",
    ),
    Attraction(
      id: uuid.v4(),
      name: "Vallée des Oiseaux",
      category: "attraction",
      imagePath: "assets/images/agadir/vallee_oiseaux.jpg",
      details:
      "Parc zoologique et jardin en plein cœur d’Agadir, idéal pour les familles.",
      googleMapsUrl: "https://maps.app.goo.gl/L86kdNfkiRvMVBEx7",
    ),
    Attraction(
      id: uuid.v4(),
      name: "Marina d’Agadir",
      category: "attraction",
      imagePath: "assets/images/agadir/marina.jpg",
      details:
      "Zone touristique moderne avec restaurants, boutiques et yachts.",
      googleMapsUrl: "https://maps.app.goo.gl/oGJDrE3ijfkEVGBh8",
    ),
    Attraction(
      id: uuid.v4(),
      name: "Souk El Had",
      category: "attraction",
      imagePath: "assets/images/agadir/souk_el_had.jpg",
      details:
      "Le plus grand marché du sud du Maroc, parfait pour découvrir l'artisanat.",
      googleMapsUrl: "https://maps.app.goo.gl/HEker9U88iFKLvTb8",
    ),
    Attraction(
      id: uuid.v4(),
      name: "Crocoparc",
      category: "attraction",
      imagePath: "assets/images/agadir/crocoparc.jpg",
      details:
      "Parc impressionnant regroupant plus de 300 crocodiles du Nil.",
      googleMapsUrl: "https://maps.app.goo.gl/ssEyBEp7SfEUTArL8",
    ),

    // ---------------- RESTAURANTS ----------------
    Attraction(
      id: uuid.v4(),
      name: "Pure Passion",
      category: "restaurant",
      imagePath: "assets/images/agadir/pure_passion.jpg",
      details:
      "Restaurant chic à la Marina avec cuisine raffinée et ambiance romantique.",
      googleMapsUrl: "https://maps.app.goo.gl/RT2ynhNxuMRdHrBV8",
    ),
    Attraction(
      id: uuid.v4(),
      name: "La Scala",
      category: "restaurant",
      imagePath: "assets/images/agadir/la_scala.jpg",
      details:
      "Cuisine marocaine traditionnelle dans un cadre authentique et chaleureux.",
      googleMapsUrl: "https://maps.app.goo.gl/Z3L1LxzEUiSTkfbp8",
    ),
    Attraction(
      id: uuid.v4(),
      name: "Le Jardin d’Eau",
      category: "restaurant",
      imagePath: "assets/images/agadir/jardin_eau.jpg",
      details:
      "Restaurant populaire offrant cuisine marocaine et internationale.",
      googleMapsUrl: "https://maps.app.goo.gl/46ae8YQEs1jAvc3f6",
    ),
    Attraction(
      id: uuid.v4(),
      name: "Les Blancs",
      category: "restaurant",
      imagePath: "assets/images/agadir/les_blancs.jpg",
      details:
      "Restaurant spécialisé en poissons et tapas avec vue sur mer.",
      googleMapsUrl: "https://maps.app.goo.gl/XL4PPGnbYfhSdu6L7",
    ),
    Attraction(
      id: uuid.v4(),
      name: "Ô Playa",
      category: "restaurant",
      imagePath: "assets/images/agadir/oplaya.jpg",
      details:
      "Restaurant de plage avec ambiance moderne et plats méditerranéens.",
      googleMapsUrl: "https://maps.app.goo.gl/UGQQm8sxgj4iahsu8",
    ),

    // ---------------- ACTIVITIES ----------------
    Attraction(
      id: uuid.v4(),
      name: "Surf à Taghazout",
      category: "activity",
      imagePath: "assets/images/agadir/taghazout.jpg",
      details:
      "Village côtier connu mondialement pour son surf et son ambiance décontractée.",
      googleMapsUrl: "https://maps.app.goo.gl/BHuPUHmN4sxJ8NZz5",
    ),
    Attraction(
      id: uuid.v4(),
      name: "Promenade de la Corniche",
      category: "activity",
      imagePath: "assets/images/agadir/corniche.jpg",
      details:
      "Parfait pour marcher, faire du vélo ou profiter de l’ambiance balnéaire.",
      googleMapsUrl: "https://maps.app.goo.gl/afBADwjffL2Tr9dG8",
    ),
    Attraction(
      id: uuid.v4(),
      name: "Excursion dans le désert de Timlalin",
      category: "activity",
      imagePath: "assets/images/agadir/timlalin.jpg",
      details:
      "Sables dorés et dunes magnifiques, idéal pour des balades en quad.",
      googleMapsUrl: "https://maps.app.goo.gl/nKu3NWRvc2HAUYEX7",
    ),
    Attraction(
      id: uuid.v4(),
      name: "Agadir Dolphin World",
      category: "activity",
      imagePath: "assets/images/agadir/dolphin_world.jpg",
      details:
      "Spectacles de dauphins, attractions familiales et animaux marins.",
      googleMapsUrl: "https://maps.app.goo.gl/xy5qiCRivmMHKcay8",
    ),
    Attraction(
      id: uuid.v4(),
      name: "Trek dans le Parc National du Souss Massa",
      category: "activity",
      imagePath: "assets/images/agadir/souss_massa.jpg",
      details:
      "Réserve naturelle extraordinaire avec paysages sauvages et animaux rares.",
      googleMapsUrl: "https://maps.app.goo.gl/ot1skX64aeaiComS8",
    ),
  ];

  for (final attraction in attractions) {
    await firestore
        .collection('agadir_attractions')
        .doc(attraction.id)
        .set(attraction.toMap(), SetOptions(merge: true));
  }

  print("Agadir attractions seeded successfully!");
}
