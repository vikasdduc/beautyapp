import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glamcode/data/api/api_helper.dart';
import 'package:glamcode/data/model/addon_model/addon_datum.dart';
import 'package:glamcode/view/base/error_screen.dart';

import '../../../blocs/addon/addon_bloc.dart';
import '../../../blocs/cart_data/cart_data_bloc.dart';
import '../../../data/model/addon_model/addon_model.dart';
import '../../../util/dimensions.dart';
import '../../base/loading_screen.dart';
import '../cart/cart_screen.dart';

class AddonsScreen extends StatefulWidget {
  const AddonsScreen({Key? key}) : super(key: key);

  @override
  State<AddonsScreen> createState() => _AddonsScreenState();
}

class _AddonsScreenState extends State<AddonsScreen> {
  final int _selectedIndex = 0;
  late Future<AddonModel?> _future;

  @override
  void initState() {
    _future = DioClient.instance.getAddons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SELECT ADD-ONS"),
      ),
      body: FutureBuilder<AddonModel?>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingScreen();
          } else if (snapshot.connectionState == ConnectionState.done) {
            AddonModel addonData = const AddonModel();
            if (snapshot.hasData) {
              addonData = snapshot.data!;

              List<AddonDatum> addonList = addonData.addonData ?? [];
              return BlocBuilder<AddonBloc, AddonState>(
                builder: (context, state) {
                  if (state is AddonLoading) {
                    return const LoadingScreen();
                  } else if (state is AddonLoaded) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: addonList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          isThreeLine: false,
                          dense: true,
                          style: ListTileStyle.drawer,
                          tileColor: state.addonList.contains(addonList[index])
                              ? const Color(0xFFA854FC)
                              : Colors.white,
                          onTap: () {
                            setState(() {
                              state.addonList.contains(addonList[index])
                                  ? context
                                      .read<AddonBloc>()
                                      .add(AddonItemRemoved(addonList[index]))
                                  : context
                                      .read<AddonBloc>()
                                      .add(AddonItemAdded(addonList[index]));
                            });
                          },
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${addonList[index].name}",
                                style: TextStyle(
                                    fontSize: Dimensions.fontSizeLarge,
                                    color: state.addonList
                                            .contains(addonList[index])
                                        ? Colors.white
                                        : Colors.black),
                              ),
                              Text(
                                "₹${addonList[index].price}",
                                style: TextStyle(
                                    fontSize: Dimensions.fontSizeLarge,
                                    color: state.addonList
                                            .contains(addonList[index])
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            ],
                          ),
                        );
                      },
                    );
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
      bottomNavigationBar: BlocBuilder<CartDataBloc, CartDataState>(
        builder: (context, cartState) {
          if (cartState is CartDataLoading) {
            return const LoadingScreen();
          } else if (cartState is CartDataLoaded) {
            return BottomAppBar(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Total Price",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Rs. ${cartState.cartData.originalAmount}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      child: Padding(
                    padding:
                        const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: const Color(0xFFA854FC),
                            minimumSize: const Size(double.infinity,
                                Dimensions.PADDING_SIZE_DEFAULT),
                            padding: const EdgeInsets.symmetric(
                                vertical: Dimensions.PADDING_SIZE_DEFAULT),
                            textStyle: TextStyle(
                                fontSize: Dimensions.fontSizeExtraLarge)),
                        onPressed: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => const CartScreen()));
                         
                        },
                        child: const Text("Next")),
                  ))
                ],
              ),
            );
          } else {
            return const CustomError();
          }
        },
      ),
    );
  }
}
