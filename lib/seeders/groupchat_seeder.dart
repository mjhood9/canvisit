import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;
final Uuid uuid = Uuid();

Future<void> seedCan2025GroupChats() async {
  // Changement d'URL pour un service de drapeaux alternatif
  const String FLAG_BASE_URL = 'https://cdn.jsdelivr.net/npm/flag-icons@7.2.3/flags/4x3/';

  final List<Map<String, String>> teams = [
    {'name': 'Maroc', 'flag_code': 'ma'},
    {'name': 'Burkina Faso', 'flag_code': 'bf'},
    {'name': 'Cameroun', 'flag_code': 'cm'},
    {'name': 'Algérie', 'flag_code': 'dz'},
    {'name': 'RD Congo', 'flag_code': 'cd'},
    {'name': 'Sénégal', 'flag_code': 'sn'},
    {'name': 'Égypte', 'flag_code': 'eg'},
    {'name': 'Angola', 'flag_code': 'ao'},
    {'name': 'Guinée équatoriale', 'flag_code': 'gq'},
    {'name': "Côte d'Ivoire", 'flag_code': 'ci'},
    {'name': 'Ouganda', 'flag_code': 'ug'},
    {'name': 'Afrique du Sud', 'flag_code': 'za'},
    {'name': 'Gabon', 'flag_code': 'ga'},
    {'name': 'Tunisie', 'flag_code': 'tn'},
    {'name': 'Nigeria', 'flag_code': 'ng'},
    {'name': 'Zambie', 'flag_code': 'zm'},
    {'name': 'Mali', 'flag_code': 'ml'},
    {'name': 'Zimbabwe', 'flag_code': 'zw'},
    {'name': 'Comores', 'flag_code': 'km'},
    {'name': 'Soudan', 'flag_code': 'sd'},
    {'name': 'Bénin', 'flag_code': 'bj'},
    {'name': 'Tanzanie', 'flag_code': 'tz'},
    {'name': 'Botswana', 'flag_code': 'bw'},
    {'name': 'Mozambique', 'flag_code': 'mz'},
  ];

  for (final team in teams) {
    final id = uuid.v4();
    final flagUrl = '$FLAG_BASE_URL${team['flag_code']}.svg'; // Construction de l'URL

    await firestore.collection('group_chats').doc(id).set({
      'id': id,
      'name': team['name'],
      'flag': flagUrl, // Utilisation de la nouvelle URL
      'users': [], // initialement vide
    }, SetOptions(merge: true));
  }

  print("✅ CAN 2025 group chats seeded successfully!");
}