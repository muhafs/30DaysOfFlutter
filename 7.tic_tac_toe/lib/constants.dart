import 'dart:math';

enum BoardTypes { x, o, e }

List<List<BoardTypes>> chunk(List<BoardTypes> list, int size) {
  return List.generate(
    (list.length / size).ceil(),
    (index) => list.sublist(
      index * size,
      min(index * size + size, list.length),
    ),
  );
}
