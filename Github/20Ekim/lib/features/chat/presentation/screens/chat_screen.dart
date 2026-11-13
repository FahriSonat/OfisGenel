import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../support_space/domain/entities/support_role.dart';
import '../providers/chat_providers.dart';
import 'chat_room_detail_screen.dart';

/// [ChatScreen]
/// Kullanıcı ve Topluluk Sohbet Odaları Listesi Ekranı (/space/:role/chat).
/// - Rol bazlı grup ve birebir iletişim odalarını listeler.
/// - Okunmamış mesaj sayısını Material 3 [Badge] rozeti ile gösterir.
/// - Bir odaya tıklandığında [ChatRoomDetailScreen] mesajlaşma ekranına geçer.
class ChatScreen extends ConsumerWidget {
  final String roleSlug;

  const ChatScreen({
    super.key,
    required this.roleSlug,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = SupportRole.tryParse(roleSlug) ?? SupportRole.mentor;
    final roomsAsync = ref.watch(chatRoomsProvider(roleSlug));
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('${role.label} Topluluk Sohbeti'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
          child: roomsAsync.when(
            data: (rooms) {
              if (rooms.isEmpty) {
                return const Center(
                  child: Text('Bu alanda aktif sohbet odası bulunmuyor.'),
                );
              }
              return ListView.separated(
                padding: const EdgeInsets.all(AppSpacing.md),
                itemCount: rooms.length,
                separatorBuilder: (_, _) =>
                    const SizedBox(height: AppSpacing.sm),
                itemBuilder: (context, index) {
                  final room = rooms[index];
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: theme.colorScheme.primaryContainer,
                        child:
                            Icon(Icons.group, color: theme.colorScheme.primary),
                      ),
                      title: Text(
                        room.title,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        room.lastMessage,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall,
                      ),
                      // Okunmamış mesaj sayısı varsa Badge rozeti göster
                      trailing: room.unreadCount > 0
                          ? Badge(
                              label: Text('${room.unreadCount}'),
                              backgroundColor: theme.colorScheme.error,
                            )
                          : const Icon(Icons.chevron_right),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ChatRoomDetailScreen(room: room),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, _) => Center(
              child:
                  Text('Hata: $err', style: const TextStyle(color: Colors.red)),
            ),
          ),
        ),
      ),
    );
  }
}
