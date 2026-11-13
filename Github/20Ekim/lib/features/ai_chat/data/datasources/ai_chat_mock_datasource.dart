import '../models/ai_message_model.dart';
import '../../domain/entities/ai_message.dart';

abstract class AiChatDataSource {
  Future<List<AiMessageModel>> getMessages(String roleSlug);
  Future<AiMessageModel> sendMessage(String roleSlug, String text);
}

class AiChatMockDataSource implements AiChatDataSource {
  final Map<String, List<AiMessageModel>> _messagesByRole = {};

  AiChatMockDataSource() {
    _initDefaultMessages();
  }

  void _initDefaultMessages() {
    final now = DateTime.now();
    _messagesByRole['mentor'] = [
      AiMessageModel(
        id: 'm1',
        roleSlug: 'mentor',
        text: 'Merhaba! Girişiminizin iş modeli, müşteri doğrulama veya yol haritası hakkında size nasıl yardımcı olabilirim?',
        sender: AiSender.assistant,
        timestamp: now.subtract(const Duration(minutes: 5)),
      ),
    ];
    _messagesByRole['lawyer'] = [
      AiMessageModel(
        id: 'l1',
        roleSlug: 'lawyer',
        text: 'Merhaba, şirket kurulumu, gizlilik sözleşmeleri (NDA) veya KVKK uyum süreçleriniz ile ilgili danışmak istediğiniz soruları iletebilirsiniz.',
        sender: AiSender.assistant,
        timestamp: now.subtract(const Duration(minutes: 5)),
        showLegalDisclaimer: true,
      ),
    ];
    _messagesByRole['accountant'] = [
      AiMessageModel(
        id: 'a1',
        roleSlug: 'accountant',
        text: 'Merhaba, faturalandırma, KDV istisnaları, Ar-Ge vergi indirimleri veya teşvik mevzuatı hakkında sorularınızı yanıtlayabilirim.',
        sender: AiSender.assistant,
        timestamp: now.subtract(const Duration(minutes: 5)),
        showLegalDisclaimer: true,
      ),
    ];
    _messagesByRole['investor'] = [
      AiMessageModel(
        id: 'i1',
        roleSlug: 'investor',
        text: 'Merhaba! Yatırımcı sunumunuz, değerleme yöntemleri ve fon arayışı stratejileriniz konusunda size destek olabilirim.',
        sender: AiSender.assistant,
        timestamp: now.subtract(const Duration(minutes: 5)),
      ),
    ];
    _messagesByRole['marketing'] = [
      AiMessageModel(
        id: 'mk1',
        roleSlug: 'marketing',
        text: 'Merhaba, büyüme deneyleri (growth hacking), performans pazarlaması ve kullanıcı edinim kanalları hakkında ne sormak istersiniz?',
        sender: AiSender.assistant,
        timestamp: now.subtract(const Duration(minutes: 5)),
      ),
    ];
  }

  @override
  Future<List<AiMessageModel>> getMessages(String roleSlug) async {
    await Future.delayed(const Duration(milliseconds: 30));
    return List.from(_messagesByRole[roleSlug] ?? []);
  }

  @override
  Future<AiMessageModel> sendMessage(String roleSlug, String text) async {
    await Future.delayed(const Duration(milliseconds: 100));
    final now = DateTime.now();
    final userMsg = AiMessageModel(
      id: 'u_${now.millisecondsSinceEpoch}',
      roleSlug: roleSlug,
      text: text,
      sender: AiSender.user,
      timestamp: now,
    );
    _messagesByRole.putIfAbsent(roleSlug, () => []).add(userMsg);

    // AI otomatik yanıtı
    final isLegalOrFinance = roleSlug == 'lawyer' || roleSlug == 'accountant';
    final aiResponseText = 'Konuyla ilgili değerlendirme: "$text" sorunuz analiz edildi. Bu aşamada temel adımları belirleyip ilgili uzmanla görüşmeniz önerilir.';
    final aiMsg = AiMessageModel(
      id: 'ai_${now.millisecondsSinceEpoch}',
      roleSlug: roleSlug,
      text: aiResponseText,
      sender: AiSender.assistant,
      timestamp: now.add(const Duration(milliseconds: 200)),
      showLegalDisclaimer: isLegalOrFinance,
    );
    _messagesByRole[roleSlug]!.add(aiMsg);
    return aiMsg;
  }
}
