import 'package:flutter/material.dart';
import 'package:glamcode/data/model/home_page.dart';
import 'package:glamcode/helper/custom_cached_network_image.dart';
import 'package:glamcode/util/dimensions.dart';
import 'package:glamcode/view/base/golden_text.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CustomerTestimonials extends StatelessWidget {
  final List<Reviews> reviews;
  const CustomerTestimonials({Key? key, required this.reviews})
      : super(key: key);

  List<Widget> getReviewsList() {
    List<Widget> customerTestimonialCardList = [];
    for (final Reviews item in reviews) {
      customerTestimonialCardList.add(customerTestimonialCard(item));
    }
    return customerTestimonialCardList;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: CarouselSlider(
        items: getReviewsList(),
        options: CarouselOptions(
            viewportFraction: 1, autoPlay: true, enlargeCenterPage: true),
      ),
    );
  }
}

Widget customerTestimonialCard(Reviews item) {
  return Padding(
    padding:
        const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_DEFAULT),
    child: Container(
      padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL +
                Dimensions.PADDING_SIZE_EXTRA_SMALL),
            child: CircleAvatar(
              radius: 30,
              backgroundImage:
                  cachedNetworkImageProvider(item.reviewsImageUrl ?? ""),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(
                            Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        child: Text(
                          item.name ?? "User",
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 15),
                        ),
                      ),
                      const GoldenText(text: "☆ 4.5"),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(
                        Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    child: Text(
                      item.description ?? "",
                      maxLines: 3,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}
