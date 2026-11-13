import 'package:flutter/material.dart';
import '../widgets/program_scaffold.dart';

/// [Program07Screen]
/// 7. Destek Programı: Sürdürülebilirlik ve Yeşil Dönüşüm İvmesi (/programs/program-7).
/// Ortak [ProgramScaffold] kullanarak veriyi mock kaynaktan dinamik çeker.
class Program07Screen extends StatelessWidget {
  const Program07Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProgramScaffold(slug: 'program-7');
  }
}
