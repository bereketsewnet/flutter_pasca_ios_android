class ChatMessage {
  final String text;
  final String sender;
  final String receiver;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.sender,
    required this.timestamp,
    required this.receiver,
  });
}