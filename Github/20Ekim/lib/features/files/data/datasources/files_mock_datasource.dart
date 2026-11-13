import '../models/file_item_model.dart';

abstract class FilesDataSource {
  Future<List<FileItemModel>> getFiles(String roleSlug);
  Future<FileItemModel> uploadFile(String roleSlug, String fileName, int sizeBytes);
}

class FilesMockDataSource implements FilesDataSource {
  final Map<String, List<FileItemModel>> _filesByRole = {};

  FilesMockDataSource() {
    _initDefaultFiles();
  }

  void _initDefaultFiles() {
    final now = DateTime.now();
    _filesByRole['mentor'] = [
      FileItemModel(
        id: 'f_m1',
        roleSlug: 'mentor',
        fileName: 'Lean_Canvas_v2.pdf',
        sizeBytes: 1024 * 340,
        uploadedAt: now.subtract(const Duration(days: 2)),
        fileType: 'pdf',
      ),
      FileItemModel(
        id: 'f_m2',
        roleSlug: 'mentor',
        fileName: 'Musteri_Gorusmeleri_Notlari.docx',
        sizeBytes: 1024 * 120,
        uploadedAt: now.subtract(const Duration(days: 5)),
        fileType: 'docx',
      ),
    ];

    _filesByRole['lawyer'] = [
      FileItemModel(
        id: 'f_l1',
        roleSlug: 'lawyer',
        fileName: 'Gizlilik_Sozlesmesi_NDA_Taslak.pdf',
        sizeBytes: 1024 * 480,
        uploadedAt: now.subtract(const Duration(days: 3)),
        fileType: 'pdf',
      ),
    ];

    _filesByRole['accountant'] = [
      FileItemModel(
        id: 'f_a1',
        roleSlug: 'accountant',
        fileName: '2026_Q1_Gider_Listesi.xlsx',
        sizeBytes: 1024 * 850,
        uploadedAt: now.subtract(const Duration(days: 1)),
        fileType: 'xlsx',
      ),
    ];

    _filesByRole['investor'] = [
      FileItemModel(
        id: 'f_i1',
        roleSlug: 'investor',
        fileName: 'Seed_Pitch_Deck_Final.pdf',
        sizeBytes: 1024 * 1024 * 4,
        uploadedAt: now.subtract(const Duration(days: 4)),
        fileType: 'pdf',
      ),
    ];

    _filesByRole['marketing'] = [
      FileItemModel(
        id: 'f_mk1',
        roleSlug: 'marketing',
        fileName: 'Sosyal_Medya_Icerik_Takvimi.pdf',
        sizeBytes: 1024 * 220,
        uploadedAt: now.subtract(const Duration(days: 6)),
        fileType: 'pdf',
      ),
    ];
  }

  @override
  Future<List<FileItemModel>> getFiles(String roleSlug) async {
    await Future.delayed(const Duration(milliseconds: 30));
    return List.from(_filesByRole[roleSlug] ?? []);
  }

  @override
  Future<FileItemModel> uploadFile(String roleSlug, String fileName, int sizeBytes) async {
    await Future.delayed(const Duration(milliseconds: 80));
    final item = FileItemModel(
      id: 'f_${DateTime.now().millisecondsSinceEpoch}',
      roleSlug: roleSlug,
      fileName: fileName,
      sizeBytes: sizeBytes,
      uploadedAt: DateTime.now(),
      fileType: fileName.split('.').last,
    );
    _filesByRole.putIfAbsent(roleSlug, () => []).insert(0, item);
    return item;
  }
}
