class MessageModel {
  String? text;
  String? senderId;
  String? dateTime;
  String? reciverId;

  MessageModel({
    required this.text,
    required this.senderId,
    required this.dateTime,
    required this.reciverId,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    senderId = json['senderId'];
    dateTime = json['dateTime'];
    reciverId = json['reciverId'];
  }
  Map<String, dynamic> toMap() {
    return {
      "text": text,
      "senderId": senderId,
      "reciverId": reciverId,
      "dateTime": dateTime,
    };
  }
}
