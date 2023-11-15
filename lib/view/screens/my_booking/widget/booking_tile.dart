import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glamcode/data/model/bookings.dart';
import 'package:glamcode/main.dart';
import 'package:glamcode/util/dimensions.dart';
import 'package:glamcode/view/Chat/ui/chatroom.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../../blocs/cart_data/cart_data_bloc.dart';
import '../../../../data/api/api_helper.dart';
import '../../../../data/model/auth.dart';
import '../../../../data/model/user.dart';
import '../../../Chat/ui/model/chatroomModel.dart';
import '../../../base/error_screen.dart';
import '../../../base/loading_screen.dart';
import '../../dashboard/dashboard_screen.dart';
import '../../select_booking/bookingslotmodel.dart';
import 'rescheduleBottomSheet.dart';

class BookingTile extends StatefulWidget {
  final OngoingBookingsArr ongoingBookingsArr;
  const BookingTile({Key? key, required this.ongoingBookingsArr})
      : super(key: key);

  @override
  State<BookingTile> createState() => _BookingTileState();
}

class _BookingTileState extends State<BookingTile> {
  bool showSpinner = false;
  Future<ChatRoomModel?> getChatroomModel() async {
    ChatRoomModel? chatroom;
    final Auth auth = Auth.instance;
    User currentUser = await auth.currentUser;

    final beuticianId = widget.ongoingBookingsArr.beauticianID.toString();
    final userid = currentUser.id.toString();

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection(widget.ongoingBookingsArr.bookingId.toString())
        .where("participants.${beuticianId}", isEqualTo: true)
        .where("participants.${userid}", isEqualTo: true)
        .get();

    if (snapshot.docs.length > 0) {
      //Fetch the existing one
      log("Chatroom already creatred!");

      var docData = snapshot.docs[0].data();
      ChatRoomModel existingChatroom =
          ChatRoomModel.fromMap(docData as Map<String, dynamic>);
      chatroom = existingChatroom;
    } else {
      //create a new one
      ChatRoomModel newChatroom = ChatRoomModel(
          chatroomid: widget.ongoingBookingsArr.bookingId.toString(),
          lastmessage: "",
          participants: {
            beuticianId: true,
            userid: true,
          });
      await FirebaseFirestore.instance
          .collection("chatroom")
          .doc(newChatroom.chatroomid)
          .set(newChatroom.toMap());
      log("newchatroom created");
      chatroom = newChatroom;
    }
    return chatroom;
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Card(
          color: Color.fromARGB(255, 218, 244, 250),
          elevation: 10,
          shadowColor: Colors.red,
          borderOnForeground: true,
          margin: const EdgeInsets.all(0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(colors: [
                  Colors.white,
                  Colors.white,
                  Color.fromARGB(255, 249, 203, 218),
                ])),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_SMALL,
                        vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    // width: double.infinity,
                    child: Row(
                      children: [
                        Text(
                          "${widget.ongoingBookingsArr.bookingDate}  AT  ${widget.ongoingBookingsArr.bookingTime}",
                          style: const TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 20),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        // PopupMenuButton(
                        //     itemBuilder: ((context) => [
                        //           PopupMenuItem(
                        //               onTap: () {},
                        //               child: const Text("Reschedule")),
                        //           PopupMenuItem(
                        //               onTap: () {
                        //                 showDialog(
                        //                     context: context,
                        //                     builder: (BuildContext context) {
                        //                       return AlertDialog(
                        //                         title: Text("Cancel Booking"),
                        //                         content: SingleChildScrollView(
                        //                           child: ListBody(children: [
                        //                             Text(
                        //                                 "Are you sure want to cancel booking?"),
                        //                           ]),
                        //                         ),
                        //                         actions: [
                        //                           TextButton(
                        //                               onPressed: () {},
                        //                               child: const Text("No")),
                        //                           TextButton(
                        //                               onPressed: () {},
                        //                               child: const Text("Yes")),
                        //                         ],
                        //                       );
                        //                     });
                        //               },
                        //               child: const Text("Cancel"))
                        //         ]))
                      ],
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(
                            Dimensions.PADDING_SIZE_DEFAULT),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(
                                  Dimensions.PADDING_SIZE_EXTRA_SMALL),
                              child: Text(
                                widget.ongoingBookingsArr.serviceName ?? "",
                                style: TextStyle(
                                    fontSize: Dimensions.fontSizeLarge,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(
                                  Dimensions.PADDING_SIZE_EXTRA_SMALL),
                              child: Column(
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      text:
                                          "₹${widget.ongoingBookingsArr.discountedPrice}   ",
                                      style: TextStyle(
                                          fontSize: Dimensions.fontSizeSmall,
                                          color: Colors.black),
                                      children: [
                                        WidgetSpan(
                                          child: Transform.translate(
                                            offset: const Offset(0.0, -4.0),
                                            child: Text(
                                              "₹${widget.ongoingBookingsArr.serviceCharge}",
                                              style: TextStyle(
                                                fontSize: Dimensions
                                                    .fontSizeExtraSmall,
                                                color: Colors.grey,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  /*const Padding(
                                    padding: EdgeInsets.only(
                                        left: Dimensions.PADDING_SIZE_SMALL),
                                    child: GoldenText(
                                      text: "  ${ongoingBookingsArr.savePrice}% Off  ",
                                    ),
                                  ),*/
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(
                                  Dimensions.PADDING_SIZE_EXTRA_SMALL),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.access_time_rounded,
                                    size: Dimensions.fontSizeSmall,
                                  ),
                                  Text(
                                    "${widget.ongoingBookingsArr.serviceTime} Minutes",
                                    style: TextStyle(
                                        fontSize: Dimensions.fontSizeSmall),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.black),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Dimensions.PADDING_SIZE_SMALL,
                                  vertical: Dimensions.PADDING_SIZE_SMALL),
                              child: Text(
                                  'Status - ${widget.ongoingBookingsArr.orderStatus}',
                                  style: const TextStyle(
                                    // background: Paint()
                                    //   ..color = Colors.black
                                    //   ..strokeWidth = Dimensions.fontSizeLarge
                                    //   ..strokeJoin = StrokeJoin.round
                                    //   ..strokeCap = StrokeCap.round
                                    //   ..style = PaintingStyle.stroke,
                                    color: Colors.white,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding:
                            const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          clipBehavior: Clip.hardEdge,
                          child: Image.network(
                              widget.ongoingBookingsArr.serviceImage ?? ""),
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: Colors.black,
                ),
                Row(
                  children: [
                    CupertinoButton(
                        child: Icon(Icons.call),
                        onPressed: () {
                          if (widget.ongoingBookingsArr.bookingAssigned ==
                              true) {
                            setState(() {
                              showSpinner = true;
                            });
                            DioClient.instance.callCustomer(
                                context,
                                widget.ongoingBookingsArr.beauticianPhone
                                    .toString());
                            setState(() {
                              showSpinner = false;
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    backgroundColor:
                                        Color.fromARGB(255, 218, 119, 220),
                                    content: Text(
                                      "Beautician not assigned yet!",
                                      style: TextStyle(color: Colors.white),
                                    )));
                          }
                        }),
                    CupertinoButton(
                        child: const Icon(Icons.chat),
                        onPressed: () async {
                          if (widget.ongoingBookingsArr.bookingAssigned ==
                              true) {
                            setState(() {
                              showSpinner = true;
                            });
                            ChatRoomModel? chatRoomModel =
                                await getChatroomModel();
                            log(chatRoomModel.toString());
                            setState(() {
                              showSpinner = false;
                            });
                            if (chatRoomModel != null) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChatRoom(
                                            bookingId: widget
                                                .ongoingBookingsArr.bookingId
                                                .toString(),
                                            beauticianId: widget
                                                .ongoingBookingsArr.beauticianID
                                                .toString(),
                                            beauticianName: widget
                                                .ongoingBookingsArr
                                                .beauticianName
                                                .toString(),
                                          )));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    backgroundColor:
                                        Color.fromARGB(255, 218, 119, 220),
                                    content: Text(
                                      "Beautician not assigned yet!",
                                      style: TextStyle(color: Colors.white),
                                    )));
                          }
                        }),
                    SizedBox(
                      width: 2,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_SMALL,
                          vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      // width: double.infinity,
                      child: Text(
                        (widget.ongoingBookingsArr.bookingAssigned == false)
                            ? "Not-Assigned"
                            : "Assigned",
                        style: const TextStyle(fontWeight: FontWeight.w900),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_SMALL,
                          vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      // width: double.infinity,
                      child: Text(
                        "    ${widget.ongoingBookingsArr.bookingId}",
                        style: const TextStyle(fontWeight: FontWeight.w900),
                      ),
                    ),
                  ],
                ),
                // Divider(
                //   color: Colors.black,
                // ),
                (widget.ongoingBookingsArr.orderStatus == "pending")
                    ? Row(
                        children: [
                          CupertinoButton(
                              child: const Text("Cancel"),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text("Alert"),
                                        content: Text(
                                            "Do you want to cancel the booking ?"),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                DioClient.instance.cancelReschedule(
                                                    widget.ongoingBookingsArr
                                                        .bookingId
                                                        .toString(),
                                                    "${widget.ongoingBookingsArr.bookingDate} ${widget.ongoingBookingsArr.bookingTime}",
                                                    "1");

                                                Navigator.pop(context);
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: ((context) =>
                                                            DashboardScreen(
                                                                pageIndex:
                                                                    2))));
                                                DioClient.instance
                                                    .getBookings();
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: Text(
                                                      "Booking Cancelled!"),
                                                  backgroundColor: Colors.green,
                                                ));
                                              },
                                              child: Text("Yes")),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text("No"))
                                        ],
                                      );
                                    });
                              }),
                          CupertinoButton(
                              child: const Text("Reschedule"),
                              onPressed: () {
                                showModalBottomSheet(
                                    isScrollControlled: true,
                                    useSafeArea: true,
                                    enableDrag: true,
                                    showDragHandle: true,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(12),
                                            topRight: Radius.circular(12))),
                                    context: context,
                                    builder: (BuildContext context) {
                                      return StatefulBuilder(builder:
                                          (BuildContext context,
                                              StateSetter setstate) {
                                        return RecheduleBottomSheet(
                                          ongoingBookingsArr:
                                              widget.ongoingBookingsArr,
                                        );
                                      });
                                    });
                              })
                        ],
                      )
                    : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
