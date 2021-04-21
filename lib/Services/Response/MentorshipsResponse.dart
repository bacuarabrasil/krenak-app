class Enrollee {
  final String firstName;
  final String lastName;

  Enrollee({this.firstName, this.lastName});

  factory Enrollee.fromJson(Map<String, dynamic> json) {
    return Enrollee(
      firstName: json['first_name'],
      lastName: json['last_name']
    );
  }
}

class Enrollment {
  final String resume;
  final Enrollee enrollee;

  Enrollment({this.resume, this.enrollee});

  factory Enrollment.fromJson(Map<String, dynamic> json) {
    return Enrollment(
      resume: json['resume'],
      enrollee: Enrollee.fromJson(json['enrollee'])
    );
  }
}

class Mentorship {
  final bool isActive;
  final Enrollment mentorEnrollment;
  final Enrollment menteeEnrollment;

  Mentorship({
    this.isActive,
    this.mentorEnrollment,
    this.menteeEnrollment
  });

  factory Mentorship.fromJson(Map<String, dynamic> json) {
    return Mentorship(
      isActive: json['is_active'],
      mentorEnrollment: Enrollment.fromJson(json['mentor_enrollment']),
      menteeEnrollment: Enrollment.fromJson(json['mentee_enrollment'])
    );
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
