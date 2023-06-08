import 'package:flutter/foundation.dart';

class CarouselProvider with ChangeNotifier {
  final List<String> _imagePaths = List.generate(
    12,
    (index) => 'assets/images/image_${index + 1}.png',
  );

  List<String> get imagePaths => _imagePaths;
}
