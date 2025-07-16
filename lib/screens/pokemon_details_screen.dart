import 'package:cached_network_image/cached_network_image.dart'
    show CachedNetworkImage;
import 'package:flutter/material.dart';

import '../models/pokemon_list_response.dart';

class PokemonDetailsScreen extends StatelessWidget {
  final Data pokemon;
  const PokemonDetailsScreen({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon.name ?? 'Unknown'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CachedNetworkImage(
                imageUrl: pokemon.images?.large ?? '',
                fit: BoxFit.cover,
                memCacheWidth: 300,
                memCacheHeight: 400,
                cacheKey: "pokemon_${pokemon.id}",
                fadeInDuration: const Duration(milliseconds: 100),
                fadeOutDuration: const Duration(milliseconds: 100),
                maxHeightDiskCache: 500,
                maxWidthDiskCache: 500,
                placeholder:
                    (context, url) => const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2.0,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                      ),
                    ),
                errorWidget:
                    (context, url, error) =>
                        const Center(child: Icon(Icons.error)),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              pokemon.name ?? 'Unknown',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            // const SizedBox(height: 5),
            Text('HP: ${pokemon.hp}', style: const TextStyle(fontSize: 16)),
            Text(
              'Supertype: ${pokemon.supertype}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Subtypes: ${pokemon.subtypes?.join(', ')}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Set: ${pokemon.set?.name} (${pokemon.set?.releaseDate})',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            CachedNetworkImage(
              imageUrl: pokemon.set?.images?.symbol ?? '',
              fit: BoxFit.cover,
              memCacheWidth: 48,
              memCacheHeight: 48,
              cacheKey: "set_${pokemon.set?.id}",
              fadeInDuration: const Duration(milliseconds: 100),
              fadeOutDuration: const Duration(milliseconds: 100),
              maxHeightDiskCache: 48,
              maxWidthDiskCache: 48,
              placeholder:
                  (context, url) => CircularProgressIndicator(
                    strokeWidth: 1.0,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                  ),
              errorWidget:
                  (context, url, error) =>
                      const Center(child: Icon(Icons.error)),
            ),
            Text(
              'Series: ${pokemon.set?.series}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              'Attacks:',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),

            if (pokemon.attacks != null && pokemon.attacks!.isNotEmpty)
              ...pokemon.attacks!.map((attack) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      attack.name ?? 'Unknown attack',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Cost: ${attack.cost?.join(', ') ?? 'None'}',
                      style: const TextStyle(fontSize: 14),
                    ),
                    Text(
                      'Damage: ${attack.damage ?? 'None'}',
                      style: const TextStyle(fontSize: 14),
                    ),
                    if (attack.text != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        'Effect: ${attack.text}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ],
                );
              })
            else
              const Text(
                'No attacks available',
                style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
              ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text('Weaknesses: '),
                if (pokemon.weaknesses != null &&
                    pokemon.weaknesses!.isNotEmpty)
                  ...pokemon.weaknesses!.map((weakness) {
                    return Text('${weakness.type} (${weakness.value})');
                  }),
              ],
            ),
            Row(
              children: [
                Text('Resistances: '),
                if (pokemon.resistances != null &&
                    pokemon.resistances!.isNotEmpty)
                  ...pokemon.resistances!.map((resistance) {
                    return Text('${resistance.type} (${resistance.value})');
                  }),
              ],
            ),
            Text(
              'Retreat Cost: ${pokemon.retreatCost != null && pokemon.retreatCost!.isNotEmpty ? pokemon.retreatCost!.join(', ') : ''}',
            ),
            const SizedBox(height: 10),
            Text('Artist: ${pokemon.artist}'),
            Text('Rarity: ${pokemon.rarity}'),
            Text('Flavor Text: ${pokemon.flavorText}'),
            const SizedBox(height: 10),
            Text(
              'Prices (TCG Players):',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              'Low: \$${pokemon.tcgplayer?.prices?.holofoil?.low}\nMid: \$${pokemon.tcgplayer?.prices?.holofoil?.mid}\nHigh: \$${pokemon.tcgplayer?.prices?.holofoil?.high}',
            ),
            const SizedBox(height: 10),
            Text(
              'Prices (Card Market):',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              'Average Sell Price: \$${pokemon.cardmarket?.prices?.averageSellPrice}\nTrend Price: \$${pokemon.cardmarket?.prices?.trendPrice}',
            ),
          ],
        ),
      ),
    );
  }
}
