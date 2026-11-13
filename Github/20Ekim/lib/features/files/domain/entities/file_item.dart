class FileItem {
  final String id;
  final String roleSlug;
  final String fileName;
  final int sizeBytes;
  final DateTime uploadedAt;
  final String fileType;

  const FileItem({
    required this.id,
    required this.roleSlug,
    required this.fileName,
    required this.sizeBytes,
    required this.uploadedAt,
    required this.fileType,
  });

  String get formattedSize {
    if (sizeBytes < 1024) return '$sizeBytes B';
    if (sizeBytes < 1024 * 1024) return '${(sizeBytes / 1024).toStringAsFixed(1)} KB';
    return '${(sizeBytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  String get formattedDate {
    return '${uploadedAt.day.toString().padLeft(2, '0')}.${uploadedAt.month.toString().padLeft(2, '0')}.${uploadedAt.year}';
  }
}
