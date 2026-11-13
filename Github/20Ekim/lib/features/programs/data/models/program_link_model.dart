import '../../domain/entities/program_link.dart';

class ProgramLinkModel extends ProgramLink {
  const ProgramLinkModel({
    required super.url,
    required super.type,
    super.customLabel,
  });

  factory ProgramLinkModel.fromMap(Map<String, dynamic> map) {
    return ProgramLinkModel(
      url: map['url'] as String,
      type: ProgramLinkType.values.firstWhere(
        (t) => t.name == map['type'],
        orElse: () => ProgramLinkType.info,
      ),
      customLabel: map['customLabel'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'type': type.name,
      if (customLabel != null) 'customLabel': customLabel,
    };
  }
}
