import '../entities/file_item.dart';

abstract class FilesRepository {
  Future<List<FileItem>> getFiles(String roleSlug);
  Future<FileItem> uploadFile(String roleSlug, String fileName, int sizeBytes);
}
