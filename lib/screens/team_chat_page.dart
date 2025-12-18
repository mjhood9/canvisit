import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

// --- Helper for Group Flag ---
Widget _flagAvatar(String url) {
  final Widget flagContent = url.endsWith('.svg')
      ? SvgPicture.network(url, fit: BoxFit.cover)
      : Image.network(url, fit: BoxFit.cover);

  return Container(
    width: 36, height: 36,
    decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2)),
    child: ClipOval(child: flagContent),
  );
}

class GroupData {
  final String name;
  final String flagUrl;
  GroupData(this.name, this.flagUrl);
}

class TeamChatPage extends StatefulWidget {
  final String groupId;
  const TeamChatPage({super.key, required this.groupId});

  @override
  State<TeamChatPage> createState() => _TeamChatPageState();
}

class _TeamChatPageState extends State<TeamChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ImagePicker _picker = ImagePicker();

  final String cloudName = "dib0ymnnu";
  final String uploadPreset = "canvisit";

  @override
  void initState() {
    super.initState();
    // 1. Reset count when entering the page
    _resetUnreadCount();
  }

  // 🛡️ Logic to reset unread count for the current user
  void _resetUnreadCount() {
    final String? myUid = _auth.currentUser?.uid;
    if (myUid == null) return;

    _firestore.collection('group_chats').doc(widget.groupId).update({
      'unreadCount.$myUid': 0,
    }).catchError((e) => debugPrint("Error resetting count: $e"));
  }

  Future<GroupData> _fetchGroupData() async {
    final doc = await _firestore.collection('group_chats').doc(widget.groupId).get();
    if (doc.exists) {
      final data = doc.data();
      return GroupData(data?['name'] ?? "Chat Supporters", data?['flag'] ?? "");
    }
    return GroupData("Chat Supporters", "");
  }

  // 🚪 Exit Group Logic
  void _showExitPopup() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Quitter le groupe ?", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(ctx),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFFB71C1C),
                      side: const BorderSide(color: Color(0xFFB71C1C), width: 1),
                    ),
                    child: const Text("Non"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7A0C0F),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () async {
                      final uid = _auth.currentUser?.uid;
                      if (uid != null) {
                        await _firestore.collection('group_chats').doc(widget.groupId).update({
                          'users': FieldValue.arrayRemove([uid]),
                        });
                      }
                      Navigator.pop(ctx);
                      if (mounted) Navigator.pop(context);
                    },
                    child: const Text("Oui"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 🛠️ WhatsApp Style: Long Press Options
  void _showOptions(String messageId, String currentText, bool hasMedia) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            if (!hasMedia)
              ListTile(
                leading: const Icon(Icons.edit, color: Colors.blue),
                title: const Text("Modifier le texte"),
                onTap: () {
                  Navigator.pop(context);
                  _showEditDialog(messageId, currentText);
                },
              ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text("Supprimer le message"),
              onTap: () {
                Navigator.pop(context);
                _deleteMessage(messageId);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(String messageId, String currentText) {
    final TextEditingController editController = TextEditingController(text: currentText);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Modifier le message"),
        content: TextField(controller: editController, autofocus: true),
        actions: [
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(ctx),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFFB71C1C),
                    side: const BorderSide(color: Color(0xFFB71C1C), width: 1),
                  ),
                  child: const Text("Annuler"),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7A0C0F),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () async {
                    await _firestore
                        .collection('group_chats')
                        .doc(widget.groupId)
                        .collection('messages')
                        .doc(messageId)
                        .update({
                      'text': editController.text.trim(),
                      'isEdited': true,
                    });
                    if (mounted) Navigator.pop(ctx);
                  },
                  child: const Text("Enregistrer"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _deleteMessage(String messageId) async {
    await _firestore.collection('group_chats').doc(widget.groupId).collection('messages').doc(messageId).delete();
  }

  // 📤 Upload & Send Logic
  Future<void> _pickAndUpload(bool isVideo) async {
    final XFile? file = isVideo
        ? await _picker.pickVideo(source: ImageSource.gallery)
        : await _picker.pickImage(source: ImageSource.gallery, imageQuality: 70);

    if (file == null) return;

    try {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Envoi...")));
      final String resType = isVideo ? "video" : "image";
      var uri = Uri.parse("https://api.cloudinary.com/v1_1/$cloudName/$resType/upload");
      var request = http.MultipartRequest("POST", uri);
      request.fields['upload_preset'] = uploadPreset;
      request.files.add(await http.MultipartFile.fromPath('file', file.path));

      var response = await request.send();
      var jsonRes = jsonDecode(await response.stream.bytesToString());

      if (response.statusCode == 200) {
        await _firestore.collection('group_chats').doc(widget.groupId).collection('messages').add({
          'text': _messageController.text.trim(),
          'senderId': _auth.currentUser!.uid,
          'senderName': _auth.currentUser!.displayName ?? "Supporter",
          'senderAvatar': _auth.currentUser!.photoURL,
          'timestamp': FieldValue.serverTimestamp(),
          'mediaUrl': jsonRes['secure_url'],
          'mediaType': resType,
        });
        _messageController.clear();
      }
    } catch (e) { debugPrint(e.toString()); }
  }

  void _sendTextMessage() async {
    final String msg = _messageController.text.trim();
    if (msg.isEmpty) return;
    _messageController.clear();
    await _firestore.collection('group_chats').doc(widget.groupId).collection('messages').add({
      'text': msg,
      'senderId': _auth.currentUser!.uid,
      'senderName': _auth.currentUser!.displayName ?? "Supporter",
      'senderAvatar': _auth.currentUser!.photoURL,
      'timestamp': FieldValue.serverTimestamp(),
      'mediaUrl': null,
      'mediaType': null,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF7A0C0F),
        iconTheme: const IconThemeData(color: Colors.white),
        title: FutureBuilder<GroupData>(
          future: _fetchGroupData(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Text("Chargement...");
            return Row(children: [
              if (snapshot.data!.flagUrl.isNotEmpty) _flagAvatar(snapshot.data!.flagUrl),
              const SizedBox(width: 10),
              Text(snapshot.data!.name, style: const TextStyle(color: Colors.white)),
            ]);
          },
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) => value == 'exit' ? _showExitPopup() : null,
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'exit', child: Text("Quitter le groupe")),
            ],
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('group_chats').doc(widget.groupId).collection('messages').orderBy('timestamp', descending: true).snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  reverse: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final doc = snapshot.data!.docs[index];
                    final data = doc.data() as Map<String, dynamic>;
                    return ChatBubble(
                      messageId: doc.id,
                      text: data['text'] ?? "",
                      isMe: data['senderId'] == _auth.currentUser?.uid,
                      senderName: data['senderName'],
                      senderAvatarUrl: data['senderAvatar'],
                      mediaUrl: data['mediaUrl'],
                      mediaType: data['mediaType'],
                      onLongPress: (id, txt, hasMedia) => _showOptions(id, txt, hasMedia),
                    );
                  },
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                IconButton(icon: const Icon(Icons.attach_file), onPressed: () {
                  showModalBottomSheet(context: context, builder: (ctx) => SafeArea(child: Wrap(children: [
                    ListTile(leading: const Icon(Icons.image, color: Colors.blue), title: const Text("Image"), onTap: () { Navigator.pop(ctx); _pickAndUpload(false); }),
                    ListTile(leading: const Icon(Icons.videocam, color: Colors.red), title: const Text("Vidéo"), onTap: () { Navigator.pop(ctx); _pickAndUpload(true); }),
                  ])));
                }),
                Expanded(child: TextField(controller: _messageController, decoration: const InputDecoration(hintText: "Message", border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)))))),
                IconButton(icon: const CircleAvatar(backgroundColor: Color(0xFF7A0C0F), child: Icon(Icons.send, color: Colors.white)), onPressed: _sendTextMessage),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// --- Chat Bubble Component ---
class ChatBubble extends StatelessWidget {
  final String messageId;
  final String text;
  final bool isMe;
  final String? senderName;
  final String? senderAvatarUrl;
  final String? mediaUrl;
  final String? mediaType;
  final Function(String, String, bool) onLongPress;

  const ChatBubble({
    super.key,
    required this.messageId,
    required this.text,
    required this.isMe,
    required this.onLongPress,
    this.senderName,
    this.senderAvatarUrl,
    this.mediaUrl,
    this.mediaType,
  });

  @override
  Widget build(BuildContext context) {
    bool hasMedia = mediaUrl != null;

    return GestureDetector(
      onLongPress: isMe ? () => onLongPress(messageId, text, hasMedia) : null,
      child: Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (!isMe) CircleAvatar(radius: 14, backgroundImage: senderAvatarUrl != null ? NetworkImage(senderAvatarUrl!) : null, child: senderAvatarUrl == null ? Text(senderName?[0] ?? "?") : null),
            const SizedBox(width: 4),
            Flexible(
              child: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
                    color: isMe ? const Color(0xFF7A0C0F) : Colors.grey[300],
                    borderRadius: BorderRadius.circular(12)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!isMe) Text(senderName ?? "", style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.blue)),
                    if (mediaUrl != null) _buildMedia(context),
                    if (text.isNotEmpty) Text(text, style: TextStyle(color: isMe ? Colors.white : Colors.black)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMedia(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => FullScreenPlayer(url: mediaUrl!, isVideo: mediaType == 'video'))),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: mediaType == 'video'
            ? Container(width: 200, height: 150, color: Colors.black, child: const Icon(Icons.play_circle_fill, color: Colors.white, size: 50))
            : Image.network(mediaUrl!, width: 200, height: 150, fit: BoxFit.cover),
      ),
    );
  }
}

// --- Full Screen Viewer ---
class FullScreenPlayer extends StatefulWidget {
  final String url;
  final bool isVideo;
  const FullScreenPlayer({super.key, required this.url, required this.isVideo});
  @override State<FullScreenPlayer> createState() => _FullScreenPlayerState();
}

class _FullScreenPlayerState extends State<FullScreenPlayer> {
  VideoPlayerController? _vpc;
  ChewieController? _cc;

  @override
  void initState() {
    super.initState();
    if (widget.isVideo) {
      _vpc = VideoPlayerController.networkUrl(Uri.parse(widget.url));
      _cc = ChewieController(videoPlayerController: _vpc!, autoPlay: true, aspectRatio: 16/9);
    }
  }

  @override void dispose() { _vpc?.dispose(); _cc?.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
              icon: const Icon(Icons.download),
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Téléchargement lancé...")))
          )
        ],
      ),
      body: Center(
        child: widget.isVideo
            ? (Chewie(controller: _cc!))
            : Image.network(widget.url, fit: BoxFit.contain),
      ),
    );
  }
}