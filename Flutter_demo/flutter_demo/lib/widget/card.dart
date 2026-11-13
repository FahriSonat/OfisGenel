import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UrunCart extends StatelessWidget {
  final Urun urun;
  final VoidCallback onAddToCart;
  final VoidCallback onDetayTiklandi;

  const UrunCart({
    super.key,
    required this.urun,
    required this.onAddToCart,
    required this.onDetayTiklandi,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: ,
    );
  }
}
