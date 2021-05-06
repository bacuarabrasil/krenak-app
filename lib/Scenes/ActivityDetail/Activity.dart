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

class Activity {

  String title;
  String description;
  List<Task> tasks;
  List<Comment> comments;

  Activity({this.title, this.description, this.tasks, this.comments});

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      title: json['title'],
      description: json['description'],
      tasks: [],
      comments: []
    );
  }

}
