class Startup {
  final String id;
  final String name;
  final String tagLine;
  final String sector; // FinTech, HealthTech, B2B SaaS, AI, GreenTech vb.
  final String stage; // Pre-seed, Seed, Seri A
  final double fundingGoal;
  final double raisedAmount;
  final String description;
  final String founderName;
  final int teamSize;
  final String mrr; // Aylık Tekrarlayan Gelir
  final String growthRate; // Büyüme Oranı
  final String pitchDeckUrl;

  const Startup({
    required this.id,
    required this.name,
    required this.tagLine,
    required this.sector,
    required this.stage,
    required this.fundingGoal,
    required this.raisedAmount,
    required this.description,
    required this.founderName,
    required this.teamSize,
    required this.mrr,
    required this.growthRate,
    required this.pitchDeckUrl,
  });

  double get fundingProgress =>
      fundingGoal > 0 ? (raisedAmount / fundingGoal).clamp(0.0, 1.0) : 0.0;

  String get formattedFundingGoal =>
      '\$${(fundingGoal / 1000).toStringAsFixed(0)}K';
  String get formattedRaised => '\$${(raisedAmount / 1000).toStringAsFixed(0)}K';
}
