import '../entities/program.dart';

abstract class ProgramsRepository {
  Future<List<Program>> getPrograms();
  Future<Program?> getProgramBySlug(String slug);
}
