enum Gender {
  male,
  female,
  other,
}

enum Language {
  arabic,
  indonesian,
  english,
  spanish,
  japanese,
}

class Setting {
  final String username;
  final Gender gender;
  final Set<Language> languages;
  final bool isEmployed;

  Setting({
    required this.username,
    required this.gender,
    required this.languages,
    required this.isEmployed,
  });
}
