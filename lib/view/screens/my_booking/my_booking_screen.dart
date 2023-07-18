import 'package:flutter/material.dart';
import 'package:glamcode/data/api/api_helper.dart';
import 'package:glamcode/data/model/bookings.dart';
import 'package:glamcode/view/base/error_screen.dart';
import 'package:glamcode/view/screens/my_booking/widget/booking_tile.dart';

import '../../base/loading_screen.dart';

class MyBookingScreen extends StatefulWidget {
  const MyBookingScreen({Key? key}) : super(key: key);

  @override
  State<MyBookingScreen> createState() => _MyBookingScreenState();
}

class _MyBookingScreenState extends State<MyBookingScreen> {
  late Future<BookingsModel?> _future;

  @override
  void initState() {
    _future = DioClient.instance.getBookings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<BookingsModel?>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.connectionState == ConnectionState.done) {
          BookingsModel bookingsModelData = BookingsModel();
          if (snapshot.hasData) {
            bookingsModelData = snapshot.data!;
            List<OngoingBookingsArr> ongoingBookingsArrList =
                bookingsModelData.ongoingBookingsArr ?? [];
            return RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  _future = DioClient.instance.getBookings();
                });
              },
              child: ListView.builder(
                  itemCount: ongoingBookingsArrList.length,
                  itemBuilder: (context, index) {
                    return BookingTile(
                      ongoingBookingsArr: ongoingBookingsArrList[index],
                    );
                  }),
            );
          } else {
            return const CustomError();
          }
        } else {
          return const CustomError();
        }
      },
    );
  }
}
