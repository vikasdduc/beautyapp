import 'dart:math';

import 'package:flutter/material.dart';
import 'package:glamcode/data/model/payments/PaymentResponse.dart';
import 'package:glamcode/screen_size.dart';
import 'package:glamcode/view/screens/dashboard/dashboard_screen.dart';

class BookingSuccessScreen extends StatefulWidget {
  const BookingSuccessScreen({Key? key}) : super(key: key);

  @override
  State<BookingSuccessScreen> createState() => _BookingSuccessScreenState();
}

class _BookingSuccessScreenState extends State<BookingSuccessScreen> {
  late bool _showFrontSide;
  late bool _flipXAxis;

  @override
  void initState() {
    super.initState();
    _showFrontSide = true;
    _flipXAxis = true;
  }

  @override
  Widget build(BuildContext context) {
    final bookingResponse =
        ModalRoute.of(context)!.settings.arguments as PaymentResponseModel;

    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 249, 227, 235),
      backgroundColor: Color.fromARGB(255, 255, 255, 255), // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   title: const Text("Payment Confirmations"),
      // ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 200,
          ),
          Card(
            elevation: 0,
            // color: const Color.fromARGB(255, 217, 162, 226),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/images/verifys.png',
                      fit: BoxFit.fill,
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        "Congratulations",
                        style: TextStyle(
                            fontSize: displayHeight(context) * 0.03,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "Your Booking is Confirmed",
                        style:
                            TextStyle(fontSize: displayHeight(context) * 0.025),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (bookingResponse.coupon != null) ...[
            Card(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/images/confirm1.png',
                      fit: BoxFit.fill,
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        "Yay you just won a ${bookingResponse.coupon?.points.toString()}",
                        style:
                            TextStyle(fontSize: displayHeight(context) * 0.025),
                      ),
                      Text(
                        "Scarch Card",
                        style: TextStyle(
                            fontSize: displayHeight(context) * 0.03,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const DashboardScreen(pageIndex: 1)),
                      (route) => false);
                },
                child: _buildFlipAnimation(bookingResponse)),
          ],
          const SizedBox(
            height: 20,
          ),
          Card(
              color: const Color.fromARGB(255, 217, 162, 226),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                child: Text(
                  "Refer & Earn",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: displayHeight(context) * 0.025),
                ),
              )),
          const Text("Refer your Friend and Earn Cash"),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const DashboardScreen(pageIndex: 0)),
                      (route) => false);
                },
                child: const Card(
                    color: Color.fromARGB(255, 217, 162, 226),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Home"),
                    )),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const DashboardScreen(pageIndex: 1)),
                      (route) => false);
                },
                child: const Card(
                    color: Color.fromARGB(255, 217, 162, 226),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(" OK "),
                    )),
              ),
            ],
          )
        ],
      ),
      // bottomNavigationBar: Container(
      //   color: Colors.black,
      //   padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
      //   child: const Text(
      //     "Note- Dear customer! your timely contribution can provide this opportunity to other needed customer",
      //     style: TextStyle(color: Colors.white),
      //     textAlign: TextAlign.center,
      //   ),
      // ),
    );
  }

  Widget _buildFlipAnimation(PaymentResponseModel responseModel) {
    return GestureDetector(
      onTap: _switchCard,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 4600),
        transitionBuilder: __transitionBuilder,
        layoutBuilder: (widget, list) => Stack(children: [widget!, ...list]),
        switchInCurve: Curves.easeInBack,
        switchOutCurve: Curves.easeOutBack,
        child: _showFrontSide
            ? _buildFront()
            : _buildRear(responseModel.coupon!.couponType,
                responseModel.coupon!.points, responseModel.coupon!.coupon),
      ),
    );
  }

  Widget __transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (context, widget) {
        final isUnder = (ValueKey(_showFrontSide) != widget?.key);
        var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
        tilt *= isUnder ? -1.0 : 1.0;
        final value =
            isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
        return Transform(
          transform: _flipXAxis
              ? (Matrix4.rotationY(value)..setEntry(3, 0, tilt))
              : (Matrix4.rotationX(value)..setEntry(3, 1, tilt)),
          alignment: Alignment.center,
          child: widget,
        );
      },
    );
  }

  void _switchCard() {
    setState(() {
      _showFrontSide = !_showFrontSide;
    });
  }

  Widget _buildFront() {
    return SizedBox(
      width: 200.0,
      height: 200.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          'assets/images/Untitled design (91).png',
        ),
      ),
    );
  }

  Widget _buildRear(CouponType couponType, int? points, String? coupon) {
    String text = "";
    switch (couponType) {
      case CouponType.POINTS:
        text = "You got Rs.$points Cashback";
        break;
      case CouponType.DISCOUNT:
        text = "You got Discount $coupon";
        break;
      case CouponType.SERVICE_ADD_ON:
        text = "You got Service Add on $coupon";
        break;
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 200.0,
        height: 200.0,
        color: Colors.blue,
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20.0, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
