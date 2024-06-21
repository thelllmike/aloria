import 'package:aloria/screens/utils/api_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List messages = [];
  TextEditingController messageController = TextEditingController();
  final int adminId = 3; // ID of cleverprojectlk
  final int userId = 1; // Your user ID (update as needed)
  int conversationId = 0; // ID of the conversation with the admin
  late WebSocketChannel channel;

  @override
  void initState() {
    super.initState();
    fetchConversation();
  }

  Future<void> fetchConversation() async {
    final url = Uri.parse('${ApiService.baseUrl}/api/conversations/');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List conversations = json.decode(response.body);
      final conversation = conversations.firstWhere(
        (conv) => (conv['user1_id'] == userId && conv['user2_id'] == adminId) ||
                  (conv['user1_id'] == adminId && conv['user2_id'] == userId),
        orElse: () => null,
      );

      if (conversation != null) {
        setState(() {
          conversationId = conversation['conversation_id'];
        });
        fetchMessages();
      } else {
        createConversation();
      }
    } else {
      throw Exception('Failed to load conversations');
    }
  }

  Future<void> createConversation() async {
    final url = Uri.parse('${ApiService.baseUrl}/api/conversations/');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'user1_id': userId,
        'user2_id': adminId,
      }),
    );

    if (response.statusCode == 200) {
      final conversation = json.decode(response.body);
      setState(() {
        conversationId = conversation['conversation_id'];
      });
      fetchMessages();
    } else {
      throw Exception('Failed to create conversation');
    }
  }

  Future<void> fetchMessages() async {
    if (conversationId == 0) return;

    final url = Uri.parse('${ApiService.baseUrl}/api/conversations/$conversationId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        messages = json.decode(response.body)['messages'];
      });
      initWebSocket();
    } else {
      throw Exception('Failed to load messages');
    }
  }

  void initWebSocket() {
    channel = WebSocketChannel.connect(Uri.parse('${ApiService.baseUrl.replaceFirst("http", "ws")}/ws/$conversationId'));

    channel.stream.listen((data) {
      setState(() {
        messages.add(json.decode(data));
      });
    });
  }

  Future<void> sendMessage() async {
    if (messageController.text.isEmpty || conversationId == 0) return;

    final url = Uri.parse('${ApiService.baseUrl}/api/messages/');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'conversation_id': conversationId,
        'sender_id': userId,
        'message': messageController.text,
      }),
    );

    if (response.statusCode == 200) {
      channel.sink.add(jsonEncode({
        'conversation_id': conversationId,
        'sender_id': userId,
        'message': messageController.text,
      }));
      messageController.clear();
    } else {
      throw Exception('Failed to send message');
    }
  }

  @override
  void dispose() {
    channel.sink.close(status.goingAway);
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF77BF43)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        title: const ListTile(
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/images/demologist.png'),
          ),
          title: Text('Dr. Lia Halpert', style: TextStyle(color: Colors.black)),
          subtitle: Text('Active 36 min ago', style: TextStyle(color: Colors.grey)),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isUser = message['sender_id'] == userId;
                return ChatBubble(
                  text: message['message'],
                  isUser: isUser,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: messageController,
              decoration: InputDecoration(
                hintText: 'Message',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(30),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send, color: Color(0xFF77BF43)),
                  onPressed: sendMessage,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isUser;

  const ChatBubble({required this.text, required this.isUser, super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: isUser ? const Color(0xFF77BF43) : Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(text, style: TextStyle(color: isUser ? Colors.white : Colors.black)),
      ),
    );
  }
}
