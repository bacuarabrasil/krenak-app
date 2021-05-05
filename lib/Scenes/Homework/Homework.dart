class Comment {

  String id;
  String name;
  String text;

  Comment({this.id, this.name, this.text});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(id: json['id'], name: json['name'], text: json['text']);
  }

}

class Task {

  String title;
  bool done;

  Task({this.title, this.done});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(title: json['title'], done: json['done']);
  }

}

class Homework {

  String title;
  String description;
  List<Task> tasks;
  List<Comment> comments;

  Homework({this.title, this.description, this.tasks, this.comments});

  factory Homework.fromJson(Map<String, dynamic> json) {
    return Homework(
      title: json['title'],
      description: json['description'],
      tasks: [],
      comments: []
    );
  }

}
