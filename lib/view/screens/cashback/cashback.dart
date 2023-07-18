// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:glamcode/data/model/auth.dart';
// import 'package:glamcode/data/model/user.dart';
// import 'package:glamcode/screen_size.dart';
// import 'package:glamcode/view/screens/cashback/scrachview.dart';
// import 'package:glamcode/view/screens/gallery/http_helper.dart';
// import 'cashbackmodel.dart';

// class Cashbackview extends StatefulWidget {
//   const Cashbackview({
//     super.key,
//   });

//   @override
//   State<Cashbackview> createState() => _CashbackviewState();
// }

// // http://admin.glamcode.in/api/scratch-card/4812
// class _CashbackviewState extends State<Cashbackview> {
//   final Auth auth = Auth.instance;
//   // String? discription;
//   // String? type;
//   // String? expiry;
//   // String? reward;
//   @override
//   void initState() {
//     super.initState();
//     // _future = DioClient.instance.getHomePage();

//     getpoint();
//   }

//   CashbackViewModel? cashbackViewModel;
//   getpoint() async {
//     User currentUser = await auth.currentUser;
//     var urlsc = "https://admin.glamcode.in/api/scratch-card/${currentUser.id}";
//     var response = await HttpHelpers.getRequest(urlsc);
//     if (response.statusCode == 200) {
//       var jsondata = json.decode(response.body);
//       var resp = CashbackViewModel.fromJson(jsondata);
//       setState(() {
//         cashbackViewModel = resp;
//       });
//     } else {
//       print(response.body());
//     }
//   }

//   @override
//   Widget build(
//     BuildContext context,
//   ) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Cashback")),
//       body: cashbackViewModel == null
//           ? const Center(
//               child: CircularProgressIndicator(
//               color: Color(0xFF882EDF),
//             ))
//           : Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: GridView.builder(
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     crossAxisSpacing: 10,
//                     // mainAxisExtent: 150,
//                     mainAxisSpacing: 10),
//                 itemCount: cashbackViewModel!.reward!.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => ScrachView(
//                                     data: cashbackViewModel,
//                                   )));
//                     },
//                     child: Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(15),
//                           color: Color(0xFF882EDF),
//                           boxShadow: const [
//                             BoxShadow(color: Colors.white, spreadRadius: 1),
//                           ],
//                         ),
//                         height: displayHeight(context) * 1,
//                         child: Center(
//                             child: Text(cashbackViewModel!.reward![index].expiry
//                                 .toString()))),
//                   );
//                 },
//               ),
//             ),
//     );
//   }
// }
