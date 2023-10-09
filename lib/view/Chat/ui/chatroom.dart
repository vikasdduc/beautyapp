import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:glamcode/data/model/bookings.dart';
import 'package:glamcode/main.dart';
import 'package:glamcode/view/Chat/ui/model/messageModel.dart';
import 'package:glamcode/view/Chat/ui/model/usermodel.dart';

import '../../../data/model/auth.dart';
import '../../../data/model/user.dart';
import 'model/chatroomModel.dart';

class ChatRoom extends StatefulWidget {
  final UserModel? targetUser;
  final ChatRoomModel? chartRoomModel;
  final String bookingId;

  //beautician Id
  //beautician Name

  const ChatRoom(
      {super.key,
      this.targetUser,
      this.chartRoomModel,
      required this.bookingId});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  TextEditingController messageController = TextEditingController();

  void sendMessage(String lat, String long) async {
    final Auth auth = Auth.instance;
    User currentUser = await auth.currentUser;
    String msg = messageController.text.trim();
    messageController.clear();

    if (msg != "" || lat != "" && long != "") {
      MessageModel newMessage = MessageModel(
          messageid: uuid.v1(),
          sender: currentUser.id.toString(),
          createdOn: DateTime.now(),
          text: msg,
          lat: lat,
          long: long,
          seen: false);

      FirebaseFirestore.instance
          .collection("chatroom")
          .doc(widget.bookingId.toString())
          .collection("messages")
          .doc(newMessage.messageid)
          .set(newMessage.toMap());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        elevation: 10,
        title: Row(
          children: [
            // CircleAvatar(
            //   backgroundColor: Colors.grey[300],
            //   backgroundImage:
            //       NetworkImage("widget.targetUser.profilepic.toString()"),
            // ),
            const SizedBox(
              width: 10,
            ),
            Text("Booking Id " + widget.bookingId.toString())
            // Text("widget.targetUser.fullname.toString()"),
          ],
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("chatroom")
                    .doc(widget.bookingId)
                    .collection("messages")
                    .orderBy("createdOn", descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData) {
                      QuerySnapshot datasnapshot =
                          snapshot.data as QuerySnapshot;
                      log(datasnapshot.toString());
                      return ListView.builder(
                          reverse: true,
                          itemCount: datasnapshot.docs.length,
                          itemBuilder: (context, index) {
                            MessageModel currentMessage = MessageModel.fromMap(
                                datasnapshot.docs[index].data()
                                    as Map<String, dynamic>);
                            return Row(
                              mainAxisAlignment:
                                  (currentMessage.sender == "123")
                                      ? MainAxisAlignment.start
                                      : MainAxisAlignment.end,
                              children: [
                                Flexible(
                                  child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 2),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: (currentMessage.sender == "123")
                                            ? Colors.pink
                                            : Colors.blue,
                                      ),
                                      child: (currentMessage.lat != "" &&
                                              currentMessage.long != "")
                                          ? SizedBox(
                                              height: 90,
                                              width: 150,
                                              child: Card(
                                                color: Colors.white,
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 50,
                                                    ),
                                                    InkWell(
                                                        onTap: () {},
                                                        child: const Text(
                                                          "view Location",
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      123,
                                                                      45,
                                                                      218)),
                                                        ))
                                                  ],
                                                ),
                                              ),
                                            )
                                          : Text(
                                              currentMessage.text.toString(),
                                              maxLines: null,
                                              style: const TextStyle(
                                                  color: Colors.black),
                                              overflow: TextOverflow.visible,
                                            )),
                                ),
                              ],
                            );
                          });
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text(
                            "An error occured! Please check your internet connection"),
                      );
                    } else {
                      return const Card(
                        color: Color.fromARGB(230, 249, 223, 143),
                        child: Center(
                          child: Text(
                            "end-to-end Entrypedted with Pink chat",
                            style:
                                TextStyle(fontSize: 10, color: Colors.black26),
                          ),
                        ),
                      );
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(30)),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Row(children: [
                IconButton(
                    onPressed: () {
                      sendMessage("26.8467° N", "80.9462° E");
                    },
                    icon: Icon(
                      Icons.location_searching,
                      color: Colors.pink,
                    )),
                Flexible(
                  child: TextField(
                    controller: messageController,
                    maxLines: null,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: "  Enter message"),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      sendMessage("", "");
                    },
                    icon: Icon(
                      Icons.send,
                      color: Colors.pink,
                    )),
              ]),
            ),
          ),
          SizedBox(
            height: 10,
          )
        ],
      )),
    );
  }
}
