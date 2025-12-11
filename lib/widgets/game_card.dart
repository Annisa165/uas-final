import 'package:flutter/material.dart';
import '../models/game.dart';
import '../screens/detail_screen.dart';

class GameCard extends StatelessWidget {
  final Game game;
  final double width;
  const GameCard({super.key, required this.game, this.width = 140});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          DetailScreen.routeName,
          arguments: game.id,
        );
      },
      child: SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                height: 110,
                width: width,
                child: game.thumbnail.isNotEmpty
                    ? Image.network(
                        game.thumbnail,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          color: Colors.grey[200],
                          child: const Icon(Icons.broken_image, size: 40),
                        ),
                      )
                    : Container(
                        color: Colors.grey[200],
                        child: const Icon(Icons.videogame_asset, size: 40),
                      ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              game.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              game.genre,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
