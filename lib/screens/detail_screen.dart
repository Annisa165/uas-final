import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../providers/game_provider.dart';
import '../models/game.dart';

class DetailScreen extends StatefulWidget {
  static const routeName = '/detail-screen';
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int? gameId;
  bool init = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!init) {
      final arg = ModalRoute.of(context)?.settings.arguments;
      if (arg is int) {
        gameId = arg;
        if (gameId! > 0) {
          Provider.of<GameProvider>(
            context,
            listen: false,
          ).fetchDetail(gameId!);
        }
      }
      init = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GameProvider>(context);
    final detailState = provider.detailState;

    if (gameId != null && gameId! < 0) {
      final local = provider.getById(gameId!);
      return _buildUI(context, local!, true);
    }

    if (detailState == DataState.loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (detailState == DataState.error) {
      return Scaffold(body: Center(child: Text(provider.errorMessage)));
    }

    final g = provider.detailGame;
    if (g == null) {
      return const Scaffold(body: Center(child: Text("Tidak ditemukan")));
    }

    return _buildUI(context, g, false);
  }

  Widget _buildUI(BuildContext context, Game game, bool local) {
    return Scaffold(
      appBar: AppBar(
        title: Text(game.title),
        actions: [
          if (local)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.pushNamed(context, "/game-form", arguments: game.id);
              },
            ),
          if (local)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                Provider.of<GameProvider>(
                  context,
                  listen: false,
                ).deleteGame(game.id);
                Navigator.pop(context);
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              game.thumbnail,
              height: 220,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    game.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(game.shortDescription),
                  const SizedBox(height: 12),
                  Text("Genre: ${game.genre}"),
                  Text("Platform: ${game.platform}"),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (await canLaunchUrl(Uri.parse(game.gameUrl))) {
                        launchUrl(
                          Uri.parse(game.gameUrl),
                          mode: LaunchMode.externalApplication,
                        );
                      }
                    },
                    child: const Text("Kunjungi Situs Game"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
