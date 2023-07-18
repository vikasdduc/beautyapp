import 'package:flutter/material.dart';
import 'package:glamcode/data/api/api_helper.dart';
import 'package:glamcode/view/base/error_screen.dart';
import 'package:glamcode/view/base/loading_screen.dart';
import 'package:swipe_image_gallery/swipe_image_gallery.dart';

import '../../../data/model/gallery.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({Key? key}) : super(key: key);

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> with AutomaticKeepAliveClientMixin {
  late Future<Gallery?> _future;

  @override
  void initState() {
    _future = DioClient().getGallery();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder<Gallery?>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Gallery gallery = Gallery();
            if (snapshot.hasData) {
              gallery = snapshot.data!;
              List<GalleryImages> galleryImages = gallery.galleryImages ?? [];
              List<ImageGalleryHeroProperties> heroProperties = [];
              List<Image> assets = [];

              for (var element in galleryImages) {
                heroProperties.add(ImageGalleryHeroProperties(
                    tag: element.galleryImageBaseUrl ?? ""));
                assets.add(Image.network(
                  element.galleryImageBaseUrl ?? "",
                  height: MediaQuery.of(context).size.height * 0.5,
                  fit: BoxFit.contain,
                ));
              }

              return RefreshIndicator(
                onRefresh: () async {
                  setState(() {
                    _future = DioClient.instance.getGallery();
                  });
                },
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                  itemCount: galleryImages.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => SwipeImageGallery(
                          hideStatusBar: false,
                          context: context,
                          children: assets,
                          heroProperties: heroProperties,
                          initialIndex: index)
                          .show(),
                      child: Hero(
                        tag: galleryImages[index].galleryImageBaseUrl ?? "",
                        child: Image(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              galleryImages[index].galleryImageBaseUrl ?? ""),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return const CustomError();
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingScreen();
          } else {
            return const CustomError();
          }
        });
  }

  @override
  bool get wantKeepAlive => true;
}
