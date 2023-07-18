// import 'dart:convert';

// import 'package:confetti/confetti.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:glamcode/data/model/auth.dart';
// import 'package:glamcode/data/model/user.dart';
// import 'package:glamcode/screen_size.dart';
// import 'package:glamcode/view/screens/cashback/cashback.dart';
// import 'package:glamcode/view/screens/cashback/cashbackmodel.dart';

// import 'package:http/http.dart';
// import 'package:scratcher/widgets.dart';

// class ScrachView extends StatefulWidget {
//   final CashbackViewModel? data;

//   const ScrachView({
//     super.key,
//     this.data,
//     // required String data,
//   });

//   @override
//   _ScrachViewState createState() => _ScrachViewState();
// }

// class _ScrachViewState extends State<ScrachView> {
//   final Auth auth = Auth.instance;
//   late ConfettiController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = ConfettiController(
//       duration: const Duration(seconds: 1),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(),
//       body: CashbackViewModel == null
//           ? const Center(
//               child: CircularProgressIndicator(
//               color: Color(0xFF882EDF),
//             ))
//           : Center(
//               child: Scratcher(
//                 brushSize: 100,
//                 threshold: 100,
//                 color: Color(0xFF882EDF),
//                 onChange: (value) => print("Scratch progress: $value%"),
//                 onThreshold: () => _controller.play(),
//                 child: Container(
//                   height: displayHeight(context) * 0.3,
//                   width: displayWidth(context) * 0.7,
//                   color: Colors.grey,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Text("Expiryed in ${widget.data!.reward!.first.expiry}",
//                           style: const TextStyle(fontSize: 20)),
//                       Text("Reward  ${widget.data!.reward!.first.reward}",
//                           style: const TextStyle(fontSize: 20)),
//                       Column(
//                         children: [
//                           ConfettiWidget(
//                             blastDirectionality: BlastDirectionality.explosive,
//                             confettiController: _controller,
//                             particleDrag: 0.05,
//                             emissionFrequency: 0.05,
//                             numberOfParticles: 100,
//                             gravity: 0.05,
//                             shouldLoop: false,
//                             colors: const [
//                               Colors.green,
//                               Colors.red,
//                               Colors.yellow,
//                               Colors.blue,
//                             ],
//                           ),
//                           Text(
//                               "Describtion${widget.data!.reward!.first.describtion}",
//                               style: const TextStyle(fontSize: 20)),
//                         ],
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           addSave();
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => const Cashbackview()),
//                           );
//                         },
//                         child: const Card(
//                             child: Padding(
//                           padding: EdgeInsets.all(8.0),
//                           child: Text(
//                             "Accept",
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                         )),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//     );
//   }

//   void addSave() async {
//     User currentUser = await auth.currentUser;
//     // if (!_formKey.currentState.validate()) {
//     //   return;
//     // }

//     var url = "https://admin.glamcode.in/api/cashback";

//     var body = {
//       "id": widget.data!.reward!.first.id.toString(),
//       "user_id": "${currentUser.id}",
//       "booking_id": widget.data!.reward!.first.bookingId.toString(),
//       "expiry_date": widget.data!.reward!.first.expiry.toString(),
//       // "ActivityId": 1,
//     };
//     try {
//       var response = await post(Uri.parse(url), body: body);
//       if (kDebugMode) {
//         print(response);
//       }
//       if (kDebugMode) {
//         print(response.statusCode);
//       }
//       if (kDebugMode) {
//         print(response.body);
//       }

//       if (response.statusCode == 200) {
//         var jsondata = json.decode(response.body);
//         if (jsondata["status"] == 'success') {
//           // if (kDebugMode) {
//           //   print('sucess data');
//           // }
//           // ignore: use_build_context_synchronously
//           // Navigator.push(
//           //   context,
//           //   MaterialPageRoute(builder: (context) => const Cashbackview()),
//           // );

//           // ignore: use_build_context_synchronously
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//                 duration: Duration(seconds: 1),
//                 backgroundColor: Colors.green,
//                 content: Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Text(
//                     'Record Success',
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                 )),
//           );

//           // ignore: use_build_context_synchronously
//           // Navigator.push(
//           //   context,
//           //   MaterialPageRoute(builder: (context) => const Cashbackview()),
//           // );
//         } else {
//           const AlertDialog(
//             actions: [Text("data not Add")],
//           );
//         }
//       }
//     } catch (ex) {
//       //   if (kDebugMode) {
//       //     print(ex.toString());
//       //   }
//     }
//   }
// }
