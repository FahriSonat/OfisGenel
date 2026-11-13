import 'package:flutter/material.dart';
import '../widgets/program_scaffold.dart';

/// [Program06Screen]
/// 6. Destek Programı: Yapay Zeka ve Veri İnovasyon Laboratuvarı (/programs/program-6).
/// Ortak [ProgramScaffold] kullanarak veriyi mock kaynaktan dinamik çeker.
class Program06Screen extends StatelessWidget {
  const Program06Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProgramScaffold(slug: 'program-6');
  }
}
