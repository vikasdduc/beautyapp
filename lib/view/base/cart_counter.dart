import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glamcode/blocs/cart/cart_bloc.dart';
import 'package:glamcode/util/dimensions.dart';
import 'package:glamcode/view/base/error_screen.dart';
import 'package:glamcode/view/base/loading_screen.dart';

import '../../data/model/packages_model/service.dart';

class CartCounter extends StatefulWidget {
  final ServicePackage? servicePackage;
  const CartCounter({Key? key, this.servicePackage}) : super(key: key);

  @override
  State<CartCounter> createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoading) {
          return const LoadingScreen();
        } else if (state is CartLoaded) {
          final isInCart = state.cart.items.containsKey(widget.servicePackage);
          if (isInCart) {
            count = state.cart.items[widget.servicePackage] ?? 0;
          }
          return (state.cart.items.containsKey(widget.servicePackage) == false)
              ? SizedBox(
                  child: Container(
                    width: 110,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                        color: const Color(0xFFA854FC),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(50, 50, 93, 0.25),
                            spreadRadius: -2,
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.3),
                            spreadRadius: -3,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ]),
                    child: OutlinedButton(
                      style: ButtonStyle(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          side: MaterialStateProperty.all(
                            const BorderSide(color: Colors.transparent),
                          ),
                          splashFactory: InkRipple.splashFactory,
                          backgroundColor: MaterialStateProperty.all(
                            const Color(0xFF882EDF),
                          )),
                      onPressed: () {
                        setState(() {
                          context
                              .read<CartBloc>()
                              .add(CartItemAdded(widget.servicePackage!));
                        });
                      },
                      child: Text(
                        "ADD",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: Dimensions.fontSizeLarge),
                      ),
                    ),
                  ),
                )
              : Container(
                  width: 110,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(50, 50, 93, 0.25),
                          spreadRadius: -2,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.3),
                          spreadRadius: -3,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                          onTap: () {
                            setState(() {
                              context
                                  .read<CartBloc>()
                                  .add(CartItemRemoved(widget.servicePackage!));
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(
                                Dimensions.PADDING_SIZE_EXTRA_SMALL),
                            child: Icon(
                              Icons.remove,
                              size: Dimensions.fontSizeOverLarge,
                              color: Colors.black,
                            ),
                          )),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.PADDING_SIZE_SMALL,
                            vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.white),
                        child: Text(
                          count.toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: Dimensions.fontSizeOverLarge),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            context
                                .read<CartBloc>()
                                .add(CartItemAdded(widget.servicePackage!));
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(
                              Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          child: Icon(
                            Icons.add,
                            size: Dimensions.fontSizeOverLarge,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
        } else {
          return const CustomError();
          // return Container();
        }
      },
    );
  }
}
