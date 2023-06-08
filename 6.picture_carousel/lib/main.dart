import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/home_page.dart';
import 'providers/carousel_provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CarouselProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Picture Carousel',
        theme: ThemeData.dark(),
        home: const Home(),
      ),
    );
  }
}
