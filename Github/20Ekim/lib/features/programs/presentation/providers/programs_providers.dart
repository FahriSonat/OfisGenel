import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/programs_mock_datasource.dart';
import '../../data/repositories/programs_repository_impl.dart';
import '../../domain/entities/program.dart';
import '../../domain/repositories/programs_repository.dart';

final programsDataSourceProvider = Provider<ProgramsDataSource>((ref) {
  return ProgramsMockDataSource();
});

final programsRepositoryProvider = Provider<ProgramsRepository>((ref) {
  final dataSource = ref.watch(programsDataSourceProvider);
  return ProgramsRepositoryImpl(dataSource);
});

final programsListProvider = FutureProvider<List<Program>>((ref) async {
  final repository = ref.watch(programsRepositoryProvider);
  return repository.getPrograms();
});

final programDetailProvider =
    FutureProvider.family<Program?, String>((ref, slug) async {
  final repository = ref.watch(programsRepositoryProvider);
  return repository.getProgramBySlug(slug);
});
