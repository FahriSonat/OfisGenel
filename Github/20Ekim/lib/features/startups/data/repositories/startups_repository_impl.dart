import '../../domain/entities/startup.dart';
import '../../domain/repositories/startups_repository.dart';
import '../datasources/startups_mock_datasource.dart';

class StartupsRepositoryImpl implements StartupsRepository {
  final StartupsDataSource _dataSource;

  const StartupsRepositoryImpl(this._dataSource);

  @override
  Future<List<Startup>> getStartups() async {
    return _dataSource.getStartups();
  }

  @override
  Future<Startup?> getStartupById(String id) async {
    return _dataSource.getStartupById(id);
  }

  @override
  Future<Startup> createStartup({
    required String name,
    required String tagLine,
    required String sector,
    required String stage,
    required double fundingGoal,
    required String description,
    required String founderName,
    required int teamSize,
    required String mrr,
    required String growthRate,
  }) async {
    return _dataSource.createStartup(
      name: name,
      tagLine: tagLine,
      sector: sector,
      stage: stage,
      fundingGoal: fundingGoal,
      description: description,
      founderName: founderName,
      teamSize: teamSize,
      mrr: mrr,
      growthRate: growthRate,
    );
  }
}
