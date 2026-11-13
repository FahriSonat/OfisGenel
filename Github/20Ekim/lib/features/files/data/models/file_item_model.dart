import '../../domain/entities/file_item.dart';

class FileItemModel extends FileItem {
  const FileItemModel({
    required super.id,
    required super.roleSlug,
    required super.fileName,
    required super.sizeBytes,
    required super.uploadedAt,
    required super.fileType,
  });

  factory FileItemModel.fromMap(Map<String, dynamic> map) {
    return FileItemModel(
      id: map['id'] as String,
      roleSlug: map['roleSlug'] as String,
      fileName: map['fileName'] as String,
      sizeBytes: map['sizeBytes'] as int,
      uploadedAt: DateTime.parse(map['uploadedAt'] as String),
      fileType: map['fileType'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'roleSlug': roleSlug,
      'fileName': fileName,
      'sizeBytes': sizeBytes,
      'uploadedAt': uploadedAt.toIso8601String(),
      'fileType': fileType,
    };
  }
}
