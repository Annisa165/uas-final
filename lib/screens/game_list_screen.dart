import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';

class GameListScreen extends StatefulWidget {
  static const routeName = '/game-list';
  const GameListScreen({super.key});

  @override
  State<GameListScreen> createState() => _GameListScreenState();
}

class _GameListScreenState extends State<GameListScreen> {
  String? categoryArg;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      final arg = ModalRoute.of(context)!.settings.arguments;
      if (arg is String) categoryArg = arg;

      final provider = Provider.of<GameProvider>(context, listen: false);
      provider.fetchFromApi(category: categoryArg);

      _initialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GameProvider>(context);
    final state = provider.state;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          categoryArg != null ? 'Daftar Game: $categoryArg' : 'Daftar Game',
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => provider.fetchFromApi(category: categoryArg),
        child: Builder(
          builder: (_) {
            if (state == DataState.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state == DataState.error) {
              return Center(child: Text(provider.errorMessage));
            }

            final list = provider.allGames;
            if (list.isEmpty) {
              return const Center(child: Text('Belum ada game.'));
            }

            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: list.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (_, i) {
                final game = list[i];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: SizedBox(
                      width: 60,
                      height: 60,
                      child: Image.network(
                        game.thumbnail,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            const Icon(Icons.broken_image),
                      ),
                    ),
                    title: Text(game.title),
                    subtitle: Text('${game.genre}\n${game.releaseDate}'),
                    isThreeLine: true,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/detail-screen',
                        arguments: game.id,
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
