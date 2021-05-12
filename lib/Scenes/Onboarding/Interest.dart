class Interest {
  String description;
  int id;

  Interest({this.description, this.id});

  factory Interest.fromJson(Map<String, dynamic> json) {
    return Interest(description: json['description'], id: json['id']);
  }
}
