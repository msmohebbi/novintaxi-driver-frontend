class AppFAQ {
  AppFAQ({
    required this.id,
    required this.question,
    required this.answer,
    required this.priority,
    required this.date,
  });

  int id;
  String question;
  String answer;
  double priority;
  int date;

  AppFAQ.fromMap(Map<String, dynamic> newItem)
      : id = newItem["id"],
        question = newItem["question"],
        answer = newItem["answer"],
        priority = newItem["priority"],
        date = newItem["date"];
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "question": question,
      "answer": answer,
      "priority": priority,
      "date": date,
    };
  }
}
