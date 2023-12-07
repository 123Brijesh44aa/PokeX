import 'package:clean_architecture_by_flutter_mapp/features/pokemon/presentation/pages/data_page.dart';
import 'package:clean_architecture_by_flutter_mapp/features/pokemon/presentation/pages/home_page.dart';
import 'package:clean_architecture_by_flutter_mapp/features/skeleton/providers/bottom_navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class PokemonSkeleton extends ConsumerStatefulWidget {
  const PokemonSkeleton({super.key});

  @override
  PokemonSkeletonState createState() {
    return PokemonSkeletonState();
  }
}


class PokemonSkeletonState extends ConsumerState<PokemonSkeleton> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final selectedIndex = ref.watch(bottomNavigationProvider);

    List<BottomNavigationBarItem> navigationItems = <BottomNavigationBarItem>[
      const BottomNavigationBarItem(
        icon: Icon(Icons.home_outlined),
        label: "Home"
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.menu),
        label: "PokeInfo"
      )
    ];

    List<Widget> navigationPages = <Widget>[
      const HomePage(),
      const DataPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Pokedex Pro",
          style: TextStyle(color: Colors.black.withOpacity(0.7), fontWeight: FontWeight.bold,),
        ),
        backgroundColor: Colors.white,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: navigationItems,
        currentIndex: selectedIndex,
        onTap: (index) {
          ref.read(bottomNavigationProvider.notifier).changeIndex(newNumber: index);
        },
      ),
      body: navigationPages[selectedIndex],
    );
  }
}
