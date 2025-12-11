// lib/seeders/rabat_seeder.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/attraction_model.dart';
import 'package:uuid/uuid.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;
final Uuid uuid = Uuid();

Future<void> seedRabatAttractions() async {
  final List<Attraction> attractions = [
    // ---------------- TOP ATTRACTIONS ----------------
    Attraction(
      id: uuid.v4(),
      name: "Tour Hassan",
      category: "attraction",
      imagePath: "assets/images/rabat/tour_hassan.jpg",
      details: "Minaret inachevé d’une mosquée du XIIe siècle, célèbre symbole de Rabat.",
      googleMapsUrl: "https://maps.app.goo.gl/ietYkBg3kcRLFUJG7",
    ),
    Attraction(
      id: uuid.v4(),
      name: "Kasbah des Oudayas",
      category: "attraction",
      imagePath: "assets/images/rabat/kasbah_oudayas.jpg",
      details: "Ancienne forteresse avec jardins andalous et vue sur l’océan Atlantique.",
      googleMapsUrl: "https://maps.app.goo.gl/gB4U9RuHNhxZ2dQF6",
    ),
    Attraction(
      id: uuid.v4(),
      name: "Chellah",
      category: "attraction",
      imagePath: "assets/images/rabat/chellah.jpg",
      details: "Site historique avec ruines médiévales et nécropole mérinide.",
      googleMapsUrl: "https://maps.app.goo.gl/5CfvG6hEAuuXcomb7",
    ),
    Attraction(
      id: uuid.v4(),
      name: "Mausolée Mohammed V",
      category: "attraction",
      imagePath: "assets/images/rabat/mausolee_mohammed_v.jpg",
      details: "Magnifique mausolée abritant le roi Mohammed V et Hassan II.",
      googleMapsUrl: "https://maps.app.goo.gl/pcnMnUGLePfc2d37A",
    ),
    Attraction(
      id: uuid.v4(),
      name: "Jardin d’Essais",
      category: "attraction",
      imagePath: "assets/images/rabat/jardin_essais.jpg",
      details: "Parc botanique avec une grande variété de plantes et d’arbres.",
      googleMapsUrl: "https://maps.app.goo.gl/hj2p4iGr44MVMk699",
    ),

    // ---------------- RESTAURANTS ----------------
    Attraction(
      id: uuid.v4(),
      name: "Dar Naji",
      category: "restaurant",
      imagePath: "assets/images/rabat/dar_naji.jpg",
      details: "Cuisine traditionnelle marocaine dans une ambiance conviviale.",
      googleMapsUrl: "https://maps.app.goo.gl/LfFxEXJJVn4waRcQ6",
    ),
    Attraction(
      id: uuid.v4(),
      name: "Le Dhow",
      category: "restaurant",
      imagePath: "assets/images/rabat/le_dhow.jpg",
      details: "Restaurant sur un bateau avec plats internationaux et vue sur le Bouregreg.",
      googleMapsUrl: "https://maps.app.goo.gl/NGwwvaWN8aNtYyqE6",
    ),
    Attraction(
      id: uuid.v4(),
      name: "Egiodola Rabat",
      category: "restaurant",
      imagePath: "assets/images/rabat/egiodola.jpg",
      details: " Restaurant chic et moderne situé à Hay Riad, connu pour son cadre élégant, une ambiance branchée et une cuisine fusion française/internationale raffinée avec des produits frais, notamment des viandes maturées et des cocktails créatifs, offrant une expérience culinaire haut de gamme avec un service attentionné et des portions généreuses, idéal pour une sortie spéciale.",
      googleMapsUrl: "https://goo.gl/maps/8vH3K2p6g2P2",
    ),
    Attraction(
      id: uuid.v4(),
      name: "La Grillardière",
      category: "restaurant",
      imagePath: "assets/images/rabat/la_grillardiere.jpg",
      details: "Spécialités de viandes et grillades dans une atmosphère chaleureuse.",
      googleMapsUrl: "https://maps.app.goo.gl/BBB4rGxTWgopn7Tr6",
    ),
    Attraction(
      id: uuid.v4(),
      name: "Ty Potes",
      category: "restaurant",
      imagePath: "assets/images/rabat/ty_potes.jpg",
      details: "Petit restaurant branché avec plats marocains revisités.",
      googleMapsUrl: "https://maps.app.goo.gl/o2p7zSAttaNSMSk28",
    ),

    // ---------------- ACTIVITIES ----------------
    Attraction(
      id: uuid.v4(),
      name: "Plage de Rabat",
      category: "activity",
      imagePath: "assets/images/rabat/plage_rabat.jpg",
      details: "Plage pour se détendre, faire du surf ou des promenades au bord de l’océan.",
      googleMapsUrl: "https://maps.app.goo.gl/5cP2vSQ3ZhR11cve7",
    ),
    Attraction(
      id: uuid.v4(),
      name: "Musée Mohammed VI",
      category: "activity",
      imagePath: "assets/images/rabat/musee_mohammed_vi.jpg",
      details: "Musée d’art moderne et contemporain avec exposition permanente.",
      googleMapsUrl: "https://maps.app.goo.gl/sg4iuhy7BdgwnWry8",
    ),
    Attraction(
      id: uuid.v4(),
      name: "Balade Bouregreg",
      category: "activity",
      imagePath: "assets/images/rabat/bouregreg.jpg",
      details: "Promenade le long du fleuve Bouregreg avec vues panoramiques.",
      googleMapsUrl: "https://maps.app.goo.gl/1zQRBygn9zX1n18s7",
    ),
    Attraction(
      id: uuid.v4(),
      name: "Hassan Tower Night Tour",
      category: "activity",
      imagePath: "assets/images/rabat/tour_hassan.jpg",
      details: "Visite nocturne de la Tour Hassan illuminée et ses alentours.",
      googleMapsUrl: "https://maps.app.goo.gl/ietYkBg3kcRLFUJG7",
    ),
    Attraction(
      id: uuid.v4(),
      name: "Jardins Exotiques",
      category: "activity",
      imagePath: "assets/images/rabat/jardins_exotiques.jpg",
      details: "Parcs et jardins pour découvrir la flore locale et se détendre.",
      googleMapsUrl: "https://maps.app.goo.gl/Qn1pYq2EehMXpbud9",
    ),
  ];

  for (final attraction in attractions) {
    await firestore
        .collection('rabat_attractions')
        .doc(attraction.id)
        .set(attraction.toMap());
  }

  print("Rabat attractions seeded successfully!");
}
