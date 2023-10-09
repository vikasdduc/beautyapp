class ChatMessage {
  int? id;
  int? recpId;
  String? recpName;
  int? senderId;
  String? senderName;
  String? date;
  String? message;
  int? isView;
  String? createdAt;
  String? updatedAt;

  ChatMessage({
    this.id,
    this.recpId,
    this.recpName,
    this.senderId,
    this.senderName,
    this.date,
    this.message,
    this.isView,
    this.createdAt,
    this.updatedAt,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'],
      recpId: json['recp_id'],
      recpName: json['recp_name'],
      senderId: json['sender_id'],
      senderName: json['sender_name'],
      date: json['date'],
      message: json['message'],
      isView: json['is_view'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class ChatData {
  String? status;
  List<ChatMessage>? chat;

  ChatData({
    this.status,
    this.chat,
  });

  factory ChatData.fromJson(Map<String, dynamic> json) {
    var chatList = json['chat'] as List<dynamic>;
    List<ChatMessage> chatMessages = chatList
        .map((item) => ChatMessage.fromJson(item))
        .toList();

    return ChatData(
      status: json['status'],
      chat: chatMessages,
    );
  }
}
