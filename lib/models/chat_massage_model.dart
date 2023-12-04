class AppChatMassage {
  AppChatMassage({
    required this.id,
    this.sender,
    this.reciever,
    required this.text,
    this.fileURL,
    required this.date,
    this.replyId,
  });
  int id;
  int? sender;
  int? reciever;
  String text;
  String? fileURL;
  int date;
  int? replyId;

  AppChatMassage.fromMap(Map<String, dynamic> newItem)
      : id = newItem["id"],
        sender = newItem["sender"],
        reciever = newItem["reciever"],
        text = newItem["text"],
        fileURL = newItem["fileURL"],
        date = newItem["date"],
        replyId = newItem["replyId"];
  Map<String, dynamic> toMap() {
    return {
      "text": text,
      "fileURL": fileURL,
      "replyId": replyId,
    };
  }
}
