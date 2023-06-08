class PokemonDetail {
  int id;
  String name;
  String description;
  int height;
  int weight;
  List<String> types;

  String get imgUrl =>
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';

  PokemonDetail({
    required this.id,
    required this.name,
    required this.description,
    required this.height,
    required this.weight,
    required this.types,
  });

  factory PokemonDetail.fromJson(Map<String, dynamic> json) {
    return PokemonDetail(
      id: json['id'],
      name: json['name'],
      description: json['flavor_text_entries'][0]['flavor_text'],
      height: json['height'],
      weight: json['weight'],
      types: (json['types'] as List)
          .map((type) => type['type']['name'] as String)
          .toList(),
    );
  }
}
