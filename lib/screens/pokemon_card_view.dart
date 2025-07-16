import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/pokemon_list_response.dart';
import 'pokemon_details_screen.dart';

class PokemonCardView extends StatelessWidget {
  final Data pokemon;
  PokemonCardView({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Card(
      key: ValueKey(pokemon.id),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: TextButton(
        onPressed: () {
          gotoNext(PokemonDetailsScreen(pokemon: pokemon), context);
        },
        style: TextButton.styleFrom(
          backgroundColor: Colors.transparent,
          padding: EdgeInsets.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child:
                  pokemon.images?.small != null
                      ? ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(12),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: pokemon.images!.small!,
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
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.grey,
                                  ),
                                ),
                              ),
                          errorWidget:
                              (context, url, error) =>
                                  const Center(child: Icon(Icons.error)),
                        ),
                      )
                      : const Center(
                        child: Icon(
                          Icons.image_not_supported,
                          size: 50,
                          color: Colors.grey,
                        ),
                      ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pokemon.name ?? 'Unknown',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Object?> gotoNext(Widget v, BuildContext context) async {
    return await Navigator.push(
      context,
      MaterialPageRoute(builder: (mContext) => v),
    );
  }
}
