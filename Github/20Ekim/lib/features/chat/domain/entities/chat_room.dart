class ChatRoom {
  final String id;
  final String roleSlug;
  final String title;
  final String lastMessage;
  final DateTime lastMessageTime;
  final int unreadCount;

  const ChatRoom({
    required this.id,
    required this.roleSlug,
    required this.title,
    required this.lastMessage,
    required this.lastMessageTime,
    this.unreadCount = 0,
  });
}

class ChatMessage {
  final String id;
  final String roomId;
  final String senderName;
  final String text;
  final bool isMe;
  final DateTime timestamp;

  const ChatMessage({
    required this.id,
    required this.roomId,
    required this.senderName,
    required this.text,
    required this.isMe,
    required this.timestamp,
  });
}
