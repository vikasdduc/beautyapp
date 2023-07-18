import 'package:flutter/material.dart';
import 'package:glamcode/data/model/packages_model/service.dart';
import 'package:glamcode/util/convertHtmlToString.dart';
import 'package:glamcode/util/dimensions.dart';
import 'package:glamcode/view/base/golden_text.dart';
import 'package:glamcode/view/screens/packages/package_info.dart';

import 'cart_counter.dart';

class PackageTile extends StatelessWidget {
  final ServicePackage servicePackage;

  const PackageTile({Key? key, required this.servicePackage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding:
            const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
        child: Card(
          elevation: 20,
          borderOnForeground: true,
          margin: const EdgeInsets.all(0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                          Dimensions.PADDING_SIZE_DEFAULT,
                          Dimensions.PADDING_SIZE_DEFAULT,
                          0,
                          Dimensions.PADDING_SIZE_DEFAULT),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(
                                Dimensions.PADDING_SIZE_EXTRA_SMALL),
                            child: Text(
                              servicePackage.name ?? "",
                              style: TextStyle(
                                  fontSize: Dimensions.fontSizeLarge,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.fade),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "₹${servicePackage.discountedPrice}   ",
                                  style: TextStyle(
                                      fontSize: Dimensions.fontSizeDefault,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.fade),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "₹${servicePackage.price}",
                                      style: TextStyle(
                                          fontSize: Dimensions.fontSizeSmall,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                          decoration:
                                              TextDecoration.lineThrough,
                                          overflow: TextOverflow.fade),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: Dimensions.PADDING_SIZE_SMALL),
                                      child: GoldenText(
                                        text:
                                            "  ${servicePackage.discount}% Off  ",
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // Text(),
                          // Padding(
                          //   padding: const EdgeInsets.all(
                          //       Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          //   child: Row(
                          //     children: [
                          //       // RichText(
                          //       //   text: TextSpan(
                          //       //     text:
                          //       //     //     "₹${servicePackage.discountedPrice}   ",
                          //       //     // style: TextStyle(
                          //       //     //     fontSize: Dimensions.fontSizeDefault,
                          //       //     //     color: Colors.black,
                          //       //     //     fontWeight: FontWeight.bold,
                          //       //     //     overflow: TextOverflow.fade),
                          //       //     // children: [
                          //       //     //   TextSpan(
                          //       //     //     text: "₹${servicePackage.price}",
                          //       //     //     style: TextStyle(
                          //       //     //         fontSize: Dimensions.fontSizeSmall,
                          //       //     //         color: Colors.grey,
                          //       //     //         decoration:
                          //       //     //             TextDecoration.lineThrough,
                          //       //     //         overflow: TextOverflow.fade),
                          //       //     //   ),
                          //       //     // ],
                          //       //   ),
                          //       // ),

                          //       // Padding(
                          //       //   padding: const EdgeInsets.only(
                          //       //       left: Dimensions.PADDING_SIZE_SMALL),
                          //       //   child: GoldenText(
                          //       //     text: "  ${servicePackage.discount}% Off  ",
                          //       //   ),
                          //       // ),
                          //     ],
                          //   ),

                          // ),

                          const SizedBox(
                            height: 5,
                          ),

                          Padding(
                            padding: const EdgeInsets.all(
                                Dimensions.PADDING_SIZE_EXTRA_SMALL),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.access_time_rounded,
                                  color: Colors.grey,
                                  size: Dimensions.fontSizeSmall,
                                ),
                                RichText(
                                    text: TextSpan(
                                  text: " ${servicePackage.time} Minutes",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: Dimensions.fontSizeSmall,
                                      overflow: TextOverflow.fade),
                                ))
                              ],
                            ),
                          ),
                          Text(
                            "Services :-",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: Dimensions.fontSizeLarge,
                                overflow: TextOverflow.fade),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(
                              Dimensions.PADDING_SIZE_SMALL),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            clipBehavior: Clip.hardEdge,
                            child: Hero(
                              tag: servicePackage.slug ?? "",
                              child: Image.network(
                                  servicePackage.serviceImageUrl ?? ""),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 1),
                          child: CartCounter(
                            servicePackage: servicePackage,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                        convertHtmlToString(servicePackage.description ?? "")
                            .map(
                              (e) => Padding(
                                padding: const EdgeInsets.all(
                                  Dimensions.PADDING_SIZE_EXTRA_EXTRA_SMALL,
                                ),
                                child: Text(
                                  "\u2022 $e",
                                ),
                              ),
                            )
                            .toList(),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: OutlinedButton(
                    style: ButtonStyle(
                      
                        splashFactory: InkRipple.splashFactory,
                        backgroundColor: MaterialStateProperty.all(
                          const Color(0xFF882EDF),
                        )),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PackageInfo(
                                servicePackage: servicePackage,
                              )));
                    },
                    child: Text(
                      "View Details",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: Dimensions.fontSizeLarge),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
