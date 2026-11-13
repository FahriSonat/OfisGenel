import '../models/program_link_model.dart';
import '../models/program_model.dart';
import '../models/program_section_model.dart';
import '../../domain/entities/program_link.dart';

abstract class ProgramsDataSource {
  Future<List<ProgramModel>> getPrograms();
  Future<ProgramModel?> getProgramBySlug(String slug);
}

class ProgramsMockDataSource implements ProgramsDataSource {
  final List<ProgramModel> _programs = [
    const ProgramModel(
      id: '1',
      slug: 'program-1',
      title: 'TÜBİTAK 1512 BİGG Girişimcilik Programı',
      summary: 'Teknoloji ve yenilik odaklı iş fikirlerine 900.000 TL hibe desteği sağlayan ulusal hızlandırıcı programı.',
      sections: [
        ProgramSectionModel(
          id: 's1-1',
          title: 'Program Kapsamı ve Hedef Kitle',
          content: 'Üniversitelerin lisans, yüksek lisans, doktora öğrencileri ve mezunları teknoloji tabanlı iş fikirleriyle başvurabilir.',
          order: 1,
        ),
        ProgramSectionModel(
          id: 's1-2',
          title: 'Sağlanan Destekler',
          content: 'Temel iş modeli geliştirme kampları, teknik ve ticari mentorluklar ve 900.000 TL geri ödemesiz çekirdek sermaye hibesi.',
          order: 2,
        ),
        ProgramSectionModel(
          id: 's1-3',
          title: 'Başvuru ve Değerlendirme Takvimi',
          content: '1. Aşama fikir onayından sonra iş planı hazırlama süreci başlar. Yıllık çağrı takvimi doğrultusunda başvurular kabul edilir.',
          order: 3,
        ),
      ],
      links: [
        ProgramLinkModel(
          url: 'https://etkinlik.tubitak.gov.tr/bigg',
          type: ProgramLinkType.applicationForm,
          customLabel: 'BİGG Başvuru Formuna Git',
        ),
        ProgramLinkModel(
          url: 'https://tubitak.gov.tr/tr/destekler/girisimcilik',
          type: ProgramLinkType.info,
          customLabel: 'Program Rehberini İncele',
        ),
      ],
    ),
    const ProgramModel(
      id: '2',
      slug: 'program-2',
      title: 'KOSGEB İleri Girişimci Destek Programı',
      summary: 'İmalat ve yüksek teknoloji alanlarında faaliyet gösteren yeni işletmelere yönelik hibe ve faizsiz kredi paketi.',
      sections: [
        ProgramSectionModel(
          id: 's2-1',
          title: 'Destek Unsurları',
          content: 'Kuruluş desteği, makine-teçhizat ve yazılım giderleri desteği ile istihdam prim destekleri sunulur.',
          order: 1,
        ),
        ProgramSectionModel(
          id: 's2-2',
          title: 'Kimler Yararlanabilir?',
          content: 'KOSGEB Girişimcilik Eğitimi almış, son 1 yıl içinde şahıs veya sermaye şirketi kurmuş girişimciler.',
          order: 2,
        ),
      ],
      links: [
        ProgramLinkModel(
          url: 'https://edevlet.kosgeb.gov.tr/ileri-girisimci',
          type: ProgramLinkType.applicationForm,
          customLabel: 'KOSGEB Başvurusunu Başlat',
        ),
      ],
    ),
    const ProgramModel(
      id: '3',
      slug: 'program-3',
      title: 'Erken Aşama Hızlandırma ve Globalleşme',
      summary: 'Yurt dışı pazarlara açılmayı hedefleyen SaaS ve derin teknoloji girişimlerine özel 12 haftalık hızlandırma programı.',
      sections: [
        ProgramSectionModel(
          id: 's3-1',
          title: 'Hızlandırma Müfredatı',
          content: 'Global ürün-pazar uyumu (PMF), yurt dışı müşteri edinimi, uluslararası şirket kurulumu ve yatırım sunumu hazırlığı.',
          order: 1,
        ),
        ProgramSectionModel(
          id: 's3-2',
          title: 'Uluslararası Mentor Ağı',
          content: 'Silikon Vadisi ve Londra ekosisteminden tecrübeli seri girişimcilerle haftalık birebir seanslar.',
          order: 2,
        ),
      ],
      links: [
        ProgramLinkModel(
          url: 'https://accelerator.example.com/apply',
          type: ProgramLinkType.applicationForm,
          customLabel: 'Hızlandırıcıya Başvur',
        ),
        ProgramLinkModel(
          url: 'https://accelerator.example.com/info',
          type: ProgramLinkType.info,
          customLabel: 'Haftalık Takvim ve Bilgi',
        ),
      ],
    ),
    const ProgramModel(
      id: '4',
      slug: 'program-4',
      title: 'Melek Yatırım Hazırlık Programı (Demo Day)',
      summary: 'Yatırım turuna çıkmaya hazır girişimlerin değerleme, finansal modelleme ve yatırımcı sunumu eğitimi.',
      sections: [
        ProgramSectionModel(
          id: 's4-1',
          title: 'Yatırımcı Buluşmaları',
          content: 'Program sonunda 40+ akredite melek yatırımcı ve VC temsilcisine kapalı oturumda sunum (Pitch) imkanı.',
          order: 1,
        ),
        ProgramSectionModel(
          id: 's4-2',
          title: 'Term Sheet ve Hukuki İnceleme',
          content: 'Yatırım sözleşmeleri, hissedarlar sözleşmesi (SHA) ve due diligence süreç simülasyonları.',
          order: 2,
        ),
      ],
      links: [
        ProgramLinkModel(
          url: 'https://investor-network.example.com/pitch-application',
          type: ProgramLinkType.applicationForm,
          customLabel: 'Demo Day Başvurusu Yap',
        ),
      ],
    ),
    const ProgramModel(
      id: '5',
      slug: 'program-5',
      title: 'Kadın Girişimci Teknoloji Teşvik Programı',
      summary: 'Kadın kurucu ortaklı teknoloji girişimlerinin güçlendirilmesi ve finansmana erişimini hızlandırma fonu.',
      sections: [
        ProgramSectionModel(
          id: 's5-1',
          title: 'Özel Destek Mekanizması',
          content: 'Yönetim danışmanlığı, ağ kurma (networking) etkinlikleri ve özel tohum öncesi mikro-hibe imkanları.',
          order: 1,
        ),
        ProgramSectionModel(
          id: 's5-2',
          title: 'Liderlik ve Yönetim Atölyeleri',
          content: 'Ekip kurma, liderlik becerileri ve ölçeklenme döneminde operasyon yönetimi atölye çalışmaları.',
          order: 2,
        ),
      ],
      links: [
        ProgramLinkModel(
          url: 'https://womenintech.example.com/apply',
          type: ProgramLinkType.applicationForm,
          customLabel: 'Kadın Girişimci Başvuru Formu',
        ),
      ],
    ),
    const ProgramModel(
      id: '6',
      slug: 'program-6',
      title: 'Yapay Zeka ve Veri İnovasyon Laboratuvarı',
      summary: 'Üretken yapay zeka ve büyük dil modelleri geliştiren girişimlere GPU altyapısı ve bulut kredisi desteği.',
      sections: [
        ProgramSectionModel(
          id: 's6-1',
          title: 'Bulut ve Altyapı Desteği',
          content: 'Seçilen ekiplere 50.000 dolara kadar bulut sunucu kredisi ve yüksek performanslı hesaplama (HPC) kaynakları.',
          order: 1,
        ),
        ProgramSectionModel(
          id: 's6-2',
          title: 'Teknik Mimari İncelemesi',
          content: 'AI araştırmacıları ve MLOps uzmanlarıyla mimari optimizasyon ve model fine-tuning desteği.',
          order: 2,
        ),
      ],
      links: [
        ProgramLinkModel(
          url: 'https://ailab.example.com/infrastructure-grant',
          type: ProgramLinkType.applicationForm,
          customLabel: 'Altyapı Hibesine Başvur',
        ),
        ProgramLinkModel(
          url: 'https://ailab.example.com/guidelines',
          type: ProgramLinkType.info,
          customLabel: 'Kriter ve Şartlar',
        ),
      ],
    ),
    const ProgramModel(
      id: '7',
      slug: 'program-7',
      title: 'Sürdürülebilirlik ve Yeşil Dönüşüm İvmesi',
      summary: 'Temiz enerji, döngüsel ekonomi ve iklim teknolojileri alanında çözüm üreten girişimlerin hızlandırma programı.',
      sections: [
        ProgramSectionModel(
          id: 's7-1',
          title: 'Etki ve Sürdürülebilirlik Ölçümü',
          content: 'Karbon ayak izi ve ESG uyumluluk metriklerinin modellenmesi ve kurumsal pilot proje entegrasyonu.',
          order: 1,
        ),
        ProgramSectionModel(
          id: 's7-2',
          title: 'Kurumsal Eşleşmeler',
          content: 'Büyük ölçekli sanayi kuruluşları ve belediyeler ile PoC (Proof of Concept) iş birlikleri.',
          order: 2,
        ),
      ],
      links: [
        ProgramLinkModel(
          url: 'https://greentech.example.com/apply',
          type: ProgramLinkType.applicationForm,
          customLabel: 'Yeşil Dönüşüm Başvurusu',
        ),
      ],
    ),
  ];

  @override
  Future<List<ProgramModel>> getPrograms() async {
    // Hafif in-memory gecikme simülasyonu
    await Future.delayed(const Duration(milliseconds: 50));
    return _programs;
  }

  @override
  Future<ProgramModel?> getProgramBySlug(String slug) async {
    await Future.delayed(const Duration(milliseconds: 50));
    for (final program in _programs) {
      if (program.slug == slug) return program;
    }
    return null;
  }
}
