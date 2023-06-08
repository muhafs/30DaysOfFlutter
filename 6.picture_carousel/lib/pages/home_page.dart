import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

import '../providers/carousel_provider.dart';

class Home extends StatelessWidget {
  const Home({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _appBody(context),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: const Text('Picture Carousel'),
      centerTitle: true,
    );
  }

  Center _appBody(BuildContext context) {
    CarouselProvider carousel = context.read<CarouselProvider>();

    return Center(
      child: CarouselSlider(
        options: CarouselOptions(
          aspectRatio: 16 / 9,
          viewportFraction: 0.6,
          enlargeCenterPage: true,
          autoPlay: true,
        ),
        items: carousel.imagePaths
            .map(
              (path) => ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  path,
                  fit: BoxFit.cover,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
