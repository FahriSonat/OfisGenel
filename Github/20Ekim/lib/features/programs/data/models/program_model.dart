import '../../domain/entities/program.dart';
import 'program_link_model.dart';
import 'program_section_model.dart';

class ProgramModel extends Program {
  const ProgramModel({
    required super.id,
    required super.slug,
    required super.title,
    required super.summary,
    required super.sections,
    required super.links,
  });

  factory ProgramModel.fromMap(Map<String, dynamic> map) {
    return ProgramModel(
      id: map['id'] as String,
      slug: map['slug'] as String,
      title: map['title'] as String,
      summary: map['summary'] as String,
      sections: (map['sections'] as List<dynamic>)
          .map((s) => ProgramSectionModel.fromMap(s as Map<String, dynamic>))
          .toList(),
      links: (map['links'] as List<dynamic>)
          .map((l) => ProgramLinkModel.fromMap(l as Map<String, dynamic>))
          .toList(),
    );
  }
}
