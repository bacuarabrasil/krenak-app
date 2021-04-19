import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:krenak/Services/Request/MeRequest.dart';
import 'package:krenak/Services/Request/SessionRequest.dart';
import 'package:krenak/Services/Response/LoginResponse.dart';
import 'package:krenak/Services/Response/MeResponse.dart';
import 'package:mockito/mockito.dart';

class DioAdapterMock extends Mock implements HttpClientAdapter {}

class SessionRequestMock implements SessionRequestType {
  @override
  Future<LoginResponse> execute() {
    return Future<LoginResponse>.value(
      LoginResponse(
        id: '',
        access: '',
        refresh: '',
        onboarding: ''
      )
    );
  }
}

void main() {
  group('MeRequest', () {
    final Dio dio = Dio();
    MeRequest meRequest;
    SessionRequestType sessionRequest;
    DioAdapterMock dioAdapterMock;

    setUp(() {
      dioAdapterMock = DioAdapterMock();
      dio.httpClientAdapter = dioAdapterMock;
      sessionRequest = SessionRequestMock();
      meRequest = MeRequest(dio, sessionRequest);
    });

    test('When request for me should return MeResponse', () async {
      final response = jsonEncode({
        'email': 'user@example.com',
        'first_name': 'string',
        'last_name': 'string',
        'birthdate': '2021-04-10'
      });

      final body = ResponseBody.fromString(response, 200, headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType]
      });

      when(dioAdapterMock.fetch(any, any, any))
        .thenAnswer((realInvocation) async => body);

      final subject = await meRequest.execute();
      final expected = MeResponse(
        email: 'user@example.com',
        firstName: 'string',
        lastName: 'string',
        birthdate: '2021-04-10'
      );

      expect(subject.email, expected.email);
      expect(subject.firstName, expected.firstName);
      expect(subject.lastName, expected.lastName);
      expect(subject.birthdate, expected.birthdate);
    });
  });
}
