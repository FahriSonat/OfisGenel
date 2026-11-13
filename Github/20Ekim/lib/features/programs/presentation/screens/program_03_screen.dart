import 'package:flutter/material.dart';
import '../widgets/program_scaffold.dart';

/// [Program03Screen]
/// 3. Destek Programı: Erken Aşama Hızlandırma ve Globalleşme Programı (/programs/program-3).
/// Ortak [ProgramScaffold] kullanarak veriyi mock kaynaktan dinamik çeker.
class Program03Screen extends StatelessWidget {
  const Program03Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProgramScaffold(slug: 'program-3');
  }
}
