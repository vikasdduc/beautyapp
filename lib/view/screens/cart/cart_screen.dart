import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glamcode/blocs/cart_data/cart_data_bloc.dart';
import 'package:glamcode/data/model/auth.dart';
import 'package:glamcode/data/model/coupons.dart';
import 'package:glamcode/data/model/packages_model/service.dart';
import 'package:glamcode/data/model/user.dart';
import 'package:glamcode/data/repository/coupon_repository.dart';
import 'package:glamcode/util/dimensions.dart';
import 'package:glamcode/view/base/custom_divider.dart';
import 'package:glamcode/view/base/error_screen.dart';
import 'package:glamcode/view/base/package_tile.dart';
import 'package:glamcode/view/screens/address/address_screen.dart';
import 'package:glamcode/view/screens/address/select_address.dart';
import 'package:glamcode/view/screens/coupon/coupon_screen.dart';

import '../../../blocs/auth/auth_bloc.dart';
import '../../../blocs/cart/cart_bloc.dart';
import '../../../data/api/api_helper.dart';
import '../../../data/model/address_details_model.dart';
import '../../base/loading_screen.dart';
import '../address/selectnew_address.dart';

int checkedauth = 0;

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late Future<AddressDetailsModel?> _future;
  bool useWallet = true;
  late final AuthBloc authBloc;
  late User user;
  late CheckForAuth checkForAuth;
  User? currentUser;

  initialize() async {
    final Auth auth = Auth.instance;
    currentUser = await auth.currentUser;
  }

  @override
  void initState() {
    initialize();
    checkForAuth = CheckForAuth();

    user = User();
    CouponRepository.instance.clearCouponInstance();
    context.read<CartDataBloc>().add(CartDataUpdate());
    _future = DioClient.instance.getAddress();
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
                            title: const Text("MY CART"),
                          ),
                          body: SingleChildScrollView(
                            child: cart.isNotEmpty
                                ? Column(
                                    children: [
                                      const CustomDivider(),
                                      primaryAddressDetails != null
                                          ? ListTile(
                                              tileColor: Colors.white,
                                              title: Text(
                                                primaryAddressDetails
                                                        .addressHeading ??
                                                    "",
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              subtitle: Text(
                                                primaryAddressDetails.street ??
                                                    "",
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              leading: const Icon(
                                                  Icons.location_on_outlined),
                                              trailing: TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const AddressDetailsScreen()));
                                                },
                                                style: ButtonStyle(
                                                  minimumSize:
                                                      MaterialStateProperty.all(
                                                    const Size(0, 0),
                                                  ),
                                                  padding:
                                                      MaterialStateProperty.all(
                                                    const EdgeInsets.all(
                                                      Dimensions
                                                          .PADDING_SIZE_SMALL,
                                                    ),
                                                  ),
                                                ),
                                                child: Text(
                                                  "Change",
                                                  style: TextStyle(
                                                    fontSize: Dimensions
                                                        .fontSizeDefault,
                                                  ),
                                                ),
                                              ),
                                              dense: true,
                                              minLeadingWidth: 0,
                                            )
                                          : InkWell(
                                              onTap: () {
                                                print("currentUser!.id");
                                                if (currentUser!.id == 0) {
                                                  Navigator
                                                      .pushReplacementNamed(
                                                          context, '/index');
                                                } else {
                                                  if (currentUser!.id != 0) {
                                                    Navigator.of(context)
                                                        .pushNamed('/address');
                                                  }
                                                  if (primaryAddressDetails ==
                                                      null) {
                                                    // Navigator.pop(context);
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                SelectAddressScreen(
                                                                    edit: false,
                                                                    addressDetails:
                                                                        AddressDetails())));
                                                  }
                                                  Navigator.of(context)
                                                      .pushNamed('/address');
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
                                                        const Icon(Icons.add),
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
                                              if ((cartState.cartData
                                                          .originalAmount !=
                                                      null) &&
                                                  (cartState
                                                          .cartData.mincheck !=
                                                      null)) {
                                                if (cartState.cartData
                                                        .originalAmount! >=
                                                    cartState
                                                        .cartData.mincheck!) {
                                                  if (primaryAddressDetails !=
                                                      null) {
                                                    // Navigator.pushNamed(
                                                    //     context, '/payment');
                                                    Navigator.pushNamed(
                                                        context, '/addons');
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
                                            child: const Text("Next")),
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
                                  //       state.cartData.amountToPay.toStringAsFixed(2))
                                  "${state.cartData.amountToPay}"),
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

class CheckForAuth extends StatefulWidget {
  const CheckForAuth({super.key});

  @override
  State<CheckForAuth> createState() => _CheckForAuthState();
}

class _CheckForAuthState extends State<CheckForAuth> {
  @override
  Widget build(BuildContext context) {
    final AuthBloc authBloc = context.read<AuthBloc>();
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        // TODO: implement listener

        if (state == UnauthenticatedState) {
          setState(() {
            checkedauth = 0;
          });
        } else {
          setState(() {
            checkedauth = 1;
          });
        }
      },
      child: Container(),
    );

    //   return BlocBuilder<AuthBloc, AuthState>(
    //       bloc: authBloc,
    //       builder: (context, state) {
    //         setState(() {
    //           if (state is UnauthenticatedState) {
    //             checkedauth = 0;
    //           } else if (state is AuthenticatedState) {
    //             checkedauth = 1;
    //             // } else if (state is LoadingAuthenticationState) {
    //             //   return const Center(child: CircularProgressIndicator());
    //             // } else if (state is ErrorAuthenticationState) {
    //             //   return const Scaffold(
    //             //     body: Center(
    //             //       child: Text("Something is wrong"),
    //             //     ),
    //             //   );
    //             // } else {
    //             //   return const Scaffold(
    //             //     body: Center(
    //             //       child: Text("something is wrong"),
    //             //     ),
    //             //   );
    //             // }
    //           }
    //         });
    //         print(
    //             "checkfor authentication function11111111100000000012341342134289798047128937489012739084790812374590812379058798342758907234890758903475890732489075908324750987324905790382475908237490587239804758902347598072349085790823475890723490857980234758902347890579028347589023475890723980475980237495 $checkedauth");
    //         return const Center(child: CircularProgressIndicator());
    //       });
    // }
  }
}
