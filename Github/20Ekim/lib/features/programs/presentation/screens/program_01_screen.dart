import 'package:flutter/material.dart';
import '../widgets/program_scaffold.dart';

/// [Program01Screen]
/// 1. Destek Programı: TÜBİTAK 1512 BİGG Girişimcilik Programı (/programs/program-1).
/// Ortak [ProgramScaffold] kullanarak veriyi mock kaynaktan dinamik çeker.
class Program01Screen extends StatelessWidget {
  const Program01Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProgramScaffold(slug: 'program-1');
  }
}
