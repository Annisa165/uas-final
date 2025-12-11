import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/game.dart';

class GameService {
  static const String baseUrl = 'https://www.freetogame.com/api/games';

  Future<List<Game>> fetchGames({String? platform, String? category}) async {
    final params = <String, String>{};
    if (platform != null && platform.isNotEmpty) params['platform'] = platform;
    if (category != null && category.isNotEmpty) params['category'] = category;

    final uri = Uri.parse(
      baseUrl,
    ).replace(queryParameters: params.isEmpty ? null : params);
    final resp = await http.get(uri).timeout(const Duration(seconds: 10));
    if (resp.statusCode != 200) {
      throw Exception('Failed to load games: ${resp.statusCode}');
    }
    final List<dynamic> body = json.decode(resp.body);
    return body.map((e) => Game.fromJson(e as Map<String, dynamic>)).toList();
  }
}
