import 'package:flutter/material.dart';



class ProductDetails extends StatefulWidget {
  // final String proId;
  // final String stock;
  // final int itemCartCount;
  // final String proName;
  // final String proImage;
  // final String proDescription;
  // final String proPrice;
  // final String proSellingprice;
  // final String proDiscount;
  // final String proQuantity;
  // final String cateId;
  final String cateName;
  final String proCompany;
  const ProductDetails(
      {Key? key,
      // required this.proName,
      required this.proCompany,
      // required this.stock,
      // required this.itemCartCount,
      // required this.proId,
      // required this.proImage,
      // required this.proDescription,
      // required this.proPrice,
      // required this.proSellingprice,
      // required this.proDiscount,
      // required this.proQuantity,
      // required this.cateId,
      required this.cateName})
      : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  // SliderModel slideModel;

  @override
  void initState() {
    super.initState();

    // getProductSlider();
  }

  // ProductSlideModel? productSlideModel;
  // getProductSlider() async {
  //   var url = URLapi.proSliderUrl + widget.proId;
  //   final response = await http.get(Uri.parse(url));
  //   if (response.statusCode == 200) {
  //     var resps = ProductSlideModel.fromJson(jsonDecode(response.body));
  //     setState(() {
  //       productSlideModel = resps;
  //     });
  //   } else {
  //     throw Exception('Failed to load Images');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 77, 74, 74)),
        titleSpacing: 0.0,
        // title: Text(
        //   widget.proName,
        //   style: const TextStyle(color: Color.fromARGB(255, 77, 74, 74)),
        // ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.shopping_cart,
                ),
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const CartItem()),
                  // );
                },
              ),
              const CircleAvatar(
                radius: 10.0,
                backgroundColor: Colors.white,
                child: Text(""
                    // widget.itemCartCount.toString(),
                    // style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
              )
            ],
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(
              left: 10,
            ),
            child: Stack(
              children: [
                RotationTransition(
                  turns: AlwaysStoppedAnimation(270 / 360),
                  child: Icon(
                    Icons.bookmark,
                    color: Colors.green,
                    size: 50,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: RotationTransition(
                    turns: AlwaysStoppedAnimation(270 / 360),
                    child: Icon(
                      Icons.bookmark,
                      color: Colors.green,
                      size: 50,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 50),
                  child: RotationTransition(
                    turns: AlwaysStoppedAnimation(270 / 360),
                    child: Icon(
                      Icons.bookmark,
                      color: Colors.green,
                      size: 50,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 70),
                  child: RotationTransition(
                    turns: AlwaysStoppedAnimation(270 / 360),
                    child: Icon(
                      Icons.bookmark,
                      color: Colors.green,
                      size: 50,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 13, top: 15),
                  // child: Text(
                  //   '₹ ' + widget.proDiscount + ' ऑफ',
                  //   style: const TextStyle(
                  //       fontWeight: FontWeight.bold, color: Colors.white),
                  // ),
                ),
                // Padding(
                //     padding: const EdgeInsets.only(left: 200, top: 5),
                //     child: widget.stock == "0"
                //         ?
                //         Card(
                //             color: Colors.red[900],
                //             child: const Padding(
                //               padding: EdgeInsets.symmetric(
                //                   horizontal: 10, vertical: 5),
                //               child: Text(
                //                 'आउट ऑफ स्टॉक',
                //                 style: TextStyle(
                //                     color: Colors.white,
                //                     fontWeight: FontWeight.bold),
                //               ),
                //             ))
                //         : Card(
                //             color: Colors.greenAccent[700],
                //             child: Padding(
                //               padding: const EdgeInsets.symmetric(
                //                   horizontal: 10, vertical: 5),
                //               child: Text(widget.stock + ' आइटम स्टॉक',
                //                   style: const TextStyle(
                //                       color: Colors.white,
                //                       fontWeight: FontWeight.bold)),
                //             ))),
              ],
            ),
          ),
          // productSlideModel == null
          //     ? const CircularProgressIndicator()
          //     : Center(
          // child:
          Container(
            color: Colors.transparent,
            // width: displayWidth(context) * 0.6,
            // height: displayHeight(context) * 0.45,
            // child: Image.network(
            //     "https://images.pexels.com/photos/213780/pexels-photo-213780.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),

            // child: ImageSlideshow(
            //   width: double.infinity,
            //   // height: 150,
            //   initialPage: 0,
            //   indicatorColor: Colors.blue,
            //   indicatorBackgroundColor: Colors.grey,
            //   onPageChanged: (value) {
            //     debugPrint('Page changed: $value');
            //   },
            //   // autoPlayInterval: 10000,
            //   isLoop: false,
            //   children: [
            //     // Image.network(URLapi.imageURL +
            //     //     productSlideModel.productImages[0].proImage),
            //     // Image.network(URLapi.imageURL +
            //     //     productSlideModel.productImages[0].proImage2),
            //     // Image.network(URLapi.imageURL +
            //     //     productSlideModel.productImages[0].proImage3),
            //     // Image.network(URLapi.imageURL +
            //     //     productSlideModel.productImages[0].proImage4),
            //     // Image.network(
            //     //     "https://images.pexels.com/photos/213780/pexels-photo-213780.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
            //     // Image.network(
            //     //     "https://images.pexels.com/photos/213780/pexels-photo-213780.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
            //     // Image.network(
            //     //     "https://images.pexels.com/photos/213780/pexels-photo-213780.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),

            //     // for (var i = 0;
            //     //     i < productSlideModel.product.length;
            //     //     i++)
            //     // productSlideModel == null
            //     //     ? const SliverToBoxAdapter(
            //     //         child: CircularProgressIndicator(
            //     //         strokeWidth: 0.5,
            //     //       ))
            //     //     : Image.network(
            //     //         URLapi.imageURL +
            //     //             productSlideModel.product[i].proImage,
            //     //         fit: BoxFit.fitWidth),
            //   ],
            // ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: widget.proCompany == null
                ? null
                : GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     // MaterialPageRoute(
                      //     //     builder: (context) => ProductCompany(
                      //     //           company: widget.proCompany,
                      //     //         )
                      //     //         )
                      //             );
                    },
                    child: Text(
                      widget.proCompany,
                      textScaleFactor: 1.5,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                  ),
          ),
          const Padding(
            padding: EdgeInsets.all(0.0),
            child: Center(
                child: Divider(
              color: Colors.grey,
              height: 10,
            )),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 10),
            // child: Text(
            //   widget.proDescription,
            //   style: const TextStyle(
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Row(
                children: [
                  // Text(
                  //   '₹' + widget.proSellingprice + '   ',
                  //   style: const TextStyle(fontWeight: FontWeight.bold),
                  // ),
                  // Text(
                  //   '₹' + widget.proPrice,
                  //   style:
                  //       const TextStyle(decoration: TextDecoration.lineThrough),
                  // ),
                ],
              ),
              // widget.stock == '0'
              //     ? GestureDetector(
              //         onTap: () {
              //           // Navigator.push(
              //           //   context,
              //           //   MaterialPageRoute(
              //           //       builder: (context) => const RequestItemScreen()),
              //           // );
              //         },
              //         child: Card(
              //           color: Colors.red[900],
              //           child: const Padding(
              //             padding:
              //                 EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              //             child: Text('रिक्वेस्ट आइटम',
              //                 style: TextStyle(
              //                     fontSize: 15,
              //                     color: Colors.white,
              //                     fontWeight: FontWeight.bold)),
              //           ),
              //         ),
              //       )
              //     :
              GestureDetector(
                onTap: () {
                  // addItemCard();
                },
                child: Card(
                  color: Colors.green[900],
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Text('ऐड कार्ड',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              // GestureDetector(
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) => CardScreen(
              //                 productID: widget.productID,
              //                 productNAME: widget.productNAME,
              //                 productOFFER: widget.productOFFER,
              //                 productImage: widget.productImage,
              //                 productDESCRIPTION: widget.productDESCRIPTION,
              //                 productSELL: widget.productSELL,
              //                 productPRICE: widget.productPRICE,
              //               )),
              //     );
              //   },
              //   child: Card(
              //     color: Colors.greenAccent[700],
              //     child: const Padding(
              //       padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              //       child: Text('खरीदें',
              //           style: TextStyle(
              //               fontSize: 15,
              //               color: Colors.white,
              //               fontWeight: FontWeight.bold)),
              //     ),
              //   ),
              // ),
            ],
          ),
          const Center(
              child: Divider(
            color: Colors.grey,
            height: 10,
          )),
          const Padding(
            padding: EdgeInsets.only(left: 10, top: 5),
            child: Text(
              'सेलेक्ट करें',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Card(
                    child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text('$productQuantity  पैकेट'),
                )),
                Card(
                    color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 5),
                      child: Row(
                        children: [
                          GestureDetector(
                            //  onPressed: _incrementCounter,
                            onTap: productQuantity == 1 ? zero : decreament,
                            child: const Icon(Icons.remove,
                                color: Colors.white, size: 30),
                          ),
                          Container(
                              color: Colors.white,
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  child: productQuantity >= 0
                                      ? Text(
                                          '$productQuantity',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        )
                                      : const Text(
                                          '0',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ))),
                          GestureDetector(
                            onTap: increament,
                            child: const Icon(Icons.add,
                                color: Colors.white, size: 30),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
          const Center(
              child: Divider(
            color: Colors.grey,
            height: 10,
          )),
          Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Icon(
                    Icons.restart_alt,
                    size: 50,
                    color: Colors.green[900],
                  ),
                  const Text('इजी रिटर्नेबल'),
                  const Text(
                    '3 दिन के अंदर',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Column(
                children: [
                  Icon(
                    Icons.delivery_dining_sharp,
                    size: 50,
                    color: Colors.green[900],
                  ),
                  const Text('फ्री डिलीवरी'),
                ],
              ),
              Column(
                children: [
                  Icon(
                    Icons.paid_outlined,
                    size: 50,
                    color: Colors.green[900],
                  ),
                  const Text('कैश ऑन डिलीवरी'),
                ],
              ),
            ],
          )),
        ],
      ),
    );
  }

  int productQuantity = 1;
  void increament() {
    setState(() {
      productQuantity++;
    });
  }

  void decreament() {
    setState(() {
      productQuantity--;
    });
  }

  void zero() {
    setState(() {
      productQuantity = 1;
    });
  }

  // addItemCard() async {
  //   var url = URLapi.cartAddUrl;
  //   var data = {
  //     "reg_id": SharedHelper.userTid,
  //     "cate_id": widget.cateId,
  //     "cate_name": widget.cateName,
  //     "pro_id": widget.proId,
  //     "pro_name": widget.proName,
  //     "pro_image": widget.proImage,
  //     "pro_price": widget.proPrice,
  //     "pro_stock": int.parse(widget.stock),
  //     // int.parse(widget.stock),
  //     "pro_company_name": widget.proCompany,
  //     "pro_description": widget.proDescription,
  //     "pro_sellingprice": widget.proSellingprice,
  //     "pro_quantity": productQuantity.toString()
  //   };
  //   var response = await HttpHelpers.postRequest(url, data);
  //   if (response.statusCode == 200) {
  //     var jsondata = json.decode(response.body);
  //     if (jsondata["status"] == "Success") {
  //       Get.snackbar(
  //         'Success',
  //         'Your Card Item is added.',
  //         icon: Icon(Icons.download_done,
  //             size: displayHeight(context) * 0.05, color: Colors.white),
  //         snackPosition: SnackPosition.BOTTOM,
  //         backgroundColor: Colors.greenAccent[700],
  //         borderRadius: 20,
  //         margin: EdgeInsets.all(displayHeight(context) * 0.02),
  //         colorText: Colors.white,
  //         duration: const Duration(seconds: 3),
  //         isDismissible: true,
  //         dismissDirection: DismissDirection.horizontal,
  //         forwardAnimationCurve: Curves.easeOutBack,
  //       );
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => const CartItem()),
  //       );
  //     } else {
  //       Get.snackbar(
  //         'Error',
  //         'Your Card Item is already added.',
  //         icon: Icon(Icons.download_done,
  //             size: displayHeight(context) * 0.05, color: Colors.white),
  //         snackPosition: SnackPosition.BOTTOM,
  //         backgroundColor: Colors.yellow[700],
  //         borderRadius: 20,
  //         margin: EdgeInsets.all(displayHeight(context) * 0.02),
  //         colorText: Colors.white,
  //         duration: const Duration(seconds: 3),
  //         isDismissible: true,
  //         dismissDirection: DismissDirection.horizontal,
  //         forwardAnimationCurve: Curves.easeOutBack,
  //       );
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => const CartItem()),
  //       );
  //     }
  //   } else {
  //     throw Exception('Failed to create Item.');
  //   }
  //   return response;
  // }
}
