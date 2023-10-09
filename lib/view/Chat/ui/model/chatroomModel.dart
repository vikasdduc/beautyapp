class ChatRoomModel {
  String? chatroomid; //booking id
  Map<String, dynamic>? participants; //user id and partipants
  String? lastmessage;

  ChatRoomModel({this.chatroomid, this.participants, this.lastmessage});

  ChatRoomModel.fromMap(Map<String, dynamic> map) {
    chatroomid = map["chatroomid"];
    participants = map["participants"];
    lastmessage = map["lastmessage"];
  }

  Map<String, dynamic> toMap() {
    return {
     "chatroomid": chatroomid,
     "participants": participants,
     "lastMessage":lastmessage
    };
  }
}
