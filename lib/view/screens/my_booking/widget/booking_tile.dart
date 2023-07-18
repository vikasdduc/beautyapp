import 'package:flutter/material.dart';
import 'package:glamcode/data/model/bookings.dart';
import 'package:glamcode/util/dimensions.dart';

class BookingTile extends StatelessWidget {
  final OngoingBookingsArr ongoingBookingsArr;
  const BookingTile({Key? key, required this.ongoingBookingsArr})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
      child: Card(
        elevation: 0,
        borderOnForeground: true,
        margin: const EdgeInsets.all(0),
        shape: const RoundedRectangleBorder(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_SMALL,
                  vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              width: double.infinity,
              child: Text(
                "Booking Id - ${ongoingBookingsArr.bookingId}",
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_SMALL,
                  vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              width: double.infinity,
              child: Text(
                "${ongoingBookingsArr.bookingDate} at ${ongoingBookingsArr.bookingTime}",
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding:
                        const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      clipBehavior: Clip.hardEdge,
                      child:
                          Image.network(ongoingBookingsArr.serviceImage ?? ""),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding:
                        const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(
                              Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          child: Text(
                            ongoingBookingsArr.serviceName ?? "",
                            style: TextStyle(
                                fontSize: Dimensions.fontSizeLarge,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(
                              Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          child: Row(
                            children: [
                              RichText(
                                text: TextSpan(
                                  text:
                                      "₹${ongoingBookingsArr.discountedPrice}   ",
                                  style: TextStyle(
                                      fontSize: Dimensions.fontSizeSmall,
                                      color: Colors.black),
                                  children: [
                                    WidgetSpan(
                                      child: Transform.translate(
                                        offset: const Offset(0.0, -4.0),
                                        child: Text(
                                          "₹${ongoingBookingsArr.serviceCharge}",
                                          style: TextStyle(
                                            fontSize:
                                                Dimensions.fontSizeExtraSmall,
                                            color: Colors.grey,
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              /*const Padding(
                                padding: EdgeInsets.only(
                                    left: Dimensions.PADDING_SIZE_SMALL),
                                child: GoldenText(
                                  text: "  ${ongoingBookingsArr.savePrice}% Off  ",
                                ),
                              ),*/
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(
                              Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          child: Row(
                            children: [
                              Icon(
                                Icons.access_time_rounded,
                                size: Dimensions.fontSizeSmall,
                              ),
                              Text(
                                "${ongoingBookingsArr.serviceTime} Minutes",
                                style: TextStyle(
                                    fontSize: Dimensions.fontSizeSmall),
                              )
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black),
                          padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.PADDING_SIZE_SMALL,
                              vertical: Dimensions.PADDING_SIZE_SMALL),
                          child:
                              Text('Status - ${ongoingBookingsArr.orderStatus}',
                                  style: const TextStyle(
                                    // background: Paint()
                                    //   ..color = Colors.black
                                    //   ..strokeWidth = Dimensions.fontSizeLarge
                                    //   ..strokeJoin = StrokeJoin.round
                                    //   ..strokeCap = StrokeCap.round
                                    //   ..style = PaintingStyle.stroke,
                                    color: Colors.white,
                                  )),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
