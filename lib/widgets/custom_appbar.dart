import 'package:flutter/material.dart';
import '../screens/chatbot_page.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final TabController? tabController;

  const CustomAppBar({
    super.key,
    this.height = kToolbarHeight,
    this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF7A0C0F),
      elevation: 0,
      automaticallyImplyLeading: false,
      centerTitle: true,

      title: GestureDetector(
        child: Image.asset(
          'assets/images/canvisit.png',
          height: 40,
          width: 110,
          fit: BoxFit.contain,
        ),
      ),

      leading: IconButton(
        icon: const Icon(Icons.chat_bubble_outline, color: Colors.white),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ChatBotPage()),
          );
        },
        tooltip: 'Chatbot',
      ),
      // ✔ Added TabBar with selected/unselected colors + white top border
      bottom: tabController != null
          ? PreferredSize(
        preferredSize: const Size.fromHeight(48),
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.white, width: 1), // WHITE TOP BORDER
            ),
          ),
          child: TabBar(
            controller: tabController,
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: const [
              Tab(icon: Icon(Icons.map), text: 'Carte'),
              Tab(icon: Icon(Icons.list), text: 'Liste'),
            ],
          ),
        ),
      )
          : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
    tabController != null ? height + 75 : height,
  );
}
