import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:krenak/Scenes/Login/Login.dart';
import 'package:krenak/Services/Request/LoginRequest.dart';
import 'package:krenak/Services/Response/LoginResponse.dart';
import 'package:mockito/mockito.dart';

class DioAdapterMock extends Mock implements HttpClientAdapter {}

void main() {
  group('LoginRequest', () {
    final Dio dio = Dio();
    LoginRequest loginRequest;
    DioAdapterMock dioAdapterMock;

    setUp(() {
      dioAdapterMock = DioAdapterMock();
      dio.httpClientAdapter = dioAdapterMock;
      loginRequest = LoginRequest(dio);
    });

    test('When request for login should return LoginResponse', () async {
      final credentials = Login(email: 'user@example.com', password: 'stringstring');
      final response = jsonEncode({ 'access': 'string', 'refresh': 'string' });

      final body = ResponseBody.fromString(response, 200, headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType]
      });

      when(dioAdapterMock.fetch(any, any, any))
        .thenAnswer((realInvocation) async => body);

      final subject = await loginRequest.execute(credentials);
      final expected = LoginResponse(access: 'string', refresh: 'string');

      expect(subject.access, expected.access);
      expect(subject.refresh, expected.refresh);
    });
  });
}
