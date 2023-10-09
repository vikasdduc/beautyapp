import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glamcode/data/model/bookings.dart';
import 'package:glamcode/main.dart';
import 'package:glamcode/util/dimensions.dart';
import 'package:glamcode/view/Chat/ui/chatroom.dart';

import '../../../../data/model/auth.dart';
import '../../../../data/model/user.dart';
import '../../../Chat/ui/model/chatroomModel.dart';

class BookingTile extends StatelessWidget {
  final OngoingBookingsArr ongoingBookingsArr;
  const BookingTile({Key? key, required this.ongoingBookingsArr})
      : super(key: key);



  Future<ChatRoomModel?> getChatroomModel() async {
    ChatRoomModel? chatroom;
    final Auth auth = Auth.instance;
    User currentUser = await auth.currentUser;

  final beuticianId = "123";
  final userid = currentUser.id.toString();
  

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection(ongoingBookingsArr.bookingId.toString())
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
      ChatRoomModel newChatroom =
          ChatRoomModel(chatroomid: ongoingBookingsArr.bookingId.toString(), lastmessage: "", participants: {
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: Card(
        color: Color.fromARGB(255, 218, 244, 250),
        elevation: 10,
        shadowColor: Colors.red,
        borderOnForeground: true,
        margin: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
                  child: Text(
                    "${ongoingBookingsArr.bookingDate}  AT  ${ongoingBookingsArr.bookingTime}",
                    style: const TextStyle(
                        fontWeight: FontWeight.w900, fontSize: 20),
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding:
                          const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(
                                Dimensions.PADDING_SIZE_EXTRA_SMALL),
                            child: Text(
                              ongoingBookingsArr.serviceName ?? "",
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
                                        "₹${ongoingBookingsArr.discountedPrice}   ",
                                    style: TextStyle(
                                        fontSize: Dimensions.fontSizeSmall,
                                        color: Colors.black),
                                    children: [
                                      WidgetSpan(
                                        child: Transform.translate(
                                          offset: const Offset(0.0, -4.0),
                                          child: Text(
                                            "₹${ongoingBookingsArr.serviceCharge}",
                                            style: TextStyle(
                                              fontSize:
                                                  Dimensions.fontSizeExtraSmall,
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
                                  "${ongoingBookingsArr.serviceTime} Minutes",
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
                                'Status - ${ongoingBookingsArr.orderStatus}',
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
                            ongoingBookingsArr.serviceImage ?? ""),
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
                  CupertinoButton(child: Icon(Icons.call), onPressed: () {}),
                  CupertinoButton(
                      child: const Icon(Icons.chat),
                      onPressed: () async {
                        ChatRoomModel? chatRoomModel = await getChatroomModel();
                        log(chatRoomModel.toString());
                        if (chatRoomModel != null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>  ChatRoom(bookingId: ongoingBookingsArr.bookingId.toString(),)));
                        }
                      }),
                  SizedBox(
                    width: 70,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_SMALL,
                        vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    // width: double.infinity,
                    child: Text(
                      "Booking ID - ${ongoingBookingsArr.bookingId}",
                      style: const TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
