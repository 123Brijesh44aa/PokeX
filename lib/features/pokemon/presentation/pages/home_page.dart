import 'package:clean_architecture_by_flutter_mapp/features/pokemon/business/entities/pokemon_entity.dart';
import 'package:clean_architecture_by_flutter_mapp/features/pokemon/presentation/providers/pokemon_state.dart';
import 'package:clean_architecture_by_flutter_mapp/features/pokemon/presentation/providers/selected_pokemon_item_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double deviceWidht = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;

    int selectedPokemonItem = ref.watch(selectedPokemonItemProvider);
    PokemonState pokemonState = ref.watch(pokemonProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref
              .read(pokemonProvider.notifier)
              .eitherFailureOrPokemon(value: "1");
          Logger().i(selectedPokemonItem.toString());
        },
        child: const Icon(Icons.cloud_download),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: SingleChildScrollView(
          child: Consumer(builder: (context, ref, child) {
            // int selectedPokemonItem = ref.watch(selectedPokemonItemProvider);
            // PokemonState pokemonState = ref.watch(pokemonProvider);

            if (pokemonState is InitialPokemonState) {
              return const Center(
                child: Text("Press Floating Action Button to Fetch Data"),
              );
            }

            if (pokemonState is PokemonLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (pokemonState is PokemonErrorState) {
              return Center(
                child: Text(pokemonState.message),
              );
            }

            if (pokemonState is PokemonLoadedState) {
              PokemonEntity pokemonEntity = pokemonState.pokemon;
              return Column(
                children: [
                  Container(
                    height: deviceHeight * 0.55,
                    width: deviceWidht,
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.1),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        border: Border.all(
                            color: Colors.black.withOpacity(0.2), width: 1)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "#${pokemonEntity.id} ${pokemonEntity.name}",
                          style: const TextStyle(
                              color: Colors.black38,
                              fontSize: 45,
                              fontWeight: FontWeight.w900),
                        ),
                        Image.network(
                          "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png",
                          height: 200,
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          height: 60,
                          width: deviceWidht * 0.8,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListView.builder(
                            itemCount: pokemonEntity.types.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Chip(
                                    backgroundColor:
                                        Colors.black.withOpacity(0.2),
                                    label: Text(
                                      pokemonEntity.types
                                          .elementAt(index)
                                          .type
                                          .name
                                          .toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black.withOpacity(0.7)),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white70),
                        ),
                        child: const Text("Random"),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white70)),
                        child: const Text("#4"),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white70),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                                horizontal: 100, vertical: 10))),
                    child: const Text(
                      "Search",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black54),
                    ),
                  )
                ],
              );
            } else {
              return const Center(
                child: Text("No Data Found"),
              );
            }
          }),
        ),
      ),
    );
  }
}
