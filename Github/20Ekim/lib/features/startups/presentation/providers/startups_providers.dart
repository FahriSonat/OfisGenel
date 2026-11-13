import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/startups_mock_datasource.dart';
import '../../data/repositories/startups_repository_impl.dart';
import '../../domain/entities/startup.dart';
import '../../domain/repositories/startups_repository.dart';

final startupsDataSourceProvider = Provider<StartupsDataSource>((ref) {
  return StartupsMockDataSource();
});

final startupsRepositoryProvider = Provider<StartupsRepository>((ref) {
  final dataSource = ref.watch(startupsDataSourceProvider);
  return StartupsRepositoryImpl(dataSource);
});

final startupsListProvider = FutureProvider<List<Startup>>((ref) async {
  final repo = ref.watch(startupsRepositoryProvider);
  return repo.getStartups();
});

final startupDetailProvider =
    FutureProvider.family<Startup?, String>((ref, id) async {
  final repo = ref.watch(startupsRepositoryProvider);
  return repo.getStartupById(id);
});
