import '../../domain/entities/program_section.dart';

class ProgramSectionModel extends ProgramSection {
  const ProgramSectionModel({
    required super.id,
    required super.title,
    required super.content,
    required super.order,
  });

  factory ProgramSectionModel.fromMap(Map<String, dynamic> map) {
    return ProgramSectionModel(
      id: map['id'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      order: map['order'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'order': order,
    };
  }
}
