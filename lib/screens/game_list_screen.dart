import 'package:flutter/material.dart';
import 'package:uts/data/dummy_data.dart';
import 'package:uts/models/game_model.dart';
import 'package:uts/screens/detail_screen.dart';

class GameListScreen extends StatelessWidget {
  static const routeName = '/game-list';

  const GameListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)!.settings.arguments as String;

    final filteredGames = dummyGames
        .where((game) => game.categories.contains(category))
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text('Daftar Game: $category')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: filteredGames.length,
        itemBuilder: (ctx, index) {
          final game = filteredGames[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  game.iconUrl,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                game.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('${game.genre}\n${game.releaseDate}'),
              trailing: const Icon(Icons.chevron_right),
              isThreeLine: true,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  DetailScreen.routeName,
                  arguments: game.id,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
