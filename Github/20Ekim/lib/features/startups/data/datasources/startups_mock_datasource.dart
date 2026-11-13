import '../models/startup_model.dart';

abstract class StartupsDataSource {
  Future<List<StartupModel>> getStartups();
  Future<StartupModel?> getStartupById(String id);
  Future<StartupModel> createStartup({
    required String name,
    required String tagLine,
    required String sector,
    required String stage,
    required double fundingGoal,
    required String description,
    required String founderName,
    required int teamSize,
    required String mrr,
    required String growthRate,
  });
}

class StartupsMockDataSource implements StartupsDataSource {
  final List<StartupModel> _startups = [
    const StartupModel(
      id: 'st-1',
      name: 'VeriMind AI',
      tagLine: 'KOBİ’ler için otonom finansal zeka ve nakit akışı tahminleme',
      sector: 'AI & FinTech',
      stage: 'Seed',
      fundingGoal: 500000,
      raisedAmount: 320000,
      description:
          'VeriMind, KOBİ’lerin muhasebe ve banka verilerini büyük dil modelleri ve zaman serisi analizi ile birleştirerek 90 günlük nakit akışı risklerini önceden tahmin eder.',
      founderName: 'Canan Özdemir & Mert Yılmaz',
      teamSize: 6,
      mrr: '\$18.500',
      growthRate: '%24 MoM',
      pitchDeckUrl: 'https://verimind.example.com/pitch.pdf',
    ),
    const StartupModel(
      id: 'st-2',
      name: 'GreenLogix',
      tagLine: 'Elektrikli filo optimizasyonu ve karbon ayak izi raporlama SaaS',
      sector: 'CleanTech',
      stage: 'Pre-seed',
      fundingGoal: 250000,
      raisedAmount: 180000,
      description:
          'Lojistik şirketlerinin elektrikli araç filolarını akıllı şarj algoritmalarıyla yönetmesini ve ESG regülasyonlarına uygun karbon kredisi hesaplamasını sağlar.',
      founderName: 'Emre Karaca',
      teamSize: 4,
      mrr: '\$7.200',
      growthRate: '%35 MoM',
      pitchDeckUrl: 'https://greenlogix.example.com/pitch.pdf',
    ),
    const StartupModel(
      id: 'st-3',
      name: 'DocuLegal',
      tagLine: 'Yapay zeka destekli akıllı sözleşme analizi ve risk denetimi',
      sector: 'LegalTech',
      stage: 'Seed',
      fundingGoal: 400000,
      raisedAmount: 400000,
      description:
          'Yüzlerce sayfalık ticari sözleşmeleri saniyeler içinde tarayarak riskli maddeleri, cezai şartları ve mevzuat uyumsuzluklarını avukatlara raporlar.',
      founderName: 'Av. Zeynep Aksoy',
      teamSize: 5,
      mrr: '\$22.000',
      growthRate: '%18 MoM',
      pitchDeckUrl: 'https://doculegal.example.com/pitch.pdf',
    ),
    const StartupModel(
      id: 'st-4',
      name: 'PulseHealth',
      tagLine: 'Kronik hasta uzaktan takip ve IoT tele-tıp platformu',
      sector: 'HealthTech',
      stage: 'Seri A',
      fundingGoal: 1500000,
      raisedAmount: 850000,
      description:
          'Giyilebilir medikal sensörler aracılığıyla kalp ve tansiyon hastalarının canlı sağlık parametrelerini takip ederek acil durumlarda hekimleri uyarır.',
      founderName: 'Dr. Burak Sezgin',
      teamSize: 12,
      mrr: '\$65.000',
      growthRate: '%15 MoM',
      pitchDeckUrl: 'https://pulsehealth.example.com/pitch.pdf',
    ),
  ];

  @override
  Future<List<StartupModel>> getStartups() async {
    await Future.delayed(const Duration(milliseconds: 40));
    return List.from(_startups);
  }

  @override
  Future<StartupModel?> getStartupById(String id) async {
    await Future.delayed(const Duration(milliseconds: 30));
    for (final s in _startups) {
      if (s.id == id) return s;
    }
    return null;
  }

  @override
  Future<StartupModel> createStartup({
    required String name,
    required String tagLine,
    required String sector,
    required String stage,
    required double fundingGoal,
    required String description,
    required String founderName,
    required int teamSize,
    required String mrr,
    required String growthRate,
  }) async {
    await Future.delayed(const Duration(milliseconds: 80));
    final newStartup = StartupModel(
      id: 'st-${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      tagLine: tagLine,
      sector: sector,
      stage: stage,
      fundingGoal: fundingGoal,
      raisedAmount: 0,
      description: description,
      founderName: founderName,
      teamSize: teamSize,
      mrr: mrr,
      growthRate: growthRate,
      pitchDeckUrl: 'https://example.com/deck.pdf',
    );
    _startups.insert(0, newStartup);
    return newStartup;
  }
}
