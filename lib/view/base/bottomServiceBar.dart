import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glamcode/screen_size.dart';

import '../../blocs/cart/cart_bloc.dart';
import '../../blocs/cart_data/cart_data_bloc.dart';
import '../../util/dimensions.dart';
import '../screens/cart/cart_screen.dart';

class BottomServiceBar extends StatelessWidget {
  const BottomServiceBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartDataBloc, CartDataState>(
      builder: (context, cartState) {
        return BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoaded && cartState is CartDataLoaded) {
              return state.cart.items.isEmpty
                  ? const SizedBox()
                  : ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      // borderRadius: BorderRadius.circular(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Text("data"),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                                vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                            // color: Color(0xFF882EDF),
                            color: Colors.white,
                            child: Text(
                              cartState.cartData.originalAmount! <
                                      (cartState.cartData.mincheck ?? 0)
                                  ? "Please add items worth ${cartState.cartData.mincheck} to proceed."
                                  : context
                                              .read<CartBloc>()
                                              .getUpcomingDiscount(cartState
                                                  .cartData.originalAmount!)
                                              .amount ==
                                          null
                                      ? "Coupon Unlocked"
                                      : "Add Services of Rs ${context.read<CartBloc>().getUpcomingDiscount(cartState.cartData.originalAmount!).minimumPurchaseAmount! - cartState.cartData.originalAmount!} to unlock Coupon Code ${context.read<CartBloc>().getUpcomingDiscount(cartState.cartData.originalAmount!).title}",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: Dimensions.fontSizeSmall,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            // color: const Color(0xFFFFF1F1),

                            // color: const Color(0xFFAF73E9),
                            color: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: Dimensions.PADDING_SIZE_DEFAULT,
                                vertical: Dimensions.PADDING_SIZE_SMALL),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${state.cart.getTotalQuantity()} items(s) | ₹${cartState.cartData.originalAmount}",
                                      style: TextStyle(
                                          // color: Color(0xFF882EDF),
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              Dimensions.fontSizeExtraLarge),
                                    ),
                                    // Text(
                                    //   "Extra charges may apply.",
                                    //   style: TextStyle(
                                    //       color: Colors.white,
                                    //       fontSize:
                                    //           Dimensions.fontSizeExtraSmall),
                                    // ),
                                  ],
                                ),
                                Flexible(
                                  //   child: InkWell(
                                  // splashColor: Colors.white,
                                  // onTap: () {
                                  //   // Navigator.of(context).pushNamed('/cart');
                                  // },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal:
                                            Dimensions.PADDING_SIZE_SMALL),
                                    child: SizedBox(
                                      // decoration: BoxDecoration(),
                                      //     borderRadius:
                                      //         BorderRadius.circular(10),
                                      //     color: Color(0xFF882EDF)
                                      //         .withOpacity(0.8),
                                      //     shape: BoxShape.rectangle),
                                      // height: displayHeight(context) * 0.05,
                                      width: displayWidth(context) * 0.35,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              // if ((cartState.cartData.originalAmount !=null) &&(cartState.cartData.mincheck !=null)) {
                                              //   if (cartState.cartData.originalAmount! >=cartState.cartData.mincheck!) {
                                              if (cartState.cartData
                                                      .originalAmount !=
                                                  null) {
                                                if (cartState.cartData
                                                        .originalAmount! >=
                                                    599) {
                                                  Navigator.pushNamed(
                                                      context, '/addons');
                                                  // Navigator.push(
                                                  //     context,
                                                  //     CupertinoPageRoute(
                                                  //         builder: (context) =>
                                                  //           const  CartScreen()));
                                                  // if (primaryAddressDetails !=
                                                  //     null) {
                                                  //   Navigator.pushNamed(
                                                  //       context, '/payment');
                                                  //   /*Navigator.pushNamed(
                                                  //       context, '/addons');*/
                                                  // } else {
                                                  //   ScaffoldMessenger.of(
                                                  //           context
                                                  // )
                                                  //       .showSnackBar(
                                                  //           const SnackBar(
                                                  //     content: Text(
                                                  //         'Please select Address.'),
                                                  //     duration:
                                                  //         Duration(seconds: 1),
                                                  //   ));
                                                  // }

                                                  // } else {
                                                  //   ScaffoldMessenger.of(context)
                                                  //       .showSnackBar(SnackBar(
                                                  //     content: Text(
                                                  //         'Please add items worth ${cartState.cartData.mincheck} to proceed.'),
                                                  //     duration: const Duration(
                                                  //         seconds: 1),
                                                  //   ));
                                                  // }
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Please add items worth 599 to proceed.'),
                                                    duration: const Duration(
                                                        seconds: 1),
                                                  ));
                                                }
                                              }

                                              // Navigator.pushNamed(
                                              //     context, '/addons');
                                            },
                                            style: ElevatedButton.styleFrom(
                                              foregroundColor: Colors.white,
                                              backgroundColor: Color.fromARGB(
                                                  255, 37, 179, 56),
                                              // const Color(0xFF882EDF),
                                              animationDuration: const Duration(
                                                  milliseconds: 1000),
                                              shadowColor:
                                                  // const Color(0xFFFFF1F1),
                                                  const Color(0xFFAF73E9),
                                              elevation: 0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            child: const Text(
                                              " View Cart ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),

                                            // style: ButtonStyle(
                                            //   overlayColor:
                                            //       MaterialStateProperty
                                            //           .resolveWith(
                                            //     (states) {
                                            //       return states.contains(
                                            //               MaterialState.pressed)
                                            //           ? Color(0xFF882EDF)
                                            //           : null;
                                            //     },
                                            //   ),
                                            // ),

                                            // child: const Text(
                                            //   'Checkout',
                                            //   style: TextStyle(fontSize: 20),
                                            // ),

                                            // child: Text(
                                            //   "   Checkout ",
                                            //   style: TextStyle(
                                            //       color: Colors.white,
                                            //       fontWeight: FontWeight.bold,
                                            //       fontSize: Dimensions
                                            //           .fontSizeExtraLarge,
                                            //       shadows: const [
                                            //         Shadow(
                                            //           offset: Offset(5, 5),
                                            //           blurRadius: 70.0,
                                            //           color: Colors.black,
                                            //         ),
                                            //       ]),
                                            // ),
                                          ),
                                          // Icon(
                                          //   Icons.arrow_forward_rounded,
                                          //   color: Colors.white,
                                          // )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
            } else {
              return Container();
            }
          },
        );
      },
    );
  }
}
