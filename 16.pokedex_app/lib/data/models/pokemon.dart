class Pokemon {
  int? id;
  String? name;

  String get imageUrl =>
      "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png";

  Pokemon({
    this.id,
    this.name,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) => Pokemon(
        id: int.parse((json["url"] as String).split('/')[6]),
        name: json["name"],
      );
}
