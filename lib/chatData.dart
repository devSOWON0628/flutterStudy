import 'dart:core';
class ChatData implements Comparable<ChatData> {
  String userName;
  String message;
  String chatId;
  DateTime time;
  ChatData.name(this.userName, this.message, this.chatId, this.time);

  ChatData({this.userName, this.message, this.chatId, this.time});

  ChatData.fromSnapshot(ChatData chatData) :
        this.userName = chatData.userName,
        this.message = chatData.message,
        this.time = chatData.time,
        this.chatId = chatData.chatId;

  @override
  String toString() {
    return this.userName +":"+this.message+":"+ this.chatId+":"+ this.time.toString();
  }

  @override
  int compareTo(ChatData chatData) {
    if (this.time.compareTo(chatData.time)<0) {
      return -1;
    } else if (this.time.compareTo(chatData.time)>0) {
      return 1;
    }
    return 0;
    throw UnimplementedError();
  }

  Map<String, dynamic> toJson() =>
      {
        'name': this.userName,
        'message': this.message,
        'time': this.time
      };

}
