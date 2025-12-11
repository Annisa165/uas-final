import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import '../widgets/game_card.dart';
import 'game_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GameProvider>(context, listen: false).fetchFromApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GameProvider>(context);
    final state = provider.state;

    final games = provider.allGames;

    final genres = <String>{};
    for (var g in games) {
      if (g.genre.isNotEmpty) genres.add(g.genre);
    }
    final categories = genres.toList();

    final popular = games.take(6).toList();
    final newGames = games.skip(6).take(6).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Game Catalog')),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, '/game-form'),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => provider.fetchFromApi(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Selamat Datang',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  const Text('Info game apa yang kamu butuhkan?'),

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _searchCtrl,
                          decoration: InputDecoration(
                            hintText: 'Cari game...',
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onChanged: (q) => provider.setSearchQuery(q),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () =>
                            provider.setSearchQuery(_searchCtrl.text),
                        child: const Text('Cari'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    height: 40,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (_, i) {
                        final c = categories[i];
                        return ActionChip(
                          label: Text(c),
                          onPressed: () => Navigator.pushNamed(
                            context,
                            GameListScreen.routeName,
                            arguments: c,
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 24),

                  if (state == DataState.loading)
                    const Center(child: CircularProgressIndicator())
                  else if (state == DataState.error)
                    Center(child: Text(provider.errorMessage))
                  else ...[
                    _SectionHorizontal(
                      title: 'Game Populer',
                      children: popular
                          .map((g) => GameCard(game: g, width: 140))
                          .toList(),
                    ),
                    const SizedBox(height: 24),
                    _SectionHorizontal(
                      title: 'Game Terbaru',
                      children: newGames
                          .map((g) => GameCard(game: g, width: 140))
                          .toList(),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionHorizontal extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SectionHorizontal({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 180,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: children.length,
            itemBuilder: (_, i) => children[i],
            separatorBuilder: (_, __) => const SizedBox(width: 16),
          ),
        ),
      ],
    );
  }
}
