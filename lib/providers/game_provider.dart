import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/game.dart';

enum DataState { idle, loading, success, error }

class GameProvider extends ChangeNotifier {
  List<Game> _apiGames = [];
  List<Game> _localGames = [];
  Game? _detailGame;

  DataState state = DataState.idle;
  DataState detailState = DataState.idle;

  String errorMessage = "";
  String _searchQuery = "";

  List<Game> get allGames {
    final all = [..._localGames, ..._apiGames];
    if (_searchQuery.isEmpty) return all;
    return all
        .where(
          (g) => g.title.toLowerCase().contains(_searchQuery.toLowerCase()),
        )
        .toList();
  }

  Game? get detailGame => _detailGame;

  void setSearchQuery(String q) {
    _searchQuery = q;
    notifyListeners();
  }

  Game? getById(int id) {
    try {
      return [..._localGames, ..._apiGames].firstWhere((g) => g.id == id);
    } catch (_) {
      return null;
    }
  }

  Future<void> fetchFromApi({String? category}) async {
    state = DataState.loading;
    notifyListeners();

    final url = category == null
        ? "https://www.freetogame.com/api/games"
        : "https://www.freetogame.com/api/games?category=$category";

    try {
      final res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        final List data = json.decode(res.body);
        _apiGames = data.map((e) => Game.fromJson(e)).toList();
        state = DataState.success;
      } else {
        state = DataState.error;
        errorMessage = "Gagal memuat data";
      }
    } catch (e) {
      state = DataState.error;
      errorMessage = e.toString();
    }

    notifyListeners();
  }

  Future<void> searchFromApi(String keyword) async {
    _searchQuery = keyword;
    notifyListeners();

    if (keyword.isEmpty) {
      fetchFromApi();
      return;
    }

    state = DataState.loading;
    notifyListeners();

    try {
      final res = await http.get(
        Uri.parse("https://www.freetogame.com/api/games"),
      );
      if (res.statusCode == 200) {
        final List data = json.decode(res.body);
        final list = data.map((e) => Game.fromJson(e)).toList();
        _apiGames = list
            .where((g) => g.title.toLowerCase().contains(keyword.toLowerCase()))
            .toList();

        state = DataState.success;
      } else {
        state = DataState.error;
      }
    } catch (e) {
      state = DataState.error;
      errorMessage = e.toString();
    }

    notifyListeners();
  }

  Future<void> fetchDetail(int id) async {
    detailState = DataState.loading;
    notifyListeners();

    final url = "https://www.freetogame.com/api/game?id=$id";

    try {
      final res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        final data = json.decode(res.body);
        _detailGame = Game.fromJson(data);
        detailState = DataState.success;
      } else {
        detailState = DataState.error;
      }
    } catch (e) {
      detailState = DataState.error;
      errorMessage = e.toString();
    }

    notifyListeners();
  }

  void addGame(Game g) {
    _localGames.add(g);
    notifyListeners();
  }

  void updateGame(int id, Game newGame) {
    final idx = _localGames.indexWhere((g) => g.id == id);
    if (idx != -1) {
      _localGames[idx] = newGame;
      notifyListeners();
    }
  }

  void deleteGame(int id) {
    _localGames.removeWhere((g) => g.id == id);
    _apiGames.removeWhere((g) => g.id == id);
    notifyListeners();
  }
}
