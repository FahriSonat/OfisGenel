import '../../domain/entities/program.dart';
import '../../domain/repositories/programs_repository.dart';
import '../datasources/programs_mock_datasource.dart';

class ProgramsRepositoryImpl implements ProgramsRepository {
  final ProgramsDataSource _dataSource;

  const ProgramsRepositoryImpl(this._dataSource);

  @override
  Future<List<Program>> getPrograms() async {
    return _dataSource.getPrograms();
  }

  @override
  Future<Program?> getProgramBySlug(String slug) async {
    return _dataSource.getProgramBySlug(slug);
  }
}
