import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../support_space/domain/entities/support_role.dart';
import '../../domain/entities/ai_message.dart';
import '../providers/ai_chat_providers.dart';

/// [AiChatScreen]
/// Rol Bazlı Yapay Zeka Danışmanlık Ekranı (/space/:role/ai-chat).
/// - Mesajlar `roleSlug` ile izole edilir; roller arası AI sohbetleri birbirine karışmaz.
/// - Kullanıcı mesajları sağda (primaryContainer), yapay zeka yanıtları solda (surfaceContainerHighest) yer alır.
/// - Hukuki ve Mali konularda otomatik bilgilendirme (disclaimer) notu eklenir.
class AiChatScreen extends ConsumerStatefulWidget {
  final String roleSlug;

  const AiChatScreen({
    super.key,
    required this.roleSlug,
  });

  @override
  ConsumerState<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends ConsumerState<AiChatScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Yeni kullanıcı mesajını gönderir ve provider listesini günceller
  Future<void> _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    _controller.clear();
    await ref
        .read(aiChatRepositoryProvider)
        .sendMessage(widget.roleSlug, text);
    ref.invalidate(aiChatMessagesProvider(widget.roleSlug));
  }

  @override
  Widget build(BuildContext context) {
    final role = SupportRole.tryParse(widget.roleSlug) ?? SupportRole.mentor;
    final messagesAsync = ref.watch(aiChatMessagesProvider(widget.roleSlug));
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('${role.label} AI Asistanı'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
          child: Column(
            children: [
              // Mesaj listesi alanı: data, loading ve error durumlarını yönetir
              Expanded(
                child: messagesAsync.when(
                  data: (messages) => ListView.builder(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return _AiMessageBubble(message: messages[index]);
                    },
                  ),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (err, _) => Center(
                    child: Text('Hata: $err',
                        style: const TextStyle(color: Colors.red)),
                  ),
                ),
              ),
              // Sabit alt mesaj giriş alanı
              _buildInputArea(theme),
            ],
          ),
        ),
      ),
    );
  }

  /// Alt metin girişi ve gönder butonu alanı
  Widget _buildInputArea(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        border:
            Border(top: BorderSide(color: theme.colorScheme.outlineVariant)),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                onSubmitted: (_) => _sendMessage(),
                decoration: InputDecoration(
                  hintText: 'Sorunuzu yazın...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
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
    );
  }
}

/// [ _AiMessageBubble ]
/// Kullanıcı ve Yapay Zeka mesaj kutucuğu bileşeni
class _AiMessageBubble extends StatelessWidget {
  final AiMessage message;

  const _AiMessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isUser = message.sender == AiSender.user;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.sm),
        constraints: const BoxConstraints(maxWidth: 480),
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: isUser
              ? theme.colorScheme.primaryContainer
              : theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.text,
              style: TextStyle(
                color: isUser
                    ? theme.colorScheme.onPrimaryContainer
                    : theme.colorScheme.onSurface,
                height: 1.4,
              ),
            ),
            // Hukuki ve Mali yanıtlarda zorunlu yasal uyarı rozeti
            if (message.showLegalDisclaimer) ...[
              const SizedBox(height: AppSpacing.xs),
              Text(
                '⚠️ Bu yanıt yalnızca bilgilendirme amaçlıdır, kesin bağlayıcılık taşımaz.',
                style: theme.textTheme.bodySmall?.copyWith(
                  fontStyle: FontStyle.italic,
                  fontSize: 11,
                  color: Colors.orange.shade800,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
