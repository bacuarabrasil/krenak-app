class Mentorship {
  final bool isActive;

  Mentorship({this.isActive});

  factory Mentorship.fromJson(Map<String, dynamic> json) {
    return Mentorship(isActive: json['is_active']);
  }
}

class MentorshipsResponse {
  final List<Mentorship> results;

  MentorshipsResponse({this.results});

  factory MentorshipsResponse.fromJson(Map<String, dynamic> json) {
    var list = json['results'] as List;
    List<Mentorship> results = list.map((i) => Mentorship.fromJson(i)).toList();

    return MentorshipsResponse(results: results);
  }
}
