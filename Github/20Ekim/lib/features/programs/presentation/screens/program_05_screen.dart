import 'package:flutter/material.dart';
import '../widgets/program_scaffold.dart';

/// [Program05Screen]
/// 5. Destek Programı: Kadın Girişimci Teknoloji Teşvik Programı (/programs/program-5).
/// Ortak [ProgramScaffold] kullanarak veriyi mock kaynaktan dinamik çeker.
class Program05Screen extends StatelessWidget {
  const Program05Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProgramScaffold(slug: 'program-5');
  }
}
