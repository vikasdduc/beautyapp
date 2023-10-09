import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:glamcode/data/model/home_page.dart';
import 'package:glamcode/helper/custom_cached_network_image.dart';

class ImageSlider extends StatelessWidget {
  final List<SliderImages> images;
  const ImageSlider({Key? key, required this.images}) : super(key: key);

  List<Widget> getImagesList() {
    List<Widget> imageSliderTileList = [];
    for (final SliderImages item in images) {
      imageSliderTileList.add(imageSliderTile(item));
    }
    imageSliderTileList.reversed;
    return imageSliderTileList;
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: getImagesList(),
        options: CarouselOptions(
          autoPlay: true,
          viewportFraction: 1,
          enlargeCenterPage: true,
        ));
  }
}

Widget imageSliderTile(SliderImages item) {
  return Container(
    decoration: const BoxDecoration(
      // color: Colors.red,
      borderRadius: BorderRadius.all(
        Radius.circular(16),
      ),
    ),
    clipBehavior: Clip.hardEdge,
    child: cachedNetworkImage(item.sliderImageBaseUrl ?? ""),
  );
}
