import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/custom_appbar.dart';
import 'team_chat_page.dart';

class GroupChatPage extends StatelessWidget {
  const GroupChatPage({super.key});

  Widget _flag(String url) {
    return url.endsWith('.svg')
        ? SvgPicture.network(url, fit: BoxFit.contain)
        : Image.network(url, fit: BoxFit.contain);
  }

  void _showJoinPopup(BuildContext context, String groupId, String teamName) {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (dialogContext) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Rejoindre le groupe $teamName ?",
                style: GoogleFonts.gothicA1(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  // --- NON Button (Elevated/Outlined Style) ---
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(dialogContext),
                      style: ElevatedButton.styleFrom(
                        // 1. Background White
                        backgroundColor: Colors.white,
                        // 2. Text Dark Red (Foreground)
                        foregroundColor: const Color(0xFFB71C1C), // Dark Red
                        // 3. Border Dark Red
                        side: const BorderSide(
                          color: Color(0xFFB71C1C), // Dark Red
                          width: 1,
                        ),
                        // Inherit shape/padding from theme if not specified
                      ),
                      child: const Text("Non"),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // --- OUI Button (Elevated, White Text) ---
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          // 1. Join Group
                          await FirebaseFirestore.instance
                              .collection('group_chats')
                              .doc(groupId)
                              .update({
                            'users': FieldValue.arrayUnion([uid]),
                          });

                          // 2. Close Popup (SUCCESS)
                          Navigator.pop(dialogContext);

                        } catch (e) {
                          // 4. Handle error (FAILURE)
                          if (dialogContext.mounted) {
                            // Ensure the popup closes even on error
                            Navigator.pop(dialogContext);
                            ScaffoldMessenger.of(dialogContext).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      "Erreur: Impossible de rejoindre le groupe. $e")),
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        // 1. Text White (Foreground)
                        foregroundColor: Colors.white,
                        // The background color will be inherited from the ElevatedButtonThemeData
                        backgroundColor: const Color(0xFF7A0C0F),
                      ),
                      child: const Text("Oui"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Note: Assuming CustomAppBar is defined elsewhere or should be a standard AppBar
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Text(
            "Souhaitez-vous communiquer avec d'autres supporters ?",
            textAlign: TextAlign.center,
            style: GoogleFonts.gothicA1(
              color: const Color(0xFF7A0C0F),
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('group_chats')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final groups = snapshot.data!.docs;

                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: groups.length,
                  itemBuilder: (context, index) {
                    final g = groups[index];

                    return GestureDetector(
                      onTap: () => _showJoinPopup(context, g.id, g['name']),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 4, // Added elevation
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            /// FLAG IMAGE (Replicated City Card Style)
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(16),
                              ),
                              child: SizedBox(
                                width: double.infinity,
                                height: 120, // Set height
                                child: Padding(
                                  // Removed Padding around flag here since we want it edge-to-edge
                                  padding: const EdgeInsets.all(8), // Kept small padding for flag inside box
                                  child: _flag(g['flag']), // The flag widget handles network SVG/PNG
                                ),
                              ),
                            ),

                            const SizedBox(height: 40), // Increased spacing

                            /// GROUP NAME
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                g['name'].toUpperCase(),
                                style: GoogleFonts.gothicA1(
                                  fontSize: 16, // Matched city card font size
                                  fontWeight: FontWeight.w900, // Matched city card font weight
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}