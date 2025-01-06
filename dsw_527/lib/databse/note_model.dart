class Note {
  final int? id;
  final int userId;
  final String title;
  final String content;
  final String date;

  Note({
    this.id,
    required this.userId,
    required this.title,
    required this.content,
    required this.date,
  });

  // Konwersja obiektu Note na mapę
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'title': title,
      'content': content,
      'date': date,
    };
  }

  // Konwersja mapy na obiekt Note
  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      userId: map['user_id'],
      title: map['title'],
      content: map['content'],
      date: map['date'],
    );
  }
}
