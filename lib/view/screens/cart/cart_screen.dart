import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glamcode/blocs/cart_data/cart_data_bloc.dart';
import 'package:glamcode/data/model/auth.dart';
import 'package:glamcode/data/model/coupons.dart';
import 'package:glamcode/data/model/packages_model/service.dart';
import 'package:glamcode/data/model/user.dart';
import 'package:glamcode/data/repository/coupon_repository.dart';
import 'package:glamcode/main.dart';
import 'package:glamcode/util/dimensions.dart';
import 'package:glamcode/view/base/custom_divider.dart';
import 'package:glamcode/view/base/error_screen.dart';
import 'package:glamcode/view/base/package_tile.dart';
import 'package:glamcode/view/screens/address/address_screen.dart';
import 'package:glamcode/view/screens/coupon/coupon_screen.dart';
import '../../../blocs/auth/auth_bloc.dart';
import '../../../blocs/cart/cart_bloc.dart';
import '../../../data/api/api_helper.dart';
import '../../../data/model/address_details_model.dart';
import '../../../data/model/checkUserExist.dart';
import '../../../home.dart';
import '../../base/loading_screen.dart';
import '../home/map_location/searchLocationMap.dart';
import '../payment/payment_screen.dart';
import 'package:http/http.dart' as http;

int checkedauth = 0;

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late Future<AddressDetailsModel?> _future;
  DioClient dio = DioClient.instance;
  bool useWallet = true;
  late final AuthBloc authBloc;
  late User user;

  User? currentUser;
  String? checkUserString;

  initialize() async {
    final Auth auth = Auth.instance;
    currentUser = await auth.currentUser;
  }

  checkUser() async {
    if (currentUser!.id != null) {
      Map<String, dynamic> data = {
        "user_id": currentUser!.id.toString(),
      };
      String jsonData = json.encode(data);

      try {
        final response = await http.post(
          Uri.parse("https://admin.glamcode.in/api/user-avail"),
          body: jsonData,
          headers: {
            'Content-Type': 'application/json',
          },
        );

        if (response.statusCode == 200) {
          CheckUserExist checkUserExist =
              CheckUserExist.fromJson(json.decode(response.body));
          log("log(checkUserExist.isExist.toString());");
          log(checkUserExist.isExist.toString());
          if (checkUserExist.isExist == false) {
            log("User Not Found in Data Base- Deleting the User from app");
            // dio.deleteUser();
            context.read<CartBloc>().add(CartCleared());
            final AuthBloc authBloc = context.read<AuthBloc>();
            authBloc.userRepository.signOut();
            authBloc.add(AppLoaded());
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => Home(authBloc: authBloc)),
                ModalRoute.withName('/index'));
          }
        } else {
          // Handle error response
          print('Request failed with status: ${response.statusCode}');
          // You might want to update state or show an error message here
        }
      } catch (error) {
        // Handle other errors
        print('Error: $error');
        // You might want to update state or show an error message here
      }
    }
  }

  @override
  void initState() {
    initialize();

    user = const User();
    CouponRepository.instance.clearCouponInstance();
    context.read<CartDataBloc>().add(CartDataUpdate());
    _future = DioClient.instance.getAddress();
    facebookAppEvents.logEvent(
      name: 'Visited Cart',
      parameters: {
        'visited cart': 'visited to final cart page',
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.connectionState == ConnectionState.done) {
          AddressDetailsModel addressData = AddressDetailsModel();
          if (snapshot.hasData) {
            addressData = snapshot.data!;
            List<AddressDetails> addressList = addressData.addressDetails ?? [];
            AddressDetails? primaryAddressDetails;
            for (var element in addressList) {
              if (element.isPrimary != null && element.isPrimary!) {
                primaryAddressDetails = element;
              }
            }
            return BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                if (state is CartLoading) {
                  return const LoadingScreen();
                } else if (state is CartLoaded) {
                  Map<ServicePackage, int> cart = state.cart.items;
                  List<ServicePackage> keysList = cart.keys
                      .toList(); // getting all keys of your map into a list
                  return BlocBuilder<CartDataBloc, CartDataState>(
                    builder: (context, cartState) {
                      if (cartState is CartDataLoading) {
                        return const LoadingScreen();
                      } else if (cartState is CartDataLoaded) {
                        return Scaffold(
                          appBar: AppBar(
                            elevation: 0,
                            title: const Text(
                              "Summary",
                              style: TextStyle(),
                            ),
                          ),
                          body: SingleChildScrollView(
                            child: cart.isNotEmpty
                                ? Column(
                                    children: [
                                      // const CustomDivider(),

                                      primaryAddressDetails != null ||
                                              addressList[0].address != null
                                          ? InkWell(
                                              onTap: () {
                                                // Navigator.of(context).push(
                                                //     MaterialPageRoute(
                                                //         builder: (context) =>
                                                //             const AddressDetailsScreen()));
                                                showModalBottomSheet(
                                                    isScrollControlled: true,
                                                    useSafeArea: true,
                                                    enableDrag: true,
                                                    showDragHandle: true,
                                                    shape: const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        12),
                                                                topRight: Radius
                                                                    .circular(
                                                                        12))),
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return StatefulBuilder(
                                                          builder: (BuildContext
                                                                  context,
                                                              StateSetter
                                                                  setstate) {
                                                        return AddressDetailsScreen();
                                                      });
                                                    });
                                              },
                                              child: ListTile(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                  30,
                                                                ),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        30))),
                                                tileColor: Colors.white,
                                                title: Text(
                                                  primaryAddressDetails
                                                          ?.addressHeading ??
                                                      addressList[0]
                                                          .address
                                                          .toString() ??
                                                      "",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                subtitle: Text(
                                                  primaryAddressDetails
                                                          ?.street ??
                                                      addressList[0]
                                                          .address
                                                          .toString() ??
                                                      "",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                leading: const Icon(
                                                    Icons.location_on_outlined),
                                                trailing: const Icon(
                                                    Icons.arrow_drop_down),
                                                // trailing: TextButton(
                                                //   onPressed: () {
                                                //     Navigator.of(context).push(
                                                //         MaterialPageRoute(
                                                //             builder: (context) =>
                                                //                 const AddressDetailsScreen()));
                                                //   },
                                                //   style: ButtonStyle(
                                                //     minimumSize:
                                                //         MaterialStateProperty.all(
                                                //       const Size(0, 0),
                                                //     ),
                                                //     padding:
                                                //         MaterialStateProperty.all(
                                                //       const EdgeInsets.all(
                                                //         Dimensions
                                                //             .PADDING_SIZE_SMALL,
                                                //       ),
                                                //     ),
                                                //   ),
                                                //   child: Text(
                                                //     "Change",
                                                //     style: TextStyle(
                                                //       fontSize: Dimensions
                                                //           .fontSizeDefault,
                                                //     ),
                                                //   ),
                                                // ),
                                                dense: true,
                                                minLeadingWidth: 0,
                                              ),
                                            )
                                          : InkWell(
                                              onTap: () {
                                                setState(() {});

                                                print("currentUser!.id");
                                                if (currentUser!.id == 0) {
                                                  // Navigator
                                                  //     .pushReplacementNamed(
                                                  //         context, '/index');
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              SearchLocationScreen(
                                                                edit: false,
                                                                addressDetails:
                                                                    AddressDetails(),
                                                              )));
                                                } else {
                                                  if (currentUser!.id != 0) {
                                                    // Navigator.of(context)
                                                    //     .pushNamed('/address');
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                SearchLocationScreen(
                                                                  edit: false,
                                                                  addressDetails:
                                                                      AddressDetails(),
                                                                )));
                                                  }
                                                  if (primaryAddressDetails ==
                                                      null) {
                                                    // Navigator.pop(context);
                                                    // Navigator.of(context).push(
                                                    //     MaterialPageRoute(
                                                    //         builder: (context) =>
                                                    //             SelectAddressScreen(
                                                    //                 edit: false,
                                                    //                 addressDetails:
                                                    //                     AddressDetails())));
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                SearchLocationScreen(
                                                                  edit: false,
                                                                  addressDetails:
                                                                      AddressDetails(),
                                                                )));
                                                  }
                                                }
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                    color: Colors.white,
                                                    padding: const EdgeInsets
                                                            .all(
                                                        Dimensions
                                                            .PADDING_SIZE_DEFAULT),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          (currentUser?.id != 0)
                                                              ? ("Select an address")
                                                              : ("Login & Select an address"),
                                                          style: TextStyle(
                                                              fontSize: Dimensions
                                                                  .fontSizeExtraLarge),
                                                        )
                                                      ],
                                                    )),
                                              ),
                                            ),
                                      const CustomDivider(),
                                      ListView.builder(
                                        key: UniqueKey(),
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: cart.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: PackageTile(
                                                servicePackage:
                                                    keysList[index]),
                                          );
                                        },
                                      ),
                                      const PriceDetails(),
                                    ],
                                  )
                                : SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.8,
                                    child: Center(
                                      child: Text(
                                        "Your Cart is Empty",
                                        style: TextStyle(
                                            fontSize: Dimensions.fontSizeLarge),
                                      ),
                                    ),
                                  ),
                          ),
                          bottomNavigationBar: cart.isNotEmpty
                              ? BottomAppBar(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Text(
                                              "Total Price",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              "Rs. ${cartState.cartData.amountToPay}",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                          child: Padding(
                                        padding: const EdgeInsets.all(
                                            Dimensions.PADDING_SIZE_SMALL),
                                        child: TextButton(
                                            style: TextButton.styleFrom(
                                                backgroundColor:
                                                    const Color(0xFFA854FC),
                                                minimumSize: const Size(
                                                    double.infinity,
                                                    Dimensions
                                                        .PADDING_SIZE_DEFAULT),
                                                padding: const EdgeInsets
                                                        .symmetric(
                                                    vertical: Dimensions
                                                        .PADDING_SIZE_DEFAULT),
                                                textStyle: TextStyle(
                                                    fontSize: Dimensions
                                                        .fontSizeExtraLarge)),
                                            onPressed: () {
                                              // checkUser();

                                              // if ((cartState.cartData
                                              //             .originalAmount !=
                                              //         null) &&
                                              //     (cartState
                                              //             .cartData.mincheck !=
                                              //         null)) {
                                              //   if (cartState.cartData
                                              //           .originalAmount! >=
                                              //       cartState
                                              //           .cartData.mincheck!) {
                                              if ((cartState.cartData
                                                      .originalAmount !=
                                                  null)) {
                                                if (cartState.cartData
                                                        .originalAmount! >=
                                                    599) {
                                                  // Navigator.push(
                                                  //     context,
                                                  //     MaterialPageRoute(
                                                  //         builder: (context) =>
                                                  //             SearchLocationScreen(
                                                  //               edit: false,
                                                  //               addressDetails:
                                                  //                   AddressDetails(),
                                                  //             )));
                                                  if (primaryAddressDetails !=
                                                      null) {
                                                    // Navigator.pushNamed(
                                                    //     context, '/payment');
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                const PaymentScreen()));
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            const SnackBar(
                                                      content: Text(
                                                          'Please select Address.'),
                                                      duration:
                                                          Duration(seconds: 1),
                                                    ));
                                                  }
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Please add items worth ${cartState.cartData.mincheck} to proceed.'),
                                                    duration: const Duration(
                                                        seconds: 1),
                                                  ));
                                                }
                                              }
                                            },
                                            child:
                                                const Text("Procees to Pay")),
                                      ))
                                    ],
                                  ),
                                )
                              : const SizedBox(),
                        );
                      } else {
                        return const Scaffold(
                          body: CustomError(),
                        );
                      }
                    },
                  );
                } else {
                  return const Scaffold(
                    body: CustomError(),
                  );
                }
              },
            );
          } else {
            return const CustomError();
          }
        } else {
          return const Scaffold(
            body: CustomError(),
          );
        }
      },
    );
  }
}

class PriceDetails extends StatefulWidget {
  const PriceDetails({Key? key}) : super(key: key);

  @override
  State<PriceDetails> createState() => _PriceDetailsState();
}

class _PriceDetailsState extends State<PriceDetails> {
  bool? colorofwalletbar = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartDataBloc, CartDataState>(
      builder: (context, state) {
        if (state is CartDataLoading) {
          return const LoadingScreen();
        } else if (state is CartDataLoaded) {
          print('state coupon applied ${state.cartData.couponId}');
          bool couponApplied = state.cartData.couponId != null;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 4,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: (const Color.fromARGB(255, 254, 253, 255))),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              "  Use Wallet (Glam Coin - ${state.cartData.walletBalance})",
                              style: TextStyle(
                                  fontSize: Dimensions.fontSizeLarge)),
                          Checkbox(
                            checkColor: const Color(0xFF882EDF),
                            value: state.cartData.isWalletUsed,
                            onChanged: (newValue) {
                              context
                                  .read<CartDataBloc>()
                                  .add(CartDataUpdateWallet());
                            },
                          ),
                        ]),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white),
                  child: Table(
                    children: <TableRow>[
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(
                                Dimensions.PADDING_SIZE_SMALL),
                            child: Text(
                              "Price Details",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: Dimensions.fontSizeExtraLarge),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              print(
                                  "hello print${state.cartData.originalAmount}");
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const CouponScreen(
                                      couponData: CouponData()),
                                ),
                              );
                            },
                            style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: couponApplied
                                    ? Colors.green
                                    : const Color(0xFF882EDF),
                                minimumSize: const Size(double.infinity,
                                    Dimensions.PADDING_SIZE_LARGE),
                                padding: const EdgeInsets.symmetric(
                                    vertical: Dimensions.PADDING_SIZE_DEFAULT),
                                textStyle: TextStyle(
                                    fontSize: Dimensions.fontSizeExtraLarge)),
                            child: Text(couponApplied
                                ? 'Coupon Applied'
                                : "Apply Coupon"),
                          ),
                        ],
                      ),
                      TableRow(children: [
                        const Padding(
                          padding:
                              EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                          child: Text("Total Price"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(
                              Dimensions.PADDING_SIZE_SMALL),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text("Rs ${state.cartData.originalAmount}"),
                              const Text("(Inclusive of all taxes)")
                            ],
                          ),
                        )
                      ]),
                      TableRow(children: [
                        const Padding(
                          padding:
                              EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                          child: Text("Coupon Discount"),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(
                                  Dimensions.PADDING_SIZE_SMALL),
                              child: Text(
                                  "${state.cartData.couponId != null ? state.cartData.couponDiscount : state.cartData.discount}"),
                            ),
                          ],
                        )
                      ]),
                      TableRow(children: [
                        const Padding(
                          padding:
                              EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                          child: Text("Safety & Hygiene Fee"),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(
                                  Dimensions.PADDING_SIZE_SMALL),
                              child: Text("${state.cartData.extraFees}"),
                            ),
                          ],
                        )
                      ]),
                      const TableRow(children: [
                        Padding(
                          padding:
                              EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                          child: Text("Transportation Fee"),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                              child: Text("0"),
                            ),
                          ],
                        )
                      ]),
                      TableRow(children: [
                        const Padding(
                          padding:
                              EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                          child: Text("Total Amount Payable"),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                                padding: const EdgeInsets.all(
                                    Dimensions.PADDING_SIZE_SMALL),
                                child: Text(
                                    // double.parse(
                                    state.cartData.amountToPay!
                                        .toStringAsFixed(2))
                                // "${state.cartData.amountToPay}"),
                                ),
                          ],
                        )
                      ]),
                    ],
                  ),
                ),
              ),
            ],
          );
        } else {
          return const CustomError();
        }
      },
    );
  }
}
