import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/files_mock_datasource.dart';
import '../../data/repositories/files_repository_impl.dart';
import '../../domain/entities/file_item.dart';
import '../../domain/repositories/files_repository.dart';

final filesDataSourceProvider = Provider<FilesDataSource>((ref) {
  return FilesMockDataSource();
});

final filesRepositoryProvider = Provider<FilesRepository>((ref) {
  final dataSource = ref.watch(filesDataSourceProvider);
  return FilesRepositoryImpl(dataSource);
});

final filesListProvider =
    FutureProvider.family<List<FileItem>, String>((ref, roleSlug) async {
  final repo = ref.watch(filesRepositoryProvider);
  return repo.getFiles(roleSlug);
});
