import 'package:krenak/Scenes/ActivityDetail/Activity.dart';
import 'package:krenak/Scenes/Onboarding/Interest.dart';

class Enrollee {
  final String id;
  final String firstName;
  final String lastName;

  Enrollee({this.id, this.firstName, this.lastName});

  factory Enrollee.fromJson(Map<String, dynamic> json) {
    return Enrollee(
      id: json['id'].toString(),
      firstName: json['first_name'],
      lastName: json['last_name']
    );
  }
}

class Enrollment {
  final String resume;
  final Enrollee enrollee;
  final List<Interest> interests;

  Enrollment({this.resume, this.enrollee, this.interests});

  factory Enrollment.fromJson(Map<String, dynamic> json) {
    var list = json['interests'] as List;
    List<Interest> interests = list.map((i) => Interest.fromJson(i)).toList();

    return Enrollment(
      resume: json['resume'],
      enrollee: Enrollee.fromJson(json['enrollee']),
      interests: interests
    );
  }
}

class Mentorship {
  final String id;
  final bool isActive;
  final Enrollment mentorEnrollment;
  final Enrollment menteeEnrollment;
  final List<Activity> activities;

  Mentorship({
    this.id,
    this.isActive,
    this.mentorEnrollment,
    this.menteeEnrollment,
    this.activities
  });

  factory Mentorship.fromJson(Map<String, dynamic> json) {
    var list = json['activities'] as List;
    List<Activity> activities = list.map((i) => Activity.fromJson(i)).toList();
    return Mentorship(
      id: json['id'].toString(),
      isActive: json['is_active'],
      mentorEnrollment: Enrollment.fromJson(json['mentor_enrollment']),
      menteeEnrollment: Enrollment.fromJson(json['mentee_enrollment']),
      activities: activities
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
