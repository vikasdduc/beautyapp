
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glamcode/data/api/api_helper.dart';
import 'package:glamcode/data/model/coupons.dart';
import 'package:glamcode/data/repository/coupon_repository.dart';
import 'package:glamcode/util/dimensions.dart';
import 'package:glamcode/view/base/error_screen.dart';
import '../../../blocs/cart_data/cart_data_bloc.dart';
import '../../base/loading_screen.dart';

class CouponScreen extends StatefulWidget {
  final CouponData couponData;
  const CouponScreen({Key? key, required this.couponData}) : super(key: key);

  @override
  State<CouponScreen> createState() => _CouponScreenState();
}

class _CouponScreenState extends State<CouponScreen> {
  late Future<Coupons?> _future;

  @override
  void initState() {
    _future = DioClient.instance.getCoupons();
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text(" Coupons for you"),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "B E S T  O F F E R S  F O R  Y O U",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            Expanded(
              child: FutureBuilder<Coupons?>(
                future: _future,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const LoadingScreen();
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    Coupons couponData = const Coupons();
                    if (snapshot.hasData) {
                      couponData = snapshot.data!;
                      List<CouponData> couponsList =
                          couponData.couponData ?? [];
                      return BlocBuilder<CartDataBloc, CartDataState>(
                        builder: (context, state) {
                          if (state is CartDataLoading) {
                            return const LoadingScreen();
                          } else if (state is CartDataLoaded) {
                            return ListView.builder(
                                itemCount: couponsList.length,
                                itemBuilder: (context, index) {
                                  bool isApplied;
                                  //
                                  isApplied = state.cartData.amountToPay! >=
                                      couponsList[index]
                                          .minimumPurchaseAmount!
                                          .round();
                                  //
                                  isApplied = state.cartData.couponId ==
                                      couponsList[index].id;
                                  return couponsTile(couponsList[index],
                                      isApplied, context, state);
                                });
                          } else {
                            return const CustomError();
                          }
                        },
                      );
                    } else {
                      return const CustomError();
                    }
                  } else {
                    return const CustomError();
                  }
                },
              ),
            ),
          ],
        ));
  }
}

Widget couponsTile(CouponData couponData, bool isApplied, BuildContext context,
    CartDataLoaded state) {
  return Padding(
    padding: const EdgeInsets.only(top: 30, right: 10, left: 10),
    child: Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  // couponsTileText("Discount", couponData.title.toString()),

                  // couponsTileText(
                  //     "Discount  ",
                  //     couponData.percent == 0
                  //         ? "Rs ${couponData.amount}" " off"
                  //         : "${couponData.percent}%" " off"),
                  Text(
                    couponData.percent == 0
                        ? "Rs ${couponData.amount}" " OFF"
                        : "${couponData.percent}%" " OFF",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "  Minimum Purchase Amount ₹${couponData.minimumPurchaseAmount}",
                    style: TextStyle(
                        color: Color.fromARGB(255, 3, 63, 154),
                        fontSize: 13,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(width: 1, color: Colors.black12)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${couponData.title.toString().toUpperCase()}",
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            Divider(),
            SizedBox(
              height: 52,
              child: Center(
                child: CupertinoButton(
                  // style: isApplied
                  //     ? ButtonStyle(
                  //         backgroundColor:
                  //             MaterialStateProperty.all(Colors.green))
                  //     : ButtonStyle(
                  //         backgroundColor: MaterialStateProperty.all(
                  //             Color.fromARGB(255, 127, 3, 149))),
                  onPressed: isApplied
                      ? () {
                          CouponRepository.instance.clearCouponInstance();
                          // context.read<CartDataBloc>().add(CartDataUpdate());
                          Future.delayed(const Duration(seconds: 1), () {
                            context.read<CartDataBloc>().add(CartDataUpdate());
                          }).then((value) => Navigator.pop(context));
                        }
                      : () {
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (context) => const CartScreen()));
                          context
                              .read<CartDataBloc>()
                              .add(CartCouponUpdate(couponData));
                          Future.delayed(const Duration(seconds: 1), () {
                            context.read<CartDataBloc>().add(CartDataUpdate());
                          }).then((value) => Navigator.pop(context));
                        },
                  child: isApplied
                      ? Text(
                          "✅  A P P L I E D",
                          style: TextStyle(
                              fontSize: Dimensions.fontSizeExtraLarge,
                              color: Colors.green,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold),
                        )
                      : Text(
                          "T A P  T O  A P P L Y ",
                          style: TextStyle(
                              fontSize: Dimensions.fontSizeExtraLarge,
                              color: Color.fromARGB(255, 3, 63, 154),
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w500),
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

Widget couponsTileText(String title, String text) {
  return Padding(
    padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_EXTRA_SMALL),
    child: RichText(
      text: TextSpan(
        text: title,
        style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: Dimensions.fontSizeLarge,
            color: Colors.black),
        children: [
          TextSpan(
            text: text,
            style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: Dimensions.fontSizeLarge,
                color: Colors.black),
          )
        ],
      ),
    ),
  );
}
