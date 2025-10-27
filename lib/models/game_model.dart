class Game {
  final String id;
  final String title;
  final String genre;
  final String developer;
  final String releaseDate;
  final String description;
  final String bannerUrl;
  final String iconUrl;
  final List<String> categories;
  final List<String> screenshots;
  final SystemRequirements requirements;
  final bool isPopular;
  final bool isNew;

  Game({
    required this.id,
    required this.title,
    required this.genre,
    required this.developer,
    required this.releaseDate,
    required this.description,
    required this.bannerUrl,
    required this.iconUrl,
    required this.categories,
    required this.screenshots,
    required this.requirements,
    this.isPopular = false,
    this.isNew = false,
  });
}

class SystemRequirements {
  final String os;
  final String processor;
  final String memory;
  final String graphics;
  final String storage;

  SystemRequirements({
    required this.os,
    required this.processor,
    required this.memory,
    required this.graphics,
    required this.storage,
  });
}
