
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';



class LoginPag extends StatefulWidget {
  @override
  _LoginPagState createState() => _LoginPagState();
}

class _LoginPagState extends State<LoginPag> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _signInWithEmailAndPassword() async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      final User? user = userCredential.user;
      if (user != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(user: user),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _signInWithEmailAndPassword,
              child: Text('Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatPage extends StatefulWidget {
  final User user;

  ChatPage({required this.user});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final DatabaseReference _chatsRef = FirebaseDatabase.instance.reference().child('chats');
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: _chatsRef.onValue,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final Map<dynamic, dynamic>? chats = snapshot.data?.snapshot.value as Map?;
                  if (chats != null) {
                    final List<Widget> chatWidgets = [];
                    chats.forEach((chatId, chatData) {
                      final List<Widget> messageWidgets = [];
                      if (chatData['messages'] != null) {
                        final Map<dynamic, dynamic> messages = chatData['messages'];
                        messages.forEach((messageId, messageData) {
                          final String senderId = messageData['senderId'];
                          final String content = messageData['content'];
                          final DateTime timestamp = DateTime.fromMillisecondsSinceEpoch(messageData['timestamp']);
                          final Widget messageWidget = ListTile(
                            title: Text(content),
                            subtitle: Text('$senderId - ${timestamp.toString()}'),
                          );
                          messageWidgets.add(messageWidget);
                        });
                      }
                      final Widget chatWidget = Column(
                        children: [
                          Text('Chat Room: $chatId'),
                          ...messageWidgets,
                        ],
                      );
                      chatWidgets.add(chatWidget);
                    });
                    return ListView(
                      controller: _scrollController,
                      children: chatWidgets,
                    );
                  }
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
          Divider(height: 1.0),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(labelText: 'Message'),
                  ),
                ),
                ElevatedButton(
                  onPressed: _sendMessage,
                  child: Text('Send'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    final String chatRoomId = "your_chat_room_id2"; // Replace with the actual chat room ID
    final String senderId = widget.user.uid;
    final String content = _messageController.text;
    final DateTime timestamp = DateTime.now();

    final Message message = Message(senderId: senderId, content: content, timestamp: timestamp);

    _chatsRef.child(chatRoomId).child('messages').push().set(message.toJson());

    _messageController.clear();
  }
}

class Message {
  final String senderId;
  final String content;
  final DateTime timestamp;

  Message({required this.senderId, required this.content, required this.timestamp});

  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'content': content,
      'timestamp': timestamp.millisecondsSinceEpoch,
    };
  }
}