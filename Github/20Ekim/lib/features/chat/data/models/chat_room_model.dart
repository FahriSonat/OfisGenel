import '../../domain/entities/chat_room.dart';

class ChatRoomModel extends ChatRoom {
  const ChatRoomModel({
    required super.id,
    required super.roleSlug,
    required super.title,
    required super.lastMessage,
    required super.lastMessageTime,
    super.unreadCount,
  });

  factory ChatRoomModel.fromMap(Map<String, dynamic> map) {
    return ChatRoomModel(
      id: map['id'] as String,
      roleSlug: map['roleSlug'] as String,
      title: map['title'] as String,
      lastMessage: map['lastMessage'] as String,
      lastMessageTime: DateTime.parse(map['lastMessageTime'] as String),
      unreadCount: map['unreadCount'] as int? ?? 0,
    );
  }
}

class ChatMessageModel extends ChatMessage {
  const ChatMessageModel({
    required super.id,
    required super.roomId,
    required super.senderName,
    required super.text,
    required super.isMe,
    required super.timestamp,
  });

  factory ChatMessageModel.fromMap(Map<String, dynamic> map) {
    return ChatMessageModel(
      id: map['id'] as String,
      roomId: map['roomId'] as String,
      senderName: map['senderName'] as String,
      text: map['text'] as String,
      isMe: map['isMe'] as bool,
      timestamp: DateTime.parse(map['timestamp'] as String),
    );
  }
}
