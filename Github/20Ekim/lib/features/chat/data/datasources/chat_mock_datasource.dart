import '../models/chat_room_model.dart';

abstract class ChatDataSource {
  Future<List<ChatRoomModel>> getChatRooms(String roleSlug);
  Future<List<ChatMessageModel>> getMessages(String roomId);
  Future<ChatMessageModel> sendMessage(String roomId, String text);
}

class ChatMockDataSource implements ChatDataSource {
  final Map<String, List<ChatRoomModel>> _roomsByRole = {};
  final Map<String, List<ChatMessageModel>> _messagesByRoom = {};

  ChatMockDataSource() {
    _initData();
  }

  void _initData() {
    final now = DateTime.now();
    _roomsByRole['mentor'] = [
      ChatRoomModel(
        id: 'r_m1',
        roleSlug: 'mentor',
        title: 'Kurucu Ortaklar & Mentor Ağı',
        lastMessage: 'Yarınki strateji seansı saat 14:00’te teyit edildi.',
        lastMessageTime: now.subtract(const Duration(minutes: 15)),
        unreadCount: 2,
      ),
      ChatRoomModel(
        id: 'r_m2',
        roleSlug: 'mentor',
        title: 'SaaS Girişimcileri Fikir Kulübü',
        lastMessage: 'Churn rate oranlarını nasıl düşürdünüz?',
        lastMessageTime: now.subtract(const Duration(hours: 3)),
        unreadCount: 0,
      ),
    ];

    _roomsByRole['lawyer'] = [
      ChatRoomModel(
        id: 'r_l1',
        roleSlug: 'lawyer',
        title: 'Yasal Uyum ve Sözleşmeler Grubu',
        lastMessage: 'Hissedarlar sözleşmesi taslağı incelendi.',
        lastMessageTime: now.subtract(const Duration(hours: 1)),
        unreadCount: 1,
      ),
    ];

    _roomsByRole['accountant'] = [
      ChatRoomModel(
        id: 'r_a1',
        roleSlug: 'accountant',
        title: 'Girişim Vergi & Teşvik Danışma',
        lastMessage: 'Teknopark muafiyet raporları yüklendi.',
        lastMessageTime: now.subtract(const Duration(hours: 2)),
        unreadCount: 0,
      ),
    ];

    _roomsByRole['investor'] = [
      ChatRoomModel(
        id: 'r_i1',
        roleSlug: 'investor',
        title: 'Tohum Yatırım Hazırlık Odası',
        lastMessage: 'Yatırımcı metrik şablonunu paylaşıyorum.',
        lastMessageTime: now.subtract(const Duration(hours: 4)),
        unreadCount: 3,
      ),
    ];

    _roomsByRole['marketing'] = [
      ChatRoomModel(
        id: 'r_mk1',
        roleSlug: 'marketing',
        title: 'Growth Hacking & Büyüme Ekibi',
        lastMessage: 'Yeni Google Ads kampanyası yayında!',
        lastMessageTime: now.subtract(const Duration(minutes: 40)),
        unreadCount: 0,
      ),
    ];

    // Örnek mesajlar
    _messagesByRoom['r_m1'] = [
      ChatMessageModel(
        id: 'msg1',
        roomId: 'r_m1',
        senderName: 'Ahmet Mentor',
        text: 'Merhaba arkadaşlar, son iş planı revizyonunu inceledim.',
        isMe: false,
        timestamp: now.subtract(const Duration(hours: 1)),
      ),
      ChatMessageModel(
        id: 'msg2',
        roomId: 'r_m1',
        senderName: 'Ben',
        text: 'Teşekkürler Ahmet Bey, metrikleri güncelledik.',
        isMe: true,
        timestamp: now.subtract(const Duration(minutes: 30)),
      ),
      ChatMessageModel(
        id: 'msg3',
        roomId: 'r_m1',
        senderName: 'Ahmet Mentor',
        text: 'Yarınki strateji seansı saat 14:00’te teyit edildi.',
        isMe: false,
        timestamp: now.subtract(const Duration(minutes: 15)),
      ),
    ];
  }

  @override
  Future<List<ChatRoomModel>> getChatRooms(String roleSlug) async {
    await Future.delayed(const Duration(milliseconds: 30));
    return List.from(_roomsByRole[roleSlug] ?? []);
  }

  @override
  Future<List<ChatMessageModel>> getMessages(String roomId) async {
    await Future.delayed(const Duration(milliseconds: 30));
    return List.from(_messagesByRoom[roomId] ?? [
      ChatMessageModel(
        id: 'welcome',
        roomId: roomId,
        senderName: 'Topluluk Botu',
        text: 'Sohbet odasına hoş geldiniz. Sorularınızı buradan paylaşabilirsiniz.',
        isMe: false,
        timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
      ),
    ]);
  }

  @override
  Future<ChatMessageModel> sendMessage(String roomId, String text) async {
    await Future.delayed(const Duration(milliseconds: 50));
    final msg = ChatMessageModel(
      id: 'm_${DateTime.now().millisecondsSinceEpoch}',
      roomId: roomId,
      senderName: 'Ben',
      text: text,
      isMe: true,
      timestamp: DateTime.now(),
    );
    _messagesByRoom.putIfAbsent(roomId, () => []).add(msg);
    return msg;
  }
}
