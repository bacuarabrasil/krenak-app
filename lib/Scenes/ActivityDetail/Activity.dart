class Author {
  String id;
  String firstName;

  Author({this.id, this.firstName});

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(id: json['id'].toString(), firstName: json['first_name']);
  }
}

class Comment {

  String id;
  Author author;
  String text;

  Comment({this.id, this.author, this.text});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(id: json['id'].toString(), author: Author.fromJson(json['author']), text: json['text']);
  }

}

class Task {

  String id;
  String title;
  bool done;

  Task({this.id, this.title, this.done});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(id: json['id'].toString(), title: json['title'], done: json['done']);
  }

}

class Activity {

  String id;
  String title;
  String description;
  String mentorship;
  List<Task> tasks;
  List<Comment> comments;

  Activity({this.id, this.title, this.description, this.mentorship, this.tasks, this.comments});

  factory Activity.fromJson(Map<String, dynamic> json) {
    var listTasks = json['tasks'] as List;
    List<Task> tasks = listTasks.map((i) => Task.fromJson(i)).toList();

    var listComments = json['comments'] as List;
    List<Comment> comments = listComments.map((i) => Comment.fromJson(i)).toList();
    return Activity(
      id: json['id'].toString(),
      title: json['title'],
      description: json['description'],
      mentorship: json['mentorship'].toString(),
      tasks: tasks,
      comments: comments
    );
  }

}
