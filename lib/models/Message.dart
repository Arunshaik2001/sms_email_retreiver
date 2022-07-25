

class Message{
  String body;
  String sender;
  DateTime dateSent;

  Message(this.body, this.sender,this.dateSent);

  Map<String, dynamic> toMap() {
    return {
      'body': body,
      'sender': sender,
      'dataSent': dateSent,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      map['body'] as String,
      map['sender'] as String,
      map['dataSent'] as DateTime
    );
  }
}