import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/chat_room.dart';
import '../providers/chat_providers.dart';

/// [ChatRoomDetailScreen]
/// Seçilen Sohbet Odasının Canlı Mesajlaşma Ekranı.
/// - Kullanıcının kendi mesajları sağda (primaryContainer), diğer katılımcıların mesajları solda görünür.
/// - Mesaj gönderildiğinde Riverpod üzerinden anında veritabanı/mock katmanı tetiklenir ve ekran güncellenir.
class ChatRoomDetailScreen extends ConsumerStatefulWidget {
  final ChatRoom room;

  const ChatRoomDetailScreen({
    super.key,
    required this.room,
  });

  @override
  ConsumerState<ChatRoomDetailScreen> createState() =>
      _ChatRoomDetailScreenState();
}

class _ChatRoomDetailScreenState extends ConsumerState<ChatRoomDetailScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Odaya yeni mesaj gönderir ve odaya ait mesaj listesini yeniler
  Future<void> _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    _controller.clear();
    await ref.read(chatRepositoryProvider).sendMessage(widget.room.id, text);
    ref.invalidate(chatMessagesProvider(widget.room.id));
  }

  @override
  Widget build(BuildContext context) {
    final messagesAsync = ref.watch(chatMessagesProvider(widget.room.id));
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.room.title),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
          child: Column(
            children: [
              // Mesaj akış listesi
              Expanded(
                child: messagesAsync.when(
                  data: (messages) => ListView.builder(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final msg = messages[index];
                      return Align(
                        alignment: msg.isMe
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                          padding: const EdgeInsets.all(AppSpacing.md),
                          constraints: const BoxConstraints(maxWidth: 420),
                          decoration: BoxDecoration(
                            color: msg.isMe
                                ? theme.colorScheme.primaryContainer
                                : theme.colorScheme.surfaceContainerHighest,
                            borderRadius:
                                BorderRadius.circular(AppSpacing.radiusMd),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (!msg.isMe)
                                Text(
                                  msg.senderName,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: theme.colorScheme.primary,
                                  ),
                                ),
                              Text(msg.text),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (err, _) => Center(child: Text('Hata: $err')),
                ),
              ),
              // Alt mesaj yazma alanı
              Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: theme.scaffoldBackgroundColor,
                  border: Border(
                    top: BorderSide(color: theme.colorScheme.outlineVariant),
                  ),
                ),
                child: SafeArea(
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          onSubmitted: (_) => _sendMessage(),
                          decoration: InputDecoration(
                            hintText: 'Mesajınızı yazın...',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(AppSpacing.radiusMd),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.md,
                              vertical: AppSpacing.sm,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      IconButton.filled(
                        onPressed: _sendMessage,
                        icon: const Icon(Icons.send),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
