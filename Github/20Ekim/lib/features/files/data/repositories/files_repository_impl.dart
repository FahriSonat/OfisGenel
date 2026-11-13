import '../../domain/entities/file_item.dart';
import '../../domain/repositories/files_repository.dart';
import '../datasources/files_mock_datasource.dart';

class FilesRepositoryImpl implements FilesRepository {
  final FilesDataSource _dataSource;

  const FilesRepositoryImpl(this._dataSource);

  @override
  Future<List<FileItem>> getFiles(String roleSlug) async {
    return _dataSource.getFiles(roleSlug);
  }

  @override
  Future<FileItem> uploadFile(String roleSlug, String fileName, int sizeBytes) async {
    return _dataSource.uploadFile(roleSlug, fileName, sizeBytes);
  }
}
