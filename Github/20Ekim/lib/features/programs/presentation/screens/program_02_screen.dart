import 'package:flutter/material.dart';
import '../widgets/program_scaffold.dart';

/// [Program02Screen]
/// 2. Destek Programı: KOSGEB İleri Girişimci Destek Programı (/programs/program-2).
/// Ortak [ProgramScaffold] kullanarak veriyi mock kaynaktan dinamik çeker.
class Program02Screen extends StatelessWidget {
  const Program02Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProgramScaffold(slug: 'program-2');
  }
}
