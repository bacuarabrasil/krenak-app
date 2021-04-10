import 'package:krenak/Scenes/Onboarding/Interest.dart';

class InterestResponse {
  final List<Interest> results;

  InterestResponse({this.results});

  factory InterestResponse.fromJson(Map<String, dynamic> json) {
    var list = json['results'] as List;
    List<Interest> results = list.map((i) => Interest.fromJson(i)).toList();

    return InterestResponse(results: results);
  }
}
