import 'package:flutter/material.dart';
import 'profile_screen.dart';
import 'vitrin_screen.dart';


class AnaKasaEkrani extends StatelessWidget{
  final Widget ekranGovdesi;
  const AnaKasaEkrani({super.key, required this.ekranGovdesi});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body:ekranGovdesi,
      bottomNavigationBar: NavigationBar(
        selectedIndeks:_aktifIndexiBul(context),
        onDestinationSelected: (yeniIndeks){
          if(yeniIndeks==0)context.go('/vitrin');
          if(yeniIndeks==1)context.go('/profil');
        },
        destinations: [
          const NavigationDestination(icon:Icon(Icon.store), label:'Vitrin'),
          NavigationDestination(
            icon:ValueListenableBuilder(valueListenable:SepetKontrolu.ornek., builder: builder), label: label)
        ],
      ),
    );
  }

  int _aktifIndexiBul(BuildContext context){
    final String konum = GoRouterState.of(context).uri.toString.();
    if(konum.startsWith('/profil')) return 1;
    return 0;
  }
}