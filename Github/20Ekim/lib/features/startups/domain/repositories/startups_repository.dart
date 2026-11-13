import '../entities/startup.dart';

abstract class StartupsRepository {
  Future<List<Startup>> getStartups();
  Future<Startup?> getStartupById(String id);
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
  });
}
