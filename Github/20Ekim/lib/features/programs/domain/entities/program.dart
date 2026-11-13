import 'program_link.dart';
import 'program_section.dart';

class Program {
  final String id;
  final String slug;
  final String title;
  final String summary;
  final List<ProgramSection> sections;
  final List<ProgramLink> links;

  const Program({
    required this.id,
    required this.slug,
    required this.title,
    required this.summary,
    required this.sections,
    required this.links,
  });
}
