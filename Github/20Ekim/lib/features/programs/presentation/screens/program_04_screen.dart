import 'package:flutter/material.dart';
import '../widgets/program_scaffold.dart';

/// [Program04Screen]
/// 4. Destek Programı: Melek Yatırım Hazırlık Programı (Demo Day) (/programs/program-4).
/// Ortak [ProgramScaffold] kullanarak veriyi mock kaynaktan dinamik çeker.
class Program04Screen extends StatelessWidget {
  const Program04Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProgramScaffold(slug: 'program-4');
  }
}
