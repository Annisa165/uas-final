class Game {
  final int id;
  final String title;
  final String genre;
  final String platform;
  final String shortDescription;
  final String thumbnail;
  final String developer;
  final String publisher;
  final String releaseDate;
  final String gameUrl;

  Game({
    required this.id,
    required this.title,
    required this.genre,
    required this.platform,
    required this.shortDescription,
    required this.thumbnail,
    required this.developer,
    required this.publisher,
    required this.releaseDate,
    required this.gameUrl,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      genre: json['genre'] ?? '',
      platform: json['platform'] ?? '',
      shortDescription: json['short_description'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      developer: json['developer'] ?? '',
      publisher: json['publisher'] ?? '',
      releaseDate: json['release_date'] ?? '',
      gameUrl: json['game_url'] ?? '',
    );
  }

  factory Game.empty() {
    return Game(
      id: 0,
      title: '',
      genre: '',
      platform: '',
      shortDescription: '',
      thumbnail: '',
      developer: '',
      publisher: '',
      releaseDate: '',
      gameUrl: '',
    );
  }

  Game copyWith({
    int? id,
    String? title,
    String? genre,
    String? platform,
    String? shortDescription,
    String? thumbnail,
    String? developer,
    String? publisher,
    String? releaseDate,
    String? gameUrl,
  }) {
    return Game(
      id: id ?? this.id,
      title: title ?? this.title,
      genre: genre ?? this.genre,
      platform: platform ?? this.platform,
      shortDescription: shortDescription ?? this.shortDescription,
      thumbnail: thumbnail ?? this.thumbnail,
      developer: developer ?? this.developer,
      publisher: publisher ?? this.publisher,
      releaseDate: releaseDate ?? this.releaseDate,
      gameUrl: gameUrl ?? this.gameUrl,
    );
  }
}
