import '../../domain/entities/startup.dart';

class StartupModel extends Startup {
  const StartupModel({
    required super.id,
    required super.name,
    required super.tagLine,
    required super.sector,
    required super.stage,
    required super.fundingGoal,
    required super.raisedAmount,
    required super.description,
    required super.founderName,
    required super.teamSize,
    required super.mrr,
    required super.growthRate,
    required super.pitchDeckUrl,
  });

  factory StartupModel.fromMap(Map<String, dynamic> map) {
    return StartupModel(
      id: map['id'] as String,
      name: map['name'] as String,
      tagLine: map['tagLine'] as String,
      sector: map['sector'] as String,
      stage: map['stage'] as String,
      fundingGoal: (map['fundingGoal'] as num).toDouble(),
      raisedAmount: (map['raisedAmount'] as num).toDouble(),
      description: map['description'] as String,
      founderName: map['founderName'] as String,
      teamSize: map['teamSize'] as int,
      mrr: map['mrr'] as String,
      growthRate: map['growthRate'] as String,
      pitchDeckUrl: map['pitchDeckUrl'] as String? ?? 'https://example.com/pitch.pdf',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'tagLine': tagLine,
      'sector': sector,
      'stage': stage,
      'fundingGoal': fundingGoal,
      'raisedAmount': raisedAmount,
      'description': description,
      'founderName': founderName,
      'teamSize': teamSize,
      'mrr': mrr,
      'growthRate': growthRate,
      'pitchDeckUrl': pitchDeckUrl,
    };
  }
}
