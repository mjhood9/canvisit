import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'group_chat_page.dart';
import 'team_chat_page.dart';

class GroupChatEntryPage extends StatelessWidget {
  const GroupChatEntryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('group_chats')
          .where('users', arrayContains: uid)
          .limit(1)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // 👤 User already in a group
        if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
          final group = snapshot.data!.docs.first;
          return TeamChatPage(groupId: group.id);
        }

        // ❌ Not in any group
        return const GroupChatPage();
      },
    );
  }
}