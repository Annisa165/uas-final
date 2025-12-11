import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import '../models/game.dart';

class GameFormScreen extends StatefulWidget {
  static const routeName = '/game-form';
  const GameFormScreen({super.key});

  @override
  State<GameFormScreen> createState() => _GameFormScreenState();
}

class _GameFormScreenState extends State<GameFormScreen> {
  final formKey = GlobalKey<FormState>();
  final title = TextEditingController();
  final desc = TextEditingController();
  final genre = TextEditingController();
  final platform = TextEditingController();
  final thumbnail = TextEditingController();
  final url = TextEditingController();

  int? editId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arg = ModalRoute.of(context)?.settings.arguments;
    if (arg is int && editId == null) {
      editId = arg;
      final g = Provider.of<GameProvider>(context, listen: false).getById(arg);
      if (g != null) {
        title.text = g.title;
        desc.text = g.shortDescription;
        genre.text = g.genre;
        platform.text = g.platform;
        thumbnail.text = g.thumbnail;
        url.text = g.gameUrl;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = editId != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? "Edit Game" : "Tambah Game")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: title,
                decoration: const InputDecoration(labelText: "Judul"),
              ),
              TextFormField(
                controller: desc,
                decoration: const InputDecoration(labelText: "Deskripsi"),
                maxLines: 2,
              ),
              TextFormField(
                controller: genre,
                decoration: const InputDecoration(labelText: "Genre"),
              ),
              TextFormField(
                controller: platform,
                decoration: const InputDecoration(labelText: "Platform"),
              ),
              TextFormField(
                controller: thumbnail,
                decoration: const InputDecoration(labelText: "Thumbnail URL"),
              ),
              TextFormField(
                controller: url,
                decoration: const InputDecoration(labelText: "Game URL"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (!formKey.currentState!.validate()) return;

                  final provider = Provider.of<GameProvider>(
                    context,
                    listen: false,
                  );

                  if (isEdit) {
                    provider.updateGame(
                      editId!,
                      Game(
                        id: editId!,
                        title: title.text,
                        shortDescription: desc.text,
                        genre: genre.text,
                        platform: platform.text,
                        thumbnail: thumbnail.text,
                        gameUrl: url.text,
                        publisher: "",
                        developer: "",
                        releaseDate: "",
                      ),
                    );
                  } else {
                    final newId = -DateTime.now().millisecondsSinceEpoch;
                    provider.addGame(
                      Game(
                        id: newId,
                        title: title.text,
                        shortDescription: desc.text,
                        genre: genre.text,
                        platform: platform.text,
                        thumbnail: thumbnail.text,
                        gameUrl: url.text,
                        publisher: "",
                        developer: "",
                        releaseDate: "",
                      ),
                    );
                  }

                  Navigator.pop(context);
                },
                child: Text(isEdit ? "Simpan Perubahan" : "Tambah"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
